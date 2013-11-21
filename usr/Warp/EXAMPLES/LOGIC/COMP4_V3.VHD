library ieee;
use ieee.std_logic_1164.all;

entity compare is port(
	a, b:	in std_logic_vector(0 to 3);
	aeqb:	out std_logic);
end compare;

architecture archcompare of compare is
begin
	aeqb <= NOT( 
		(a(0) xor b(0)) OR 
		(a(1) xor b(1)) OR 
		(a(2) xor b(2)) OR 
		(a(3) xor b(3)));
end;
