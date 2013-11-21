library ieee ;
use ieee.std_logic_1164.all ;

entity mux is port(
	a, b, c, d:	in std_logic_vector(3 downto 0);
	s:		in std_logic_vector(1 downto 0);
	x:		out std_logic_vector(3 downto 0));
end mux;

use work.lpmpkg.all ;
architecture archmux of mux is
	signal tmpBus : std_logic_vector(
			((2**s'length * a'length) - 1)	downto 0) ;
begin
	tmpBus <= d & c & b & a ;			-- Collect all inputs
	mux_array: Mmux
		generic map(
			lpm_width => a'length,		-- Width of each input
			lpm_size => (2**s'length),	-- Number of inputs
			lpm_widths => s'length,		-- Number of selectors
			lpm_hint => speed)
		port map(
			data => tmpBus,
			sel => s,
			result => x);
end archmux;
