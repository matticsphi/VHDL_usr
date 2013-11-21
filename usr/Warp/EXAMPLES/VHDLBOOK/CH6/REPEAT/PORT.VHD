library ieee, basic;
use ieee.std_logic_1164.all;
use basic.regs_pkg.all;
use basic.synch_pkg.all;
use basic.counters_pkg.all;
--Following added for Warp to find entities in basic library
use basic.rsynch; use basic.psynch; use basic.rdff1; use basic.ascount;

entity porte is port (
		 txclk:                 in std_logic; -- TX_CLK 
		 areset:                in std_logic; -- Asynch Reset
		 crs:                   in std_logic; -- Carrier Sense
		 enable_bar:            in std_logic; -- Port Enable
		 link_bar:              in std_logic; -- PMA_Link_OK
		 selected:              in std_logic; -- Arbiter Select
		 carrier:               in std_logic; -- Arbiter Carrier
		 collision:             in std_logic; -- Arbiter Collision
		 jam:                   in std_logic; -- Control Jam
		 txdata:                in std_logic; -- Control Transmit Data
		 prescale:		in std_logic;
		 rx_en:                 buffer std_logic;   -- RX_EN
		 tx_en:                 buffer std_logic;   -- TX_EN
		 activity:              buffer std_logic;   -- Activity
		 jabber_bar:            buffer std_logic; -- Jabber
		 partition_bar:         buffer std_logic); -- Partition
end porte;

architecture archporte of porte is

type states is (CLEAR_STATE, IDLE_STATE, CWATCH_STATE, CCOUNT_STATE,
		PWAIT_STATE, PHOLD_STATE, PCWATCH_STATE, WAIT_STATE);
--attribute state_encoding of states:type is one_hot_one;

signal state, newstate: states;

signal  crsdd, link_bardd, enable_bardd: std_logic;
signal  tx_eni, carpres, transmit, copyd, copyin, collisiond: std_logic;
signal  jabcnt: std_logic_vector(3 downto 0);
signal  jabberclr, jabberinc: std_logic;
signal  quietd: std_logic;
signal  cccnt: std_logic_vector(6 downto 0);
signal  cclimit, nocoldone: std_logic;
signal  nocolcnt: std_logic_vector(7 downto 0);
signal  ccclr, ccinc, nocolclr, nocolinc: std_logic;

begin

--      Components
u0: rsynch     port map (txclk, areset, crs, crsdd);
u1: psynch     port map (txclk, areset, link_bar, link_bardd);
u2: psynch     port map (txclk, areset, enable_bar, enable_bardd);
u3: rdff1      port map (txclk, areset, tx_eni, tx_en);
u4: rdff1      port map (txclk, areset, copyin, copyd);
u5: rdff1      port map (txclk, areset, collision, collisiond);
u6: ascount    generic map (4) port map (txclk, areset, jabberclr, jabberinc, jabcnt);
u7: ascount    generic map (7) port map (txclk, areset, ccclr, ccinc, cccnt);
u8: ascount    generic map (8) port map (txclk, areset, nocolclr, nocolinc, nocolcnt);

 
carpres <= crsdd AND NOT enable_bardd;
activity <= carpres AND NOT link_bardd AND jabber_bar AND partition_bar;
rx_en   <= NOT enable_bardd and NOT link_bardd AND selected AND not collision;
tx_eni  <= NOT enable_bardd and NOT link_bardd AND jabber_bar and transmit;
copyin <= carrier and NOT selected;
transmit <= txdata AND (copyd OR collisiond);
jabber_bar <=  NOT  (jabcnt(3) AND jabcnt(2));
jabberclr <= NOT carpres;
jabberinc <= carpres AND prescale AND jabber_bar;
quietd <= NOT copyd;
cclimit <= cccnt(6);
nocoldone <= nocolcnt(7);


--      Partition State Machine
		
p1: process (state, carpres, collisiond, copyd, quietd, 
		nocoldone, cclimit, enable_bardd)  begin
	case (state) is                

	when CLEAR_STATE=>
		
			partition_bar   <= '1'  ;
			ccclr           <= '1'  ;
			ccinc           <= '0'  ;
			nocolclr        <= '1'  ;
			nocolinc        <= '0'  ;

			if (enable_bardd = '1') then
				newstate        <= CLEAR_STATE;
			elsif (quietd = '1')     then
				newstate        <= IDLE_STATE;
			else
				newstate        <= CLEAR_STATE;
			
			end if;

	when IDLE_STATE=>
		
			partition_bar     <= '1'  ;
			ccclr           <= '0'  ;
			ccinc           <= '0'  ;
			nocolclr        <= '1'  ;
			nocolinc        <= '0'  ;

			if (enable_bardd = '1') then
				newstate        <= CLEAR_STATE;
			elsif (carpres = '1')    then
				newstate        <= CWATCH_STATE;
			else
				newstate        <= IDLE_STATE;
			
			end if;


	when CWATCH_STATE=>
		
			partition_bar     <= '1'  ;
			ccclr           <= '0'  ;
			ccinc           <= collisiond;
			nocolclr        <= '0'  ;
			nocolinc        <= '1'  ;

			if (enable_bardd = '1') then
				newstate        <= CLEAR_STATE;
			elsif (collisiond = '1')         then
				newstate        <= CCOUNT_STATE;
			elsif (carpres = '0') then
				newstate        <= IDLE_STATE;
			elsif (nocoldone = '1') then
				newstate        <= CLEAR_STATE;
			else
				newstate        <= CWATCH_STATE;
			
			end if;


	when CCOUNT_STATE=>
		
			partition_bar     <= '1'  ;
			ccclr           <= '0'  ;
			ccinc           <= '0'  ;
			nocolclr        <= '1'  ;
			nocolinc        <= '0'  ;


			if (enable_bardd = '1') then
				newstate        <= CLEAR_STATE;
			elsif (cclimit = '1')    then
				newstate        <= PWAIT_STATE;
			elsif (carpres = '0' AND quietd = '1') then
				newstate        <= IDLE_STATE;
			else
				newstate        <= CCOUNT_STATE;
			
			end if;


	when PWAIT_STATE=>
		
			partition_bar     <= '0'  ;
			ccclr           <= '0'  ;
			ccinc           <= '0'  ;
			nocolclr        <= '1'  ;
			nocolinc        <= '0'  ;


			if (enable_bardd = '1') then
				newstate        <= CLEAR_STATE;
			elsif (carpres = '0' AND quietd = '1') then
				newstate        <= PHOLD_STATE;
			else
				newstate        <= PWAIT_STATE;
			
			end if;


	when PHOLD_STATE=>
		
			partition_bar     <= '0'  ;
			ccclr           <= '0'  ;
			ccinc           <= '0'  ;
			nocolclr        <= '1'  ;
			nocolinc        <= '0'  ;


			if (enable_bardd = '1') then
				newstate        <= CLEAR_STATE;
			elsif (collisiond = '1' OR copyd = '1') then
				newstate        <= PCWATCH_STATE;
			else
				newstate        <= PHOLD_STATE;
			
			end if;


	when PCWATCH_STATE=>
		
			partition_bar     <= '0'  ;
			ccclr           <= '0'  ;
			ccinc           <= '0'  ;
			nocolclr        <= '0'  ;
			nocolinc        <= '1'  ;


			if (enable_bardd = '1') then
				newstate        <= CLEAR_STATE;
			elsif (carpres = '1') then
				newstate        <= PWAIT_STATE;
			elsif (quietd = '0') then
				newstate        <= PHOLD_STATE;
			elsif (nocoldone = '1' AND copyd = '1') then
				newstate        <= WAIT_STATE;
			else
				newstate        <= PCWATCH_STATE;
			
			end if;


	when WAIT_STATE=>
		
			partition_bar     <= '0'  ;
			ccclr           <= '1'  ;
			ccinc           <= '0'  ;
			nocolclr        <= '1'  ;
			nocolinc        <= '0'  ;


			if (enable_bardd = '1') then
				newstate        <= CLEAR_STATE;
			elsif (carpres = '0' AND quietd = '1') then
				newstate        <= IDLE_STATE;
			else
				newstate        <= WAIT_STATE;
			
			end if;


	end case;


end process;


--      State Flip-Flop for Synthesis
p1clk: process (txclk,areset) 
	begin
		if areset = '1' then
			state <= clear_state;
		elsif (txclk'event and txclk = '1') then
			state <= newstate;
		end if;
	end process;
end archporte;
