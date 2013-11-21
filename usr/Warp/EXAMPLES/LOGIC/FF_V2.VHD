library ieee;
use ieee.std_logic_1164.all;

entity registered is port( 
	d, clk: in std_logic;
	q:	out std_logic);
end registered;

architecture archregistered of registered is
begin
reg:	process (clk)
	begin
		if (clk'event and clk= '1') then
			q <= d;
		end if;
	end process reg;
end archregistered;
