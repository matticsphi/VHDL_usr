library ieee;
use ieee.std_logic_1164.all;
package mycntpkg is
  component count port(clk, rst: in std_logic;
                       cnt:      inout std_logic_vector(2 downto 0));
  end component;
end mycntpkg;

library ieee;
use ieee.std_logic_1164.all;
entity count is port(clk, rst:  in std_logic;
                     cnt:       inout std_logic_vector(2 downto 0));
end count;

use work.std_arith.all;
architecture archcount of count is
begin
counter: process (clk, rst)
begin
        if rst = '1' then
                cnt <= (others => '0');
        elsif (clk'event and clk= '1') then
                cnt <= cnt + 1;
        end if;
end process;
end archcount;
