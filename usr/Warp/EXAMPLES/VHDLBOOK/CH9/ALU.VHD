library ieee;
use ieee.std_logic_1164.all;
use work.numeric_std.all;
use work.mnemonics.all;
entity alu is port (
	r, s:			in unsigned(3 downto 0);
	c_n:			in std_logic;
	alu_ctl:		in std_logic_vector(2 downto 0);
	f:			buffer unsigned(3 downto 0);
	g_bar, p_bar:	buffer std_logic; 
	c_n4:			buffer std_logic;
	ovr:			buffer std_logic);
end alu;
architecture alu of alu is
	signal r1, s1: unsigned(4 downto 0); 
	signal addR, addcR, f1: unsigned(4 downto 0);		
begin
-- define the operands to the adder
operands: process (r, s, c_n, alu_ctl)
	begin
		case alu_ctl is
			when subr => -- subtraction same as 2's comp addn
					r1 <= ('0', r(3), r(2), r(1), r(0));
					s1 <= not ('0', s(3), s(2), s(1), s(0));
			when subs =>
					r1 <= not ('0', r(3), r(2), r(1), r(0));
					s1 <= ('0', s(3), s(2), s(1), s(0));
			when others => 	
					r1 <= ('0', r(3), r(2), r(1), r(0));
					s1 <= ('0', s(3), s(2), s(1), s(0));
		end case;
	end process;
-- describe the arithmetic operations
	addR <= r1 + s1;
	addcR <= addR + 1;
-- multiplex the results for desired output
mux: process (r1, s1, addr, addcR, alu_ctl)
	begin
		case alu_ctl is
			when add => 
				if c_n = '0' then
					f1 <= addR;
				else
					f1 <= addcR;
				end if;	
			when subr => -- subtraction same as 2's comp addn
				if c_n = '0' then
					f1 <= addR;
				else 	
					f1 <= addcR;
				end if;
			when subs =>
				if c_n = '0' then 
					f1 <= addcR;
				else
					f1 <= addr;
				end if;
			when orrs => 	f1 <= r1 or s1;
			when andrs => 	f1 <= r1 and s1;
			when notrs =>	f1 <= not r1 and s1;
			when exor =>	f1 <= r1 xor s1;
			when exnor =>	f1 <= r1 xnor s1; 
			when others => 	f1 <= "-----";
		end case;
	end process;
f <= f1(3 downto 0);
c_n4 <= f1(4);
g_bar <= not (
			(r(3) and s(3)) or
			((r(3) or s(3)) and (r(2) and s(2))) or
			((r(3) or s(3)) and (r(2) or s(2)) and (r(1) and s(1))) or
			((r(3) or s(3)) and (r(2) or s(2)) and (r(1) or s(1)) and (r(0) and s(0))));
p_bar <= not (
(r(3) or s(3)) and (r(2) or s(2)) and (r(1) and s(1)) and (r(0) and s(0)));
ovr <= '1' when (f1(4) /= f1(3)) else '0';
end alu;
