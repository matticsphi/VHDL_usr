library ieee;
use ieee.std_logic_1164.all;
USE work.STD_ARITH.all;

entity counter is port (
	clk: 	in std_logic;
	count: 	buffer std_logic_vector(3 downto 0);
	x: 	out std_logic);
end counter;

architecture archcounter of counter is 
begin
proc1:	process (clk)
	begin
		if (clk'event and clk = '1') then
			count <= count + 1;
		end if;
	end process proc1;
	x <= '1' when count = "1001" else '0';
end archcounter;
