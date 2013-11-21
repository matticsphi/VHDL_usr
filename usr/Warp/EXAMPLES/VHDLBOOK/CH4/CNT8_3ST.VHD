library ieee;
use ieee.std_logic_1164.all;
use work.std_arith.all;
entity cnt8 is port(
    txclk, grst:    in std_logic;
    enable, load:   in std_logic;
    oe:             in std_logic;			--output enable
    data:           in std_logic_vector(7 downto 0);
    cnt_out:        buffer std_logic_vector(7 downto 0));		-- cnt output
end cnt8;

architecture archcnt8 of cnt8 is
  signal cnt: std_logic_vector(7 downto 0);		-- cnt signal for counting
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

oes: process (oe, cnt)						-- three-state buffers
  begin
    if oe = '0' then
        cnt_out <= (others => 'Z');
    else
        cnt_out <= cnt;
    end if;
  end process oes;

end archcnt8;
