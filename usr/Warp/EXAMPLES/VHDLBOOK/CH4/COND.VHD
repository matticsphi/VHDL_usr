library ieee;
use ieee.std_logic_1164.all;
entity break1 is port(
	a, b, c, d: 	in std_logic;
	j, k:			in std_logic;
	x:			out std_logic);
end break1;
architecture conditional of break1 is
	signal func1, func2, func3, func4: std_logic;
begin
	func1 <= j or k;
	func2 <= j and k;
	func3 <= j xor k;
	func4 <= j xnor k;

p1: process (a, b, c, d, j, k)
	begin
		if a = '1' then
			x <= func1;
		elsif b = '1' then
			x <= func2;
		elsif c = '1' then
			x <= func3;
		elsif d = '1' then
			x <= func4;
		else
			x <= '-';
		end if;
	end process;
end;
