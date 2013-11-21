library ieee;
use ieee.std_logic_1164.all;

entity registered is port( 
	d, clk: in std_logic;
	q:	out std_logic);
end registered;

use work.rtlpkg.all;
architecture archregistered of registered is
begin
reg:	dff port map(d, clk, q);
end archregistered;
