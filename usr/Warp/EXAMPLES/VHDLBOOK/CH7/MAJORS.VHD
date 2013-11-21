library ieee;
use ieee.std_logic_1164.all;

package majorities is
-- majority for 3 single bit/std_logic inputs
	function majority (a, b, c: bit) return bit;
	function majority (a, b, c: std_logic) return std_logic;
-- majority for 4 single bit/std_logic inputs
	function majority (a, b, c, d: bit) return bit;
	function majority (a, b, c, d: std_logic) return std_logic;
-- majority for 2, 3, or 4 inputs as bit_vector/std_logic_vector
	function majority (vec: bit_vector) return bit;
	function majority (vec:std_logic_vector) return std_logic;
end majorities;

package body majorities is
-- majority for 3 single bit/std_logic inputs
-- Function #1
	function majority (a, b, c: bit) return bit is
	begin
		return ((a and b) or (a and c) or (b and c));
	end majority;

-- Function #2
	function majority (a, b, c: std_logic) return std_logic is
	begin
		return ((a and b) or (a and c) or (b and c));
	end majority;

-- majority for 4 single bit/std_logic inputs
-- Function #3
	function majority (a, b, c, d: bit) return bit is
	begin
		return ((a and b and c) or (a and b and d) or
					(a and c and d) or (b and c and d));
	end majority;

-- Function #4
	function majority (a, b, c, d: std_logic) return std_logic is
	begin
		return ((a and b and c) or (a and b and d) or
					(a and c and d) or (b and c and d));
	end majority;

-- majority for 2, 3, or 4 bit_vector/std_logic_vector inputs
-- Function #5
	function majority (vec: bit_vector) return bit is
		variable a: bit_vector(vec'length - 1 downto 0);
	begin
		a := vec;
		if a'length = 2 then
			return (a(0) or a(1));
		elsif a'length = 3 then	--a'length mut excl.; no priority
			return ((a(0) and a(1)) or (a(0) and a(2)) or (a(1) and a(2)));
		elsif a'length = 4 then
			return ((a(0) and a(1) and a(2)) or (a(0) and a(1) and a(3)) or
					(a(0) and a(2) and a(3)) or (a(1) and a(2) and a(3)));
		else
			assert (false)
				report "Majority function only supports 2, 3, or 4 inputs."
				severity warning;
			return ('0');
		end if;
	end majority;

-- Function #6
	function majority (vec:std_logic_vector) return std_logic is
		variable a: std_logic_vector(vec'length - 1 downto 0);
	begin
		a := vec;
		if a'length = 2 then
			return (a(0) or a(1));
		elsif a'length = 3 then	--a'length mut excl.; no priority
			return ((a(0) and a(1)) or (a(0) and a(2)) or (a(1) and a(2)));
		elsif a'length = 4 then
			return ((a(0) and a(1) and a(2)) or (a(0) and a(1) and a(3)) or
					(a(0) and a(2) and a(3)) or (a(1) and a(2) and a(3)));
		else
			assert (false)
				report "Majority function only supports 2, 3, or 4 inputs."
				severity warning;
			return('0');
		end if;
	end majority;

end majorities;
