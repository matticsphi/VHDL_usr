library ieee;
use ieee.std_logic_1164.all;
use work.numeric_std.all;
entity cnt8 is port(
        txclk, grst, gpst:      in std_logic;
        enable, load:           in std_logic;
        data:                   in unsigned(7 downto 0);
        cnt:                    buffer unsigned(7 downto 0));
end cnt8;

architecture archcnt8 of cnt8 is
begin
count: process (grst, gpst, txclk)
  begin
        if grst = '1' then
                cnt <= (others => '0');
		  elsif gpst = '1' then
					 cnt <= (others => '1');
        elsif (txclk'event and txclk='1') then
                if load = '1' then
                        cnt <= data;
                elsif enable = '1' then
                        cnt <= cnt + 1;
                end if;
        end if;
  end process count;
end archcnt8;
