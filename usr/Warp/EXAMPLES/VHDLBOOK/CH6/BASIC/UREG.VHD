--      Set of registers (unsigned)
--      sizes: (1,size)
--
--      clk     -- posedge clock input
--      reset   -- asynchronous reset
--      load    -- active high input loads rregister
--      d       -- register input
--      q       -- register output
----------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.numeric_std.all;
entity ureg is
        generic (size: integer := 2);
        port(   clk, reset, load:	in std_logic;
                d:              	in unsigned(size-1 downto 0);
                q:              	buffer unsigned(size-1 downto 0));
end ureg;
architecture archureg of ureg is
begin
        p1: process (reset,clk) begin
                if reset = '1' then
                        q <= (others => '0');
                elsif (clk'event and clk='1') then
                        if load = '1' then
                                q <= d;
                        else
                                q <= q;
                        end if;
                end if;
        end process;
end archureg;
