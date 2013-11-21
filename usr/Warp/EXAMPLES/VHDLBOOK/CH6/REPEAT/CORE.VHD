library ieee;
use ieee.std_logic_1164.all;
use work.coretop_pkg.all;

entity core is port(
	reset                   : in std_logic; -- Global Reset
	clk                     : in std_logic; -- to CKTPAD for TX_CLK
	rxd5                    : in std_logic; -- RXD5
	rxd4                    : in std_logic; -- RXD4
	rxd3                    : in std_logic; -- RXD3
	rxd2                    : in std_logic; -- RXD2
	rxd1                    : in std_logic; -- RXD1
	rxd0                    : in std_logic; -- RXD0
	rx_dv                   : in std_logic; -- RX_DV
	rx_er                   : in std_logic; -- RX_ER

	clk1                    : in std_logic; -- RX_CLK1
	crs1                    : in std_logic; -- CRS1
	enable1_bar             : in std_logic; -- ENABLE1
	link1_bar               : in std_logic; -- LINK1

	clk2                    : in std_logic; -- RX_CLK2
	crs2                    : in std_logic; -- CRS2
	enable2_bar             : in std_logic; -- ENABLE2
	link2_bar               : in std_logic; -- LINK2

	clk3                    : in std_logic; -- RX_CLK3
	crs3                    : in std_logic; -- CRS3
	enable3_bar             : in std_logic; -- ENABLE3
	link3_bar               : in std_logic; -- LINK3

	clk4                    : in std_logic; -- RX_CLK4
	crs4                    : in std_logic; -- CRS4
	enable4_bar             : in std_logic; -- ENABLE4
	link4_bar               : in std_logic; -- LINK4

	clk5                    : in std_logic; -- RX_CLK5
	crs5                    : in std_logic; -- CRS5
	enable5_bar             : in std_logic; -- ENABLE5
	link5_bar               : in std_logic; -- LINK5

	clk6                    : in std_logic; -- RX_CLK6
	crs6                    : in std_logic; -- CRS6
	enable6_bar             : in std_logic; -- ENABLE6
	link6_bar               : in std_logic; -- LINK6

	clk7                    : in std_logic; -- RX_CLK7
	crs7                    : in std_logic; -- CRS7
	enable7_bar             : in std_logic; -- ENABLE7
	link7_bar               : in std_logic; -- LINK7

	clk8                    : in std_logic; -- RX_CLK8
	crs8                    : in std_logic; -- CRS8
	enable8_bar             : in std_logic; -- ENABLE8
	link8_bar               : in std_logic; -- LINK8

	rx_en1          : buffer std_logic;        -- RX_EN1
	tx_en1          : buffer std_logic;        -- TX_EN1
	partition1_bar  : buffer std_logic;        -- PARTITION1
	jabber1_bar     : buffer std_logic;        -- JABBER1

	rx_en2          : buffer std_logic;        -- RX_EN2
	tx_en2          : buffer std_logic;        -- TX_EN2
	partition2_bar  : buffer std_logic;        -- PARTITION2
	jabber2_bar     : buffer std_logic;        -- JABBER2

	rx_en3          : buffer std_logic;        -- RX_EN3
	tx_en3          : buffer std_logic;        -- TX_EN3
	partition3_bar  : buffer std_logic;        -- PARTITION3
	jabber3_bar     : buffer std_logic;        -- JABBER3

	rx_en4          : buffer std_logic;        -- RX_EN4
	tx_en4          : buffer std_logic;        -- TX_EN4
	partition4_bar  : buffer std_logic;        -- PARTITION4
	jabber4_bar     : buffer std_logic;        -- JABBER4

	rx_en5          : buffer std_logic;        -- RX_EN5
	tx_en5          : buffer std_logic;        -- TX_EN5
	partition5_bar  : buffer std_logic;        -- PARTITION5
	jabber5_bar     : buffer std_logic;        -- JABBER5

	rx_en6          : buffer std_logic;        -- RX_EN6
	tx_en6          : buffer std_logic;        -- TX_EN6
	partition6_bar  : buffer std_logic;        -- PARTITION6
	jabber6_bar     : buffer std_logic;        -- JABBER6

	rx_en7          : buffer std_logic;        -- RX_EN7
	tx_en7          : buffer std_logic;        -- TX_EN7
	partition7_bar  : buffer std_logic;        -- PARTITION7
	jabber7_bar     : buffer std_logic;        -- JABBER7

	rx_en8          : buffer std_logic;        -- RX_EN8
	tx_en8          : buffer std_logic;        -- TX_EN8
	partition8_bar  : buffer std_logic;        -- PARTITION8
	jabber8_bar     : buffer std_logic;        -- JABBER8

	txd5            : buffer std_logic;        -- TXD5
	txd4            : buffer std_logic;        -- TXD4
	txd3            : buffer std_logic;        -- TXD3
	txd2            : buffer std_logic;        -- TXD2
	txd1            : buffer std_logic;        -- TXD1
	txd0            : buffer std_logic;        -- TXD0

	txdata          : buffer std_logic;        -- TX_ENall
	idle            : buffer std_logic;        -- Idle Generation
	preamble        : buffer std_logic;        -- Preamble Generation
	data            : buffer std_logic;        -- Data Generation
	jam             : buffer std_logic;        -- Jam Generation
	collision       : buffer std_logic;        -- Collision Indication
	wptr2           : buffer std_logic;        -- Write Pointer2
	wptr1           : buffer std_logic;        -- Write Pointer1
	wptr0           : buffer std_logic;        -- Write Pointer0
	rptr2           : buffer std_logic;        -- Read Pointer2
	rptr1           : buffer std_logic;        -- Read Pointer1
	rptr0           : buffer std_logic);      -- Read Pointer0
end core;

architecture archcore of core is
	signal txclk1, nosel, areset, sel1, sel2, sel3, sel4: std_logic;
	signal sel5, sel6, sel7, sel8, rxclk, txclk: std_logic;
	signal activity1, activity2, activity3, activity4: std_logic;
	signal activity5, activity6, activity7, activity8: std_logic;
	signal carrier: std_logic;
	signal wptrclr, wptrinc, rptrclr, rptrinc,symbolinc:std_logic;
	signal switch1, switch2, switch3: std_logic;
	signal symbolend1, symbolend2, symbolend3: std_logic;
	signal symbolclr : std_logic;
	signal symbol1, symbol2, symbol3: std_logic_vector(1 downto 0);
	signal dmuxout: std_logic_vector(5 downto 0);
	signal prescale: std_logic;

begin
--      Components
u1: clockmux8 port map
	(areset, 
	clk1, clk2, clk3, clk4, clk5, clk6, clk7, clk8, txclk1,
	sel1, sel2, sel3, sel4, sel5, sel6, sel7, sel8, nosel,  
	rxclk);

u2: arbiter8 port map
	(txclk, areset, 
	activity1, activity2, activity3, activity4,
	activity5, activity6, activity7, activity8,
	sel1, sel2, sel3, sel4, sel5, sel6, sel7, sel8,
	nosel, carrier, collision);

u3: fifo port map
	(rxclk, txclk, areset, wptrclr, wptrinc, rptrclr,
	rptrinc, rxd5, rxd4, rxd3, rxd2, rxd1, rxd0, 
	dmuxout,  wptr2, wptr1, wptr0, rptr2, rptr1, rptr0);

u4: symbolmux port map
	(txclk, areset, 
	symbolclr, symbolinc, switch1, switch2, switch3, symbol1, 
	symbol2, symbol3, dmuxout, symbolend1, symbolend2, 
	symbolend3, txd5, txd4, txd3, txd2, txd1, txd0);

u5: control port map
	(txclk, areset, carrier, collision, rx_er, rx_dv,
	symbolend1, symbolend2, symbolend3, symbolclr, symbolinc,
	symbol1, symbol2, symbol3, switch1, switch2, switch3,
	wptrclr, wptrinc, rptrclr, rptrinc, txdata, idle,
	preamble, data, jam, prescale);

u6: porte port map
	(txclk, areset, 
	crs1, enable1_bar, link1_bar,
	sel1, carrier, collision, jam, txdata, prescale, rx_en1, tx_en1,
	activity1, jabber1_bar, partition1_bar);

u7: porte port map
	(txclk, areset,  
	crs2, enable2_bar, link2_bar,
	sel2, carrier, collision, jam, txdata, prescale, rx_en2, tx_en2, 
	activity2, jabber2_bar, partition2_bar);

u8: porte port map
	(txclk, areset, 
	crs3, enable3_bar, link3_bar,
	sel3, carrier, collision, jam, txdata, prescale, rx_en3, tx_en3,
	activity3, jabber3_bar, partition3_bar);

u9: porte port map
	(txclk, areset, 
	crs4, enable4_bar, link4_bar,
	sel4, carrier, collision, jam, txdata, prescale, rx_en4, tx_en4,
	activity4, jabber4_bar, partition4_bar);

u10: porte port map
	(txclk, areset, 
	crs5, enable5_bar, link5_bar,
	sel5, carrier, collision, jam, txdata, prescale, rx_en5, tx_en5, 
	activity5, jabber5_bar, partition5_bar);

u11: porte port map
	(txclk, areset, 
	crs6, enable6_bar, link6_bar,
	sel6, carrier, collision, jam, txdata, prescale, rx_en6, tx_en6,
	activity6, jabber6_bar, partition6_bar);

u12: porte port map
	(txclk, areset, 
	crs7, enable7_bar, link7_bar,
	sel7, carrier, collision, jam, txdata, prescale, rx_en7, tx_en7, 
	activity7, jabber7_bar, partition7_bar);

u13: porte port map
	(txclk, areset, 
	crs8, enable8_bar, link8_bar,
	sel8, carrier, collision, jam, txdata, prescale, rx_en8, tx_en8,
	activity8, jabber8_bar, partition8_bar);

txclk 		<= clk;
txclk1		<= clk;
areset 		<= reset;

end archcore;
	
