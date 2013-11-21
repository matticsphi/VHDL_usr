library ieee;
use ieee.std_logic_1164.all;
use work.std_arith.all;
entity counter is port(
clk, rsta,rstb,lda,ldb: in std_logic;
        cnta, cntb:     buffer std_logic_vector(15 downto 0));
end counter;

architecture archcounter of counter is
begin

upcnta: process (clk, rsta)
        begin
                if rsta = '1' then           --async reset #1
                        cnta <= x"3261";
                elsif (clk'event and clk= '1') then
                        if lda = '1' then
                           cnta <= cntb;
                        else
                           cnta <= cnta + 1;
                        end if;
                end if;
        end process upcnta;

upcntb: process (clk, rstb)
        begin
                if rstb = '1' then            --async reset #2
                        cntb <= x"5732";
                elsif (clk'event and clk= '1') then
                        if ldb = '1' then
                                cntb <= cntb;
                        else
                                cntb <= cntb + 1;
                        end if;
                end if;
        end process upcntb;
end archcounter;
