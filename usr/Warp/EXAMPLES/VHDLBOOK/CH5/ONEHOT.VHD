library ieee;
use ieee.std_logic_1164.all;
entity machine is port(
	clk, rst: 					in std_logic;
	addr, cnt:					in std_logic_vector(15 downto 0);
	ads,rdy, ref, read, burst:	in std_logic;
	set:						buffer std_logic_vector(4 downto 0));
end machine;
architecture machine of machine is
	type states is (s0, s1, s20, s21, s22, s23, s24, s30, s31, s32, s33, s34,
		s35, s36, s37, s40, s41);
	attribute state_encoding of states:type is one_hot_one;
	signal present_state, next_state: states;
begin
p1: process (addr, rdy, ref, read, burst, present_state)
	begin
		case present_state is
			when s0 =>
				if addr = "1010101010101010" and ads = '1' then
					next_state <= s1;
				end if;
			when s1 =>
				if ref = '1' then
					next_state <= s40;
				elsif (rdy and not ref and read) = '1' then
					next_state <= s30;
				elsif (rdy and not ref and not read) = '1' then
					next_state <= s20;
				end if;
			when s20 =>
				next_state <= s21;
			when s21 =>
				if (rdy and not burst) = '1' then
					next_state <= s0;
				elsif (rdy and burst) = '1' then
					next_state <= s22;
				end if;
			when s22 => next_state <= s23;
			when s23 => next_state <= s24;
			when s24 =>
				if rdy = '1' then
					next_state <= s0;
				end if;
			when s30 => next_state <= s31;
			when s31 =>
				if (rdy and not burst) = '1' then 
					next_state <= s0;
				elsif (rdy and burst) = '1' then
					next_state <= s32;
				end if;
			when s32 => next_state <= s33;
			when s33 =>
					if rdy = '1' then
						next_state <= s34;
					end if;
			when s34 => next_state <= s35;
			when s35 =>
					if rdy = '1' then 
						next_state <= s36;
					end if;
			when s36 => next_state <= s37;
			when s37 =>
					if rdy = '1' then 
						next_state <= s0;
					end if;
			when s40 => next_state <= s41;
			when s41 =>
				if cnt = "1111111100000001" then
					next_state <= s0;
				end if;
		end case;
	end process;

p2: process (clk, rst)
	begin
		if rst = '1' then
			present_state <= s0;
		elsif clk'event and clk = '1' then
			present_state <= next_state;
		end if;
	end process;

p3: process (present_state)
	begin
		set <= "00000";
		case present_state is
			when s0 =>
				set(0) <= '1';
			when s1 =>
				set(1) <= '1';
			when s20 | s21 | s22 | s23 | s24 =>
				set(2) <= '1';
			when s30 | s31 | s32 | s33 | s34 | s35 | s36 | s37 =>
				set(3) <= '1';
			when s40 | s41 =>
				set(4) <= '1';
		end case;
	end process;
end;
