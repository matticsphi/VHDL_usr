--      Register Set  
--      sizes: (size) a generic
--
--      clk     -- posedge clock input
--      rst     -- asynchronous reset
--      pst     -- asynchronous preset
--      load    -- active high input loads register
--      d       -- register input
--      q       -- register output
----------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
entity reg is generic ( size: integer := 2);
	port(   clk, load:      in std_logic;
		rst, pst:       in std_logic;
		d:              in std_logic_vector(size-1 downto 0);
		q:              buffer std_logic_vector(size-1 downto 0));
end reg;
architecture archreg of reg is
begin
	p1: process (clk) begin
		if rst = '1' then
			q <= (others => '0');
		elsif pst = '1' then
			q <= (others => '1');
		elsif (clk'event and clk='1') then
			if load = '1' then
				q <= d;
			else
				q <= q;
			end if;
		end if;
	end process;
end archreg;

