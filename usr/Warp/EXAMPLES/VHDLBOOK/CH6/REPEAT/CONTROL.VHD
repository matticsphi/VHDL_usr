-- This design is not complete. It is left as an exercise for the
-- reader to complete this design

library ieee, basic;
use ieee.std_logic_1164.all;
use basic.regs_pkg.all;
use basic.synch_pkg.all;
use basic.counters_pkg.all;

entity control is port(
		 txclk:        in std_logic;    -- Reference TX_CLK
		 areset:       in std_logic;    -- Async Reset
		 carrier:      in std_logic;    -- indicates carrier asserted
		 collision:    in std_logic;    -- indicates collision condition
		 rx_error:     in std_logic;    -- indicates RX PMA error
		 rx_dv:        in std_logic;    -- indicates SFD found in data
		 symbolend1:   in std_logic;    -- indicates end of symbol line 1
		 symbolend2:   in std_logic;    -- indicates end of symbol line 2
		 symbolend3:   in std_logic;    -- indicates end of symbol line 3
		 symbolclr:    buffer std_logic;   -- resets symbol counter
		 symbolinc:    buffer std_logic;   -- increments symbol counter
		 symbol1:      buffer std_logic_vector(1 downto 0);--    selects
		 symbol2:      buffer std_logic_vector(1 downto 0);--    special
		 symbol3:      buffer std_logic_vector(1 downto 0);--    symbols
		 switch1:      buffer std_logic;   -- selects special/data symbols
		 switch2:      buffer std_logic;   -- selects special/data symbols
		 switch3:      buffer std_logic;   -- selects special/data symbols
		 wptrclr:      buffer std_logic;   -- FIFO write pointer clear
		 wptrinc:      buffer std_logic;   -- FIFO write pointer increment
		 rptrclr:      buffer std_logic;   -- FIFO read pointer clear
		 rptrinc:      buffer std_logic;   -- FIFO read pointer increment
		 txdata:       buffer std_logic;    -- txdata is ready 
		 idle:         buffer std_logic;   -- indicates idle generation
		 preamble:     buffer std_logic;   -- indicates preamble generation
		 data:         buffer std_logic;   -- indicates data generation
		 col:          buffer std_logic;   -- indicates jam generation
		 prescale:     buffer std_logic);  -- prescale output to port
end control;

architecture archcontrol of control is 
type states1 is (IDLE_STATE1, PRE1_STATE1, PRE2_STATE1, PRE3_STATE1, DATA_STATE1,
		JAM_STATE1, NOSFD_STATE1, ERROR_STATE1);
--attribute state_encoding of states1:type is one_hot_one;

type states2 is (IDLE_STATE2, PRE1_STATE2, PRE2_STATE2, PRE3_STATE2, DATA_STATE2,
		JAM_STATE2, NOSFD_STATE2, ERROR_STATE2, PRE4_STATE2);
--attribute state_encoding of states2:type is one_hot_one;

type states3 is (IDLE_STATE3, PRE1_STATE3, PRE2_STATE3, PRE3_STATE3, DATA_STATE3,
		JAM_STATE3, NOSFD_STATE3, ERROR_STATE3);
--attribute state_encoding of states3:type is one_hot_one;

signal state1, newstate1: states1;
signal state2, newstate2: states2;
signal state3, newstate3: states3;

signal  carrierd, carrierdd: std_logic;
signal  error, rx_dv_in, rx_error_in: std_logic;
signal  no_sfd, no_sfd_in, no_data, data_valid: std_logic;
signal  prescale_in: std_logic;
signal  pout: std_logic_vector(9 downto 0);

constant jam:   std_logic_vector(1 downto 0) := "00";
constant pre:   std_logic_vector(1 downto 0) := "00";
constant sosb:  std_logic_vector(1 downto 0) := "01";
constant bad:   std_logic_vector(1 downto 0) := "10";
constant zero:  std_logic_vector(1 downto 0) := "11";
constant fifodata:      std_logic := '1';
constant symboldata:    std_logic := '0';
signal vdd:	std_logic := '1';
signal vss:   std_logic := '0'; 

begin
--      Components

u1: rsynch port map (txclk, areset, carrier, carrierdd);
u3: rsynch port map (txclk, areset, rx_error_in, error);
u5: rdff1 port map (txclk, areset, rx_dv_in, data_valid);
u7: rdff1 port map (txclk, areset, no_sfd_in, no_data);
u8: ascount generic map(10) port map (txclk, areset, vss, vdd, pout);
u9: rdff1 port map(txclk, areset, prescale_in, prescale);


rx_dv_in    <= carrierdd and rx_dv;    -- filter out glitches
rx_error_in <= carrierdd and rx_error; -- filter out glitches
wptrclr     <= not(rx_dv_in and not collision); 
no_sfd_in   <= (no_sfd or no_data) and carrier;
prescale_in <= '1' when pout = "1111111111" else '0';

wptrinc <= '1';
rptrinc <= '1';
symbolinc <= '1';

--      State Machine Controllers

--      State Machine Controller Line 3

p3: process (carrier, collision, symbolend3, data_valid, error, state3) begin
	
	case (state3) is                        

	when IDLE_STATE3 =>

			symbol3		<= zero;
			switch3 	<= symboldata;
			symbolclr 	<= '1';
			rptrclr 	<= '1';
			preamble	<= '0';
			data		<= '0';
			no_sfd		<= '0';
			idle		<= '1';
			col		<= '0';
			txdata		<= '0';

			if (collision = '1') then
				newstate3 <= JAM_STATE3;
			elsif (carrier = '1') then
				newstate3 <= PRE1_STATE3;
			else
				newstate3 <= IDLE_STATE3;

			end if;

	when PRE1_STATE3 =>

			symbol3		<= pre;
			switch3 	<= symboldata;
			symbolclr 	<= '0';
			rptrclr 	<= '1';
			preamble	<= '1';
			data		<= '0';
			no_sfd		<= '0';
			idle		<= '0';
			col		<= '0';
			txdata		<= '1';

			if (carrier = '0')	 then
				newstate3 <= IDLE_STATE3;
			elsif (collision = '1') then
				newstate3 <= JAM_STATE3;
			elsif (symbolend3 = '1') then
				newstate3 <= PRE2_STATE3;
			else
				newstate3 <= PRE1_STATE3;	

			end if;

	when PRE2_STATE3 =>

			symbol3		<= pre;
			switch3 	<= symboldata;
			symbolclr 	<= '0';
			rptrclr 	<= '1';
			preamble	<= '1';
			data		<= '0';
			no_sfd		<= '0';
			idle		<= '0';
			col		<= '0';
			txdata		<= '1';

			if (carrier = '0')	 then
				newstate3 <= IDLE_STATE3;
			elsif (collision = '1') then
				newstate3 <= JAM_STATE3;
			elsif (symbolend3 = '1') then
				newstate3 <= PRE3_STATE3;
			else
				newstate3 <= PRE2_STATE3;	

			end if;

	when PRE3_STATE3 =>

			symbol3		<= sosb;
			switch3 	<= symboldata;
			symbolclr 	<= '0';
			rptrclr 	<= '1';
			preamble	<= '1';
			data		<= '0';
			no_sfd		<= '0';
			idle		<= '0';
			col		<= '0';
			txdata		<= '1';

			if (carrier = '0') then
				newstate3 <= IDLE_STATE3;
			elsif (collision = '1') then
				newstate3 <= JAM_STATE3;
			elsif (symbolend3 = '1' and error = '1') then
				newstate3 <= ERROR_STATE3;
			elsif (symbolend3 = '1' and data_valid = '0') then
				newstate3 <= NOSFD_STATE3;
			elsif (symbolend3 = '1' and data_valid = '1') then
				newstate3 <= DATA_STATE3;
			else
				newstate3 <= PRE3_STATE3;	

			end if;

	when DATA_STATE3 =>

			symbol3		<= jam;
			switch3 	<= fifodata;
			symbolclr 	<= '0';
			rptrclr 	<= '0';
			preamble	<= '0';
			data		<= '1';
			no_sfd		<= '0';
			idle		<= '0';
			col		<= '0';
			txdata		<= '1';

			if (carrier = '0') then
				newstate3 <= IDLE_STATE3;
			elsif (collision = '1') then
				newstate3 <= JAM_STATE3;
			elsif (symbolend3 = '1' and error = '1') then
				newstate3 <= ERROR_STATE3;
			else
				newstate3 <= DATA_STATE3;	

			end if;

	when JAM_STATE3 =>

			symbol3		<= jam;
			switch3 	<= symboldata;
			symbolclr 	<= '0';
			rptrclr 	<= '1';
			preamble	<= '0';
			data		<= '0';
			no_sfd		<= '0';
			idle		<= '0';
			col		<= '1';
			txdata		<= '1';

			if (carrier = '0') then
				newstate3 <= IDLE_STATE3;
			else
				newstate3 <= JAM_STATE3;	

			end if;

	when NOSFD_STATE3 =>

			symbol3		<= jam;
			switch3 	<= symboldata;
			symbolclr 	<= '0';
			rptrclr 	<= '0';
			preamble	<= '0';
			data		<= '1';
			no_sfd		<= '1';
			idle		<= '0';
			col		<= '0';
			txdata		<= '1';

			if (carrier = '0') then
				newstate3 <= IDLE_STATE3;
			elsif (collision = '1') then
				newstate3 <= JAM_STATE3;
			elsif (symbolend3 = '1' and error = '1') then
				newstate3 <= ERROR_STATE3;
			else
				newstate3 <= NOSFD_STATE3;	

			end if;

	when ERROR_STATE3 =>

			symbol3		<= bad;
			switch3 	<= symboldata;
			symbolclr 	<= '0';
			rptrclr 	<= '0';
			preamble	<= '0';
			data		<= '1';
			no_sfd		<= '0';
			idle		<= '0';
			col		<= '0';
			txdata		<= '1';

			if (carrier = '0') then
				newstate3 <= IDLE_STATE3;
			elsif (collision = '1') then
				newstate3 <= JAM_STATE3;
			else
				newstate3 <= ERROR_STATE3;	

			end if;
	end case;
end process;

p3clk: process (txclk,areset)
	begin
		if areset = '1' then
			state3 <= idle_state3;
		elsif (txclk'event and txclk='1') then
			state3 <= newstate3;
		end if;
	end process;
end archcontrol;
