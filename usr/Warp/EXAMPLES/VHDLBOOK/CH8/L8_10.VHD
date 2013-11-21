library ieee; 
use ieee.std_logic_1164.all;
entity p_terms is port(				
	a, b, c, d, e, f, g, h, i, j, k, l:	in std_logic;
	x:							out std_logic);
end p_terms;
architecture p_terms of p_terms is
begin
	x <= 		(a and b) xor (c or d) xor (e and f) xor (g or h) xor
			 (i and j) xor (k or l);
end;
