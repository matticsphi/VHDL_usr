library ieee, basic;
use ieee.std_logic_1164.all;
use basic.regs_pkg.all;
use basic.counters_pkg.all;
--Following added for Warp to find entities in basic library
use basic.rdff; use basic.ascount;

entity symbolmux is port(
		 txclk:			 in std_logic;	-- Reference TX_CLK
		 areset: 		 in std_logic;	-- Async Reset
		 symbolclr:		 in std_logic;	-- Symbol Counter Clear
		 symbolinc: 		 in std_logic;	-- Symbol Counter Increment
		 switch1:		 in std_logic;	-- Line 1 D/S Switch Control
		 switch2: 		 in std_logic;	-- Line 2 D/S Switch Control
		 switch3: 		 in std_logic;	-- Line 3 D/S Switch Control
		 symbol1:		 in std_logic_vector(1 downto 0);-- Line 1 Symbol Mux Control
		 symbol2: 		 in std_logic_vector(1 downto 0);-- Line 2 Symbol Mux Control
		 symbol3: 		 in std_logic_vector(1 downto 0);-- Line 3 Symbol Mux Control
		 dmuxout: 		 in std_logic_vector(5 downto 0);-- FIFO Data Input
		 symbolend1:	 buffer std_logic; -- End of Line 1 Symbol
		 symbolend2:	 buffer std_logic;	-- End of Line 2 Symbol
		 symbolend3: 	 buffer std_logic;	-- End of Line 3 Symbol
		 txd5:			 buffer std_logic;	-- Data
		 txd4:			 buffer std_logic;	-- Data
		 txd3:			 buffer std_logic;	-- Data
		 txd2:			 buffer std_logic;	-- Data
		 txd1:			 buffer std_logic;	-- Data
		 txd0:			 buffer std_logic);-- Data
end symbolmux;

architecture archsymbolmux of symbolmux is
-- signals
signal	clearcount: std_logic;
signal	symbolcount: std_logic_vector(2 downto 0);

signal	sosb1, sosb2, sosb3, bad1, bad2, bad3, jam: std_logic_vector(1 downto 0);
signal	txd, muxout, smuxout: std_logic_vector(5 downto 0);

--	Constants
constant plus : std_logic_vector(1 downto 0) := "10";
constant zero : std_logic_vector(1 downto 0) := "00";
constant minus: std_logic_vector(1 downto 0) := "01";

begin
-- Components

u1: ascount generic map(CounterSize => 3)
	    port map (txclk, areset, clearcount, symbolinc, symbolcount); -- Symbol Count

u2: rdff generic map (size => 6)
	 port map (txclk, areset, muxout, txd);			-- Output Latch


txd5 <= txd(5);
txd4 <= txd(4);
txd3 <= txd(3);
txd2 <= txd(2);
txd1 <= txd(1);
txd0 <= txd(0);


symbolend1	<= symbolcount(0) AND NOT symbolcount(1) AND  symbolcount(2);
symbolend2	<= symbolcount(0) AND NOT symbolcount(1) AND NOT symbolcount(2);
symbolend3	<= symbolcount(0) AND  symbolcount(1) AND NOT symbolcount(2);
clearcount	<= symbolend1 OR symbolclr;

--	Special Symbol Mux
with symbol1 select
	smuxout(1 downto 0) <= 
		jam   when "00",
		sosb1 when "01",	
		bad1  when "10",
		zero  when others;

--	Line 1 Switch Mux
with switch1 select
		muxout(1 downto 0) <= 
			smuxout(1 downto 0) when '0',
			dmuxout(1 downto 0) when others;

--	Special Symbol Mux (Line 2)
with symbol2 select
	smuxout(3 downto 2) <= 
		jam   when "00",
		sosb2 when "01",
		bad2  when "10",
		zero  when others;

--	Line 2 Switch Mux
with switch2 select
		muxout(3 downto 2) <= 
			smuxout(3 downto 2) when '0',
			dmuxout(3 downto 2) when others;

--	Special Symbol Mux (Line 3)
with symbol3 select
	smuxout(5 downto 4) <= 
		jam   when "00",
		sosb3 when "01",
		bad3  when "10",
		zero  when others;

--	Line 3 Switch Mux
with switch3 select
		muxout(5 downto 4) <= 
			smuxout(5 downto 4) when '0',
			dmuxout(5 downto 4) when others;

--	Jam/Preamble Generation (All Lines)
with symbolcount(0) select
	jam <= 
		plus  when '0',
		minus when others;

--	SOSB Generation (Line 1)
with symbolcount select
	sosb1 <=
		plus  when "000",
		minus when "001",
		plus  when "010",
		minus when "011",
		minus when "100",
		plus  when "101",
		zero  when others;

--	SOSB Generation (Line 2)
with symbolcount select
	sosb2 <=
		minus when "000",
		plus  when "001",
		plus  when "010",
		minus when "011",
		plus  when "100",
		minus when "101",
		zero  when others;

--	SOSB Generation (Line 3)
with symbolcount select
	sosb3 <=
		plus  when "000",
		minus when "001",
		minus when "010",
		plus  when "011",
		plus  when "100",
		minus when "101",
		zero  when others;

--	Bad Code Generation (Line 1)
with symbolcount select
	bad1 <=
		minus when "000",
		minus when "001",
		minus when "010",
		plus  when "011",
		plus  when "100",
		plus  when "101",
		zero  when others;

--	Bad Code Generation (Line 2)
with symbolcount select
	bad2 <=
		plus  when "000",
		plus  when "001",
		minus when "010",
		minus when "011",
		minus when "100",
		plus  when "101",
		zero  when others;

--	Bad Code Generation (Line 3)
with symbolcount select
	bad3 <=
		minus when "000",
		plus  when "001",
		plus  when "010",
		plus  when "011",
		minus when "100",
		minus when "101",
		zero  when others;
end archsymbolmux;
