library ieee;
use ieee.std_logic_1164.all;
entity counter is port(
    clk, rsta,rstb:     in std_logic;
    ld, en, by1:        in std_logic;
    cnta, cntb:         buffer std_logic_vector(15 downto 0));
end counter;

use work.std_arith.all;
architecture archcounter of counter is
begin

upcnta: process (clk, rsta)
    begin
        if rsta = '1' then
            cnta <= x"0000";
        elsif (clk'event and clk= '1') then
            if ld = '1' then
                cnta <= cntb;
            elsif en = '1' then
                if by1 = '1' then
                    cnta <= cnta + 1;
                else
                    cnta <= cnta + 2;
                end if;
            else
                cnta <= cnta;
            end if;
        end if;
    end process upcnta;

upcntb: process (clk, rstb)
    begin
        if rstb = '1' then
            cntb <= x"0000";
        elsif (clk'event and clk= '1') then
            if ld = '1' then
                cntb <= cntb;
            elsif en = '1' then
                if by1 = '1' then
                    cntb <= cntb + 1;
                else
                    cntb <= cntb + 2;
                end if;
            else
                cntb <= cntb;
            end if;
        end if;
    end process upcntb;
end archcounter;
