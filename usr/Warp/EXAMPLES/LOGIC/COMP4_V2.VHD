library ieee;
use ieee.std_logic_1164.all;

entity compare is port(
	a, b:	in std_logic_vector(0 to 3);
	aeqb:	out std_logic);
end compare;

USE work.STD_ARITH.all;
architecture archcompare of compare is
begin
	aeqb <= '1' when (a = b) else '0';
end;
