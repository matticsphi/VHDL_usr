library ieee, basic;
use ieee.std_logic_1164.all;
use basic.regs_pkg.all;
use basic.counters_pkg.all;
-- Following added for Warp to find entities in basic library
use basic.rreg; use basic.ascount;

entity fifo is port(
		 rxclk:                 in std_logic;   -- from Clock Mux Circuit
		 txclk:                 in std_logic;   -- Reference TX_CLK
		 areset:                in std_logic;   -- Asynch Reset
		 wptrclr:               in std_logic;   -- FIFO Write Pointer Clear
		 wptrinc:               in std_logic;   -- FIFO Write Pointer Increment
		 rptrclr:               in std_logic;   -- FIFO Read Pointer Clear
		 rptrinc:               in std_logic;   -- FIFO Read Pointer Increment 
		 rxd5:                  in std_logic;   -- FIFO Data Input
		 rxd4:                  in std_logic;   -- FIFO Data Input
		 rxd3:                  in std_logic;   -- FIFO Data Input
		 rxd2:                  in std_logic;   -- FIFO Data Input
		 rxd1:                  in std_logic;   -- FIFO Data Input
		 rxd0:                  in std_logic;   -- FIFO Data Input
		 dmuxout:               buffer std_logic_vector(5 downto 0);   -- FIFO Mux output
		 wptr2:                 buffer std_logic;   -- Write Pointer
		 wptr1:                 buffer std_logic;   -- Write Pointer
		 wptr0:                 buffer std_logic;   -- Write Pointer
		 rptr2:                 buffer std_logic;   -- Read Pointer
		 rptr1:                 buffer std_logic;   -- Read Pointer
		 rptr0:                 buffer std_logic);   -- Read Pointer
end fifo;

architecture archfifo of fifo is
-- signals

signal rptr, wptr: std_logic_vector(2 downto 0);
signal qout0, qout1, qout2, qout3, qout4, qout5, 
	qout6, qout7, rxd: std_logic_vector(5 downto 0);

signal en: std_logic_vector(7 downto 0);


begin
--      Components


u1: rreg generic map (6) port map (rxclk, areset, en(0), rxd, qout0);  -- FIFO array
u2: rreg generic map (6) port map (rxclk, areset, en(1), rxd, qout1);  -- FIFO array
u3: rreg generic map (6) port map (rxclk, areset, en(2), rxd, qout2);  -- FIFO array
u4: rreg generic map (6) port map (rxclk, areset, en(3), rxd, qout3);  -- FIFO array
u5: rreg generic map (6) port map (rxclk, areset, en(4), rxd, qout4);  -- FIFO array
u6: rreg generic map (6) port map (rxclk, areset, en(5), rxd, qout5);  -- FIFO array
u7: rreg generic map (6) port map (rxclk, areset, en(6), rxd, qout6);  -- FIFO array
u8: rreg generic map (6) port map (rxclk, areset, en(7), rxd, qout7);  -- FIFO array

u10: ascount generic map (3) port map (rxclk, areset, wptrclr, wptrinc, wptr);  -- Write Pointer
u11: ascount generic map (3) port map (txclk,  areset, rptrclr, rptrinc, rptr);  -- Read Pointer

  rxd <= (rxd5, rxd4, rxd3, rxd2, rxd1, rxd0);
  wptr2 <= wptr(2);
  wptr1 <= wptr(1);
  wptr0 <= wptr(0);
  rptr2 <= rptr(2);
  rptr1 <= rptr(1);
  rptr0 <= rptr(0);
	
--      8:1 Data Mux

with rptr select
	dmuxout <= 
		qout0 when "000",
		qout1 when "001",
		qout2 when "010",
		qout3 when "011",
		qout4 when "100",
		qout5 when "101",
		qout6 when "110",
		qout7 when others;


--      FIFO Register Selector Decoder (wptr)

with wptr select
	en <=
		"00000001" when "000",
		"00000010" when "001",
		"00000100" when "010",
		"00001000" when "011",
		"00010000" when "100",
		"00100000" when "101",
		"01000000" when "110",
		"10000000" when others;

end archfifo;
