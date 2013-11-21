--      pregister Library
--	sizes: (1,size)
--
--      clk     -- posedge clock input
--      preset   -- asynchronous preset
--      load    -- active high input loads pregister
--      d       -- pregister input
--      q       -- pregister output
-----------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity preg1 is port(
        clk, preset, load:      in std_logic;
        d:              in std_logic;
        q:              buffer std_logic);
end preg1;
architecture archpreg1 of preg1 is
begin
        p1: process (preset, clk) begin
                if preset = '1' then
                       q <= '1';
                elsif (clk'event and clk='1') then
                        if load = '1' then
                                q <= d;
                        else
                                q <= q;
                        end if;
                end if;
        end process;
end archpreg1;
----------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
entity preg is 
	generic(size: integer := 2);
	port( 	clk, preset, load:      in std_logic;
	        d:              in std_logic_vector(size-1 downto 0);
       		q:              buffer std_logic_vector(size-1 downto 0));
end preg;
architecture archpreg of preg is
begin
        p1: process (preset,clk) begin
                if preset = '1' then
                        q <= (others => '1');
                elsif (clk'event and clk='1') then
                        if load = '1' then
                                q <= d;
                        else
                                q <= q;
                        end if;
                end if;
        end process;
end archpreg;

