library ieee; 
use ieee.std_logic_1164.all;
entity p_terms is port(
		a, b, c, d, e, f, g, h, i, j, k, l:		in std_logic;
		x:								out std_logic);
end p_terms;
architecture p_terms of p_terms is
	signal x1, x2, x3: std_logic;
	attribute synthesis_off of x1,x2,x3:signal is true;
begin
	x1 <= (a and b) xor (c or d);
	x2 <= (e and f) xor (g or h);
	x3 <= (i and j) xor (k and l);
	x <= x1 xor x2 xor x3;
end;
