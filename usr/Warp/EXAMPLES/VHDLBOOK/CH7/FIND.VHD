library ieee;
use ieee.std_logic_1164.all;
entity find_majority is port(
	a, b, c, d: in bit;
	e: in bit_vector(1 downto 0);
	f: in bit_vector(2 downto 0);
	g: in bit_vector(3 downto 0);
	h, i, j, k: in std_logic;
	l: in std_logic_vector(1 downto 0);
	m: in std_logic_vector(2 downto 0);
	n: in std_logic_vector(3 downto 0);
	o: in bit_vector(4 downto 0);
	p: in std_logic_vector(7 downto 0);
	x1, x3, x5, x6, x7, x11: out bit;
	x2, x4, x8, x9, x10, x12: out std_logic);	
end find_majority;

use work.majorities.all;
architecture find_majority of find_majority is
begin
-- requires function #1:
x1 <= majority(a, b, c);
-- requires function #2:
x2 <= majority(h, i, j);
-- requires function #3:
x3 <= majority(a, b, c, d);
-- requires function #4:
x4 <= majority(h, i, j, k);
-- require function #5:
x5 <= majority(e);
x6 <= majority(f);
x7 <= majority(g);
-- require function #6:
x8 <= majority(l);
x9 <= majority(m);
x10 <= majority(n);
-- require function #5 or function #6, but result in compile 
-- time warning and function always returning '0':
x11 <= majority(o);
x12 <= majority(p);
end;
