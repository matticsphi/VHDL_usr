library ieee;
use ieee.std_logic_1164.all;

entity mux is port(
	a, b, c, d:	in std_logic_vector(3 downto 0);
	s:		in std_logic_vector(1 downto 0);
	x:		out std_logic_vector(3 downto 0));
end mux;

architecture archmux of mux is
begin
mux4_1:	process (a, b, c, d)
	begin
		if s = "00" then
			x <= a;	
		elsif s = "01" then
			x <= b;
		elsif s = "10" then
			x <= c;
		else
			x <= d;
		end if;
	end process mux4_1;
end archmux;
