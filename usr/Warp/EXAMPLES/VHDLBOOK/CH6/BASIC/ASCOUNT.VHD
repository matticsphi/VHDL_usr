--   Synchronous Counter of Generic Size
--    
--   CounterSize -- size of counter
--
--   clk    -- posedge clock input
--   areset -- asynchronous reset
--   sreset -- active high input resets counter to 0
--   enable -- active high input enables counting
--   count  -- counter output
---------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.std_arith.all;
entity ascount is 
	generic (CounterSize: integer := 2);
	port(	clk, areset, sreset, enable: in std_logic;
		count:    			buffer std_logic_vector(counterSize-1 downto 0));
end ascount;
architecture archascount of ascount is
begin
p1: process (areset, clk) begin
	if areset = '1' then
		count <= (others => '0');
	elsif (clk'event and clk='1') then
		if sreset='1' then
			count <= (others => '0');
		elsif enable = '1' then
			count <= count + 1;
		else
			count <= count;
		end if;
	end if;
  end process;
end archascount;
