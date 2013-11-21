library ieee;
use ieee.std_logic_1164.all;

package coretop_pkg is


component clockmux8  port (
        areset           : in std_logic;        -- Asynch Reset
        clk1             : in std_logic;        -- Clock 1
        clk2             : in std_logic;        -- Clock 2
        clk3             : in std_logic;        -- Clock 3
        clk4             : in std_logic;        -- Clock 4
        clk5             : in std_logic;        -- Clock 5
        clk6             : in std_logic;        -- Clock 6
        clk7             : in std_logic;        -- Clock 7
        clk8             : in std_logic;        -- Clock 8
        clk9             : in std_logic;        -- Clock 9
        sel1             : in std_logic;        -- Clock Select 1
        sel2             : in std_logic;        -- Clock Select 2
        sel3             : in std_logic;        -- Clock Select 3
        sel4             : in std_logic;        -- Clock Select 4
        sel5             : in std_logic;        -- Clock Select 5
        sel6             : in std_logic;        -- Clock Select 6
        sel7             : in std_logic;        -- Clock Select 7
        sel8             : in std_logic;        -- Clock Select 8
        sel9             : in std_logic;        -- Clock Select 9
        rxclk            : buffer std_logic);     -- RX Clock
end component;



component arbiter8  port(
        txclk:                 in std_logic;   -- TX_CLK
        areset:                in std_logic;   -- Asynch Reset
        activity1:             in std_logic;   -- Port Activity 1
        activity2:             in std_logic;   -- Port ACtivity 2
        activity3:             in std_logic;   -- Port ACtivity 3
        activity4:             in std_logic;   -- Port Activity 4
        activity5:             in std_logic;   -- Port ACtivity 5
        activity6:             in std_logic;   -- Port ACtivity 6
        activity7:             in std_logic;   -- Port ACtivity 7
        activity8:             in std_logic;   -- Port ACtivity 8
        sel1:                  buffer std_logic;   -- Port Select 1
        sel2:                  buffer std_logic;   -- Port Select 2
        sel3:                  buffer std_logic;   -- Port Select 3
        sel4:                  buffer std_logic;   -- Port Select 4
        sel5:                  buffer std_logic;   -- Port Select 5
        sel6:                  buffer std_logic;   -- Port Select 6
        sel7:                  buffer std_logic;   -- Port Select 7
        sel8:                  buffer std_logic;   -- Port Select 8
        nosel:                 buffer std_logic;   -- No Port Selected
        carrier:               buffer std_logic;   -- Carrier Detected
        collision:             buffer std_logic);   -- Collision Detected
end component;


component fifo  port(
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
        dmuxout:               buffer std_logic_vector(5 downto 0); -- FIFO Mux output
        wptr2:                 buffer std_logic;   -- Write Pointer
        wptr1:                 buffer std_logic;   -- Write Pointer
        wptr0:                 buffer std_logic;   -- Write Pointer
        rptr2:                 buffer std_logic;   -- Read Pointer
        rptr1:                 buffer std_logic;   -- Read Pointer
        rptr0:                 buffer std_logic);   -- Read Pointer
end component;


component symbolmux  port(
        txclk:                  in std_logic;  -- Reference TX_CLK
        areset:                 in std_logic;  -- Async Reset
        symbolclr:              in std_logic;  -- Symbol Counter Clear
        symbolinc:              in std_logic;  -- Symbol Counter Increment
        switch1:                in std_logic;  -- Line 1 D/S Switch Control
        switch2:                in std_logic;  -- Line 2 D/S Switch Control
        switch3:                in std_logic;  -- Line 3 D/S Switch Control
        symbol1:                in std_logic_vector(1 downto 0);  -- Line 1 Symbol Mux Control
        symbol2:                in std_logic_vector(1 downto 0);  -- Line 2 Symbol Mux Control
        symbol3:                in std_logic_vector(1 downto 0);  -- Line 3 Symbol Mux Control
        dmuxout:                in std_logic_vector(5 downto 0);  -- FIFO Data Input
        symbolend1:             buffer std_logic; -- End of Line 1 Symbol
        symbolend2:             buffer std_logic; -- End of Line 2 Symbol
        symbolend3:             buffer std_logic; -- End of Line 3 Symbol
        txd5:                   buffer std_logic; -- Data
        txd4:                   buffer std_logic; -- Data
        txd3:                   buffer std_logic; -- Data
        txd2:                   buffer std_logic; -- Data
        txd1:                   buffer std_logic; -- Data
        txd0:                   buffer std_logic);-- Data
end component;


component control  port(
        txclk:                   in std_logic;  -- Reference TX_CLK
        areset:                  in std_logic;  -- Async Reset
        carrier:                 in std_logic;  -- indicates carrier asserted
        collision:               in std_logic;  -- indicates collision condition
        rx_error:                in std_logic;  -- indicates RX PMA error
        rx_dv:                   in std_logic;  -- indicates SFD found in data
        symbolend1:              in std_logic;  -- indicates end of symbol line 1
        symbolend2:              in std_logic;  -- indicates end of symbol line 2
        symbolend3:              in std_logic;  -- indicates end of symbol line 3
        symbolclr:              buffer std_logic;  -- resets symbol counter
        symbolinc:              buffer std_logic;  -- increments symbol counter
        symbol1:                buffer std_logic_vector(1 downto 0);  -- selects special symbols
        symbol2:                buffer std_logic_vector(1 downto 0);  -- selects special symbols
        symbol3:                buffer std_logic_vector(1 downto 0);  -- selects special symbols
        switch1:                buffer std_logic;  -- selects special/data symbols
        switch2:                buffer std_logic;  -- selects special/data symbols
        switch3:                buffer std_logic;  -- selects special/data symbols
        wptrclr:                buffer std_logic;  -- FIFO write pointer clear
        wptrinc:                buffer std_logic;  -- FIFO write pointer increment
        rptrclr:                buffer std_logic;  -- FIFO read pointer clear
        rptrinc:                buffer std_logic;  -- FIFO read pointer increment
        txdata:                 buffer std_logic;  -- global tx_en signal
        idle:                   buffer std_logic;  -- indicates idle generation
        preamble:               buffer std_logic;  -- indicates preamble generation
        data:                   buffer std_logic;  -- indicates data generation
        col:                    buffer std_logic;     -- indicates jam generation
	prescale:		 buffer std_logic);
end component;


component porte  port (
        txclk:                 in std_logic; -- TX_CLK
        areset:                in std_logic; -- Asynch Reset
        crs:                   in std_logic; -- Carrier Sense
        enable_bar:            in std_logic; -- Port Enable
        link_bar:              in std_logic; -- PMA_Link_OK
        selected:              in std_logic; -- Arstd_logicer Select
        carrier:               in std_logic; -- Arstd_logicer Carrier
        collision:             in std_logic; -- Arstd_logicer Collision
        jam:                   in std_logic; -- Control Jam
        txdata:                in std_logic; -- Control Transmit Data
	prescale:		in std_logic;
        rx_en:                 buffer std_logic;      -- RX_EN
        tx_en:                 buffer std_logic;      -- TX_EN
        activity:              buffer std_logic;      -- Activity
        jabber_bar:            buffer std_logic;      -- Jabber
        partition_bar:         buffer std_logic);     -- Partition
end component;


end coretop_pkg;
