library ieee;
use ieee.std_logic_1164.all;
entity break1 is port(
	a, b, c, d: 	in std_logic;
	j, k:			in std_logic;
	x:			out std_logic);
end break1;
architecture exclusive of break1 is
	signal func1, func2, func3, func4: std_logic;
begin
	func1 <= j or k;
	func2 <= j and k;
	func3 <= j xor k;
	func4 <= j xnor k;

p1: process (a, b, c, d, j, k)
		subtype select_type is std_logic_vector(3 downto 0);
	begin
		case select_type'(a & b & c & d) is	-- qualified expression
			when "1000" => x <= func1;
			when "0100" => x <= func2;
			when "0010" => x <= func3;
			when "0001" => x <= func4;
			when others => x <= '-';
		end case;
	end process;
end;
