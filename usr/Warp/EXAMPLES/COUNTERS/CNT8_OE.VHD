library ieee;
use ieee.std_logic_1164.all;
USE work.STD_ARITH.all;

entity ldcnt is port (
	clk, ld, oe:	in std_logic;
	count_out:	inout std_logic_vector(7 downto 0));
end ldcnt;

architecture archldcnt of ldcnt is
	signal count, data:	std_logic_vector(7 downto 0);
begin
counter: process (clk)
	begin
		if (clk'event and clk='1') then
			if ld = '1' then
				count <= data;
			else
				count <= count + 1;
			end if;
		end if;
	end process counter;
	count_out <= count when (oe = '1') else "ZZZZZZZZ" ;
	data <= count_out ;
end archldcnt;


