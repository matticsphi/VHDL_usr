library ieee;
use ieee.std_logic_1164.all;
use work.std_arith.all;
entity cnt8 is port(
    txclk, grst:    in std_logic;
    enable, load:   in std_logic;
    oe:         in std_logic;
    cnt_out:    inout std_logic_vector(7 downto 0));																		-- mode inout req'd
end cnt8;

architecture archcnt8 of cnt8 is
  signal cnt: std_logic_vector(7 downto 0);
begin
count: process (grst, txclk)
  begin
    if grst = '1' then
        cnt <= "00111010";
    elsif (txclk'event and txclk='1') then
        if load = '1' then
            cnt <= cnt_out;								-- cnt is now loaded from the cnt_out port
        elsif enable = '1' then
            cnt <= cnt + 1;
        end if;
    end if;
  end process count;

oes: process (oe, cnt)
  begin
    if oe = '0' then
        cnt_out <= (others => 'Z');
    else
        cnt_out <= cnt;
    end if;
  end process oes;

end archcnt8;
