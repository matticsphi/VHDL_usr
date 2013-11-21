library ieee;
use ieee.std_logic_1164.all;

entity compare is port(
	a, b:	in std_logic_vector(0 to 3);
	aeqb:	out std_logic);
end compare;

USE work.STD_ARITH.all;
architecture archcompare of compare is
begin
comp:	process (a, b)
	begin
		if a = b then
			aeqb <= '1';
		else
			aeqb <= '0';
		end if;
	end process comp;
end archcompare;
