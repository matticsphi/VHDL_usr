library ieee;
use ieee.std_logic_1164.all;
USE work.STD_ARITH.all;
use work.counter_pkg.all;

entity counters is port(
	clk1, clk2: 		in std_logic;
	acnt, bcnt, ccnt: 	buffer nibble);
end counters;

architecture archcounters of counters is
begin
counter1: upcnt port map (clk1, acnt);
counter2: upcnt port map (clk2, bcnt);
counter3: upcnt port map (clk => clk1, count => ccnt);
end archcounters;
