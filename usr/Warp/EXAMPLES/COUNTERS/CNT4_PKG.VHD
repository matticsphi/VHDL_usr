library ieee;
use ieee.std_logic_1164.all;

package counter_pkg is
	subtype nibble is std_logic_vector(3 downto 0);
	component upcnt port(
		clk: 	in std_logic;
		count: 	buffer nibble);
	end component;
end counter_pkg;

library ieee;
use ieee.std_logic_1164.all;
USE work.STD_ARITH.all;
use work.counter_pkg.all;

entity upcnt is port(
	clk: in std_logic;
	count: buffer nibble);
end upcnt;

architecture archupcnt of upcnt is
begin
counter:process (clk)
	begin
		if (clk'event and clk='1') then
			count <= count + 1;
		end if;
	end process counter;
end archupcnt;









