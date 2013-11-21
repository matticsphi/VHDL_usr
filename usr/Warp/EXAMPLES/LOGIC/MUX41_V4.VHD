library ieee;
use ieee.std_logic_1164.all;

entity mux is port(
	a, b, c, d:	in std_logic_vector(3 downto 0);
	s:		in std_logic_vector(1 downto 0);
	x:		out std_logic_vector(3 downto 0));
end mux;

architecture archmux of mux is
begin
    x(3) <=     (a(3) and not(s(1)) and not(s(0)))
            OR  (b(3) and not(s(1)) and s(0))
            OR  (c(3) and s(1) and not(s(0)))
            OR  (d(3) and s(1) and s(0));

    x(2) <=     (a(2) and not(s(1)) and not(s(0)))
            OR  (b(2) and not(s(1)) and s(0))
            OR  (c(2) and s(1) and not(s(0)))
            OR  (d(2) and s(1) and s(0));

    x(1) <=     (a(1) and not(s(1)) and not(s(0)))
            OR  (b(1) and not(s(1)) and s(0))
            OR  (c(1) and s(1) and not(s(0)))
            OR  (d(1) and s(1) and s(0));

    x(0) <=     (a(0) and not(s(1)) and not(s(0)))
            OR  (b(0) and not(s(1)) and s(0))
            OR  (c(0) and s(1) and not(s(0)))
            OR  (d(0) and s(1) and s(0));

end archmux;
