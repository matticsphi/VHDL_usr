library ieee;
use ieee.std_logic_1164.all;
entity do_care is port(
	s: in std_logic_vector(1 downto 0);
	y: buffer std_logic);
end do_care;

architecture extra_logic of do_care is
begin
logic_minimization: process (s)
begin
	if s = "00" or s = "11" then
		y <= '1';
	elsif s = "01" then
		y <= '0';
	else
		y <= '0';
	end if;
end process;
end;
