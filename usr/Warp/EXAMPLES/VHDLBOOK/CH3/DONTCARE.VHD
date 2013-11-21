library ieee;
use ieee.std_logic_1164.all;
entity good_synthesis is port(
	s: in std_logic_vector(1 downto 0);
	y: buffer std_logic);
end good_synthesis;

architecture useful of good_synthesis is
begin
logic_minimization: process (s)
begin
	if s = "00" or s = "11" then
		y <= '1';
	elsif s = "01" then
		y <= '0';
	else
		y <= '-';
	end if;
end process;
end;
