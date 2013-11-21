-- eqcomp4 is a four bit equality comparator
library ieee;
use ieee.std_logic_1164.all;
entity eqcomp4 is
port (a, b: 	in std_logic_vector(3 downto 0);
	equals:	out std_logic);
end eqcomp4;

architecture dataflow of eqcomp4 is
begin
	equals <= '1' when (a = b) else '0';		   -- equals is active high
end dataflow;
