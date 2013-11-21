library ieee;
use ieee.std_logic_1164.all;

entity moore1 is port(
	clk, rst:	in std_logic;
	id:		in std_logic_vector(3 downto 0);
	y:		out std_logic_vector(1 downto 0));
end moore1;

architecture archmoore1 of moore1 is
	signal state: std_logic_vector(2 downto 0);
-- State assignment is such that 2 LSBs are outputs
constant state0: std_logic_vector(2 downto 0) := "000";
constant state1: std_logic_vector(2 downto 0) := "010";
constant state2: std_logic_vector(2 downto 0) := "011";
constant state3: std_logic_vector(2 downto 0) := "110";
constant state4: std_logic_vector(2 downto 0) := "111";
begin
moore: process (clk, rst) 
	begin
		if rst='1' then 
			state <= state0;
		elsif (clk'event and clk='1') then
			case state is
				when state0 =>
					if id = x"3" then
						state <= state1;
					else
						state <= state0;
					end if;
				when state1 =>
					state <= state2;
				when state2 =>
					if id = x"7" then
						state <= state3;
					else
						state <= state2;
					end if;
				when state3 =>
					if id < x"7" then 
						state <= state0;
					elsif id = x"9" then
						state <= state4;
					else
						state <= state3;
					end if;
				when state4 =>
					if id = x"b" then
						state <= state0;
					else
						state <= state4;
					end if;
				when others =>
					state <= state0;
			end case;
		end if;
	end process;

--assign state outputs (equal to state std_logics)
y <= state(1 downto 0);
end archmoore1;
