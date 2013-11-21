library ieee;
use ieee.std_logic_1164.all;
use work.std_arith.all;
entity counter is port(
        clk, rsta, rstb:	in std_logic;
        cnta, cntb:     	buffer std_logic_vector(15 downto 0));
end counter;
 
architecture archcounter of counter is
begin

upcnta: process (clk, rsta, rstb)
        begin
                if (rsta = '1' or rstb = '1') then  --OR term async rst
                        cnta <= x"0001";
                elsif (clk'event and clk= '1') then
                        cnta <= cnta + 1;
                end if;
        end process upcnta;

upcntb: process (clk, rsta, rstb)
        begin
                if (rsta = '1' or rstb = '1') then  --OR term async rst
                        cntb <= x"0002";
                elsif (clk'event and clk= '1') then
                        cntb <= cntb + 1;
                end if;
        end process upcntb;
end archcounter;
