library ieee;
use ieee.std_logic_1164.all;
entity eqcomp4 is port(
    a, b:   in std_logic_vector(3 downto 0);
    equals: out std_logic);
end eqcomp4;

architecture bool of eqcomp4 is
begin
	equals <=	 		not(a(0) xor b(0))
			and		not(a(1) xor b(1)) 
			and		not(a(2) xor b(2)) 
			and		not(a(3) xor b(3));
end bool;
