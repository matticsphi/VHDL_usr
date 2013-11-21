library ieee;
use ieee.std_logic_1164.all;
use work.std_arith.all;
entity magnitude is port(
	a, b:	in std_logic_vector(7 downto 0);
	agrb:	buffer std_logic);
end magnitude;
architecture comparator of magnitude is
begin
	agrb <= '1' when a > b else '0';
end;
