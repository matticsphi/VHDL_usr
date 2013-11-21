-- This design is not completed. It is left as an exercise for
-- the reader to complete this clock multiplexer.

library ieee, basic;
use ieee.std_logic_1164.all;
use basic.regs_pkg.all;

entity clockmux8 is port (
	areset           : in std_logic;        -- Asynch Reset
	clk1             : in std_logic;        -- Clock 1
	clk2             : in std_logic;        -- Clock 2
	clk3             : in std_logic;        -- Clock 3
	clk4             : in std_logic;        -- Clock 4
	clk5             : in std_logic;        -- Clock 5
	clk6             : in std_logic;        -- Clock 6
	clk7             : in std_logic;        -- Clock 7
	clk8             : in std_logic;        -- Clock 8
	clk9             : in std_logic;        -- Clock 9
	sel1             : in std_logic;        -- Clock Select 1
	sel2             : in std_logic;        -- Clock Select 2
	sel3             : in std_logic;        -- Clock Select 3
	sel4             : in std_logic;        -- Clock Select 4
	sel5             : in std_logic;        -- Clock Select 5
	sel6             : in std_logic;        -- Clock Select 6
	sel7             : in std_logic;        -- Clock Select 7
	sel8             : in std_logic;        -- Clock Select 8
	sel9             : in std_logic;        -- Clock Select 9
	rxclk            : buffer std_logic);      -- RX Clock
end clockmux8;


