library ieee;
use ieee.std_logic_1164.all;
use work.std_arith.all;
entity cnt8 is port(
    txclk, grst:    in std_logic;
    enable, load:   in std_logic;
    oe:             in std_logic;
    data:           in std_logic_vector(7 downto 0);
    collision:      out std_logic;					-- 3-state output
    cnt_out:        buffer std_logic_vector(7 downto 0));
end cnt8;

architecture archcnt8 of cnt8 is
  signal cnt: std_logic_vector(7 downto 0);
begin
count: process (grst, txclk)
  begin
    if grst = '1' then
        cnt <= "00111010";
    elsif rising_edge(txclk) then
        if load = '1' then
            cnt <= data;
        elsif enable = '1' then
            cnt <= cnt + 1;
        end if;
    end if;
  end process count;
-- three-state outputs described here:
	cnt_out <= (others => 'Z') when oe = '0' else cnt;
	collision <= (enable and load) when oe = '1' else 'Z';

end archcnt8;
