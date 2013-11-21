--      Synchronizers
--
--
--      clk    -- posedge clock input
--      reset  -- asynchronous reset (rsynch)
--      preset -- asynchronous preset (psynch)
--      d      -- signal to synchronize
--      q      -- synchronized
----------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
entity rsynch is port (
	clk, reset:     in std_logic;
	d:              in std_logic; 
	q:              buffer std_logic); 
end rsynch;

architecture archrsynch of rsynch is
  signal temp: std_logic;
begin
p1: process (reset, clk) begin
	if reset = '1' then
		q <= '0';
	elsif (clk'event and clk='1') then
		temp <= d;
		q <= temp;
	end if;
   end process;
end archrsynch;

-----------------------
library ieee;
use ieee.std_logic_1164.all;
entity psynch is port (
	clk, preset:    in std_logic;
	d:              in std_logic; 
	q:              buffer std_logic); 
end psynch;

architecture archpsynch of psynch is
  signal temp: std_logic;
begin
p1: process (preset, clk) begin
	if preset = '1' then
		q <= '1';
	elsif (clk'event and clk='1') then
		temp <= d;
		q <= temp;
	end if;
   end process;
end archpsynch;
