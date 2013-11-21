library ieee;
use ieee.std_logic_1164.all;
use work.std_arith.all;
entity dram_controller is port (
	addr: in std_logic_vector(31 downto 0);														-- system address
	clock,														-- clock 20MHz
	ads,														-- address strobe
	read_write,				 										-- read/write
	reset: in std_logic;														-- system reset
	ack: out std_logic;														-- acknowledge 
	we: out std_logic;														-- write enable
	ready: out std_logic;														-- data ready for latching
	dram:out std_logic_vector (9 downto 0);														-- DRAM address
	ras: out std_logic_vector(1 downto 0);															-- row address strobe
	cas: out std_logic_vector(3 downto 0));															-- column address strobe
end dram_controller;

architecture controller of dram_controller is
	type states is (idle, address_detect, row_address, ras_assert,
					col_address, cas_assert, data_ready, wait_state, refresh0,
					refresh1);
	signal present_state_a, next_state_a: states;
	signal present_state_b, next_state_b: states;
	signal dram_a, dram_b: std_logic_vector(9 downto 0);
	signal ras_a, ras_b: std_logic_vector(1 downto 0);
	signal cas_a, cas_b: std_logic_vector(3 downto 0);
	signal we_a, we_b, ack_a, ack_b, ready_a, ready_b: std_logic;
	signal stored: std_logic_vector(31 downto 0);																-- latched addr
	signal ref_timer:std_logic_vector(8 downto 0);																-- refresh timer
	signal ref_request: std_logic;																-- refresh request
	signal match: std_logic;			 													-- address match
	signal read: std_logic;			 													-- latched read_write
	-- row and column address aliases
	alias row_addr: std_logic_vector(9 downto 0) is stored(19 downto 10);
	alias col_addr: std_logic_vector(9 downto 0) is stored(9 downto 0);
	--attribute synthesis_off of match,ref_request: signal is true;
begin
--------------------------------------------------------------
--                    Capture Address 			    --
--------------------------------------------------------------
capture: process (reset, clock)
	begin
		if reset = '1' then 
			stored <= (others => '0');
			read <= '0';
		elsif (clock'event and clock='1') then
		  if ads = '0' then 
			stored <= addr; 
			read <= read_write;
		  end if;
		end if;
	end process;

--------------------------------------------------------------
--                    Address Comparator		    --
--------------------------------------------------------------
-- The address comparator determines if memory is being accessed

	match <= '1' when stored(31 downto 21) = "00000000000" else '0'; 

--------------------------------------------------------------
--                    Address Multiplexers                  --
--------------------------------------------------------------
-- The address multiplexer selects the row, column, or refresh 
-- address depending on the current cycle

multiplexer_a: process (row_addr, col_addr, present_state_a)
begin
	if (present_state_a = row_address or present_state_a = ras_assert) then
		dram_a <= row_addr;
	else
		dram_a <= col_addr;
	end if;
end process;

multiplexer_b: process (row_addr, col_addr, present_state_b)
 begin
	if ( present_state_b = row_address or present_state_b = ras_assert) then
		dram_b <= row_addr;
	else
		dram_b <= col_addr;
	end if;
 end process;

------------------------------------------------------------
--         Refresh Counter & Refresh Timer                --
------------------------------------------------------------
-- The refresh timer is used to initiate refresh cycles. A 
-- refresh cycle is required every 8ms. If the clock frequency
-- is 20MHz, then a refresh request must be generated every 312
-- clock cycles. Refresh_req is asserted until a refresh cycle
-- begins

synchronous: process (reset, clock)
	begin
		if reset = '1' then 
			ref_timer <= (others => '0'); 
		elsif clock'event and clock = '1' then
			if (ref_timer = "100111000") then  -- start request at 312
				ref_timer <= (others => '0');
			else 
				ref_timer <= ref_timer + 1;
			end if;
		end if;
	end process;

  ref_request <= '1' when (ref_timer = "100111000" or 
				(ref_request = '1' and present_state_a /= refresh0))
			else '0';

------------------------------------------------------------
--       DRAM State Machine A                             --
------------------------------------------------------------
-- The DRAM controller state machine controls the state of
-- the address multiplexer select lines as well as the
-- state of RAS and CAS 

state_tr_a: process (present_state_b, ref_request, ads, match)
begin
	case present_state_b is									--next_state_a depends on present_state_b
	when idle => 
		if ref_request = '1' then
			next_state_a <= refresh0;
		elsif ads = '0' then
			next_state_a <= address_detect;
		else
			next_state_a <= idle;
		end if;
	when address_detect =>
		if match = '1' then
			next_state_a <= row_address;
		else 
			next_state_a <= idle;
		end if;
	when row_address =>
		next_state_a <= ras_assert;
	when ras_assert =>
		next_state_a <= col_address;
	when col_address =>
		next_state_a <= cas_assert;
	when cas_assert =>
		next_state_a <= data_ready;
	when data_ready =>
		next_state_a <= wait_state;
	when wait_state =>
		next_state_a <= idle;
	when refresh0 =>
		next_state_a <= refresh1;
	when refresh1 =>
		next_state_a <= idle;
	end case;
end process;

clocked_a: process (reset, clock)
	begin 
		if reset = '1' then
			present_state_a <= idle;
		elsif (clock'event and clock = '1') then
			present_state_a <= next_state_a;	
		end if;
	end process;

	with present_state_a select
    cas_a <=					"0000" when cas_assert | data_ready | 
							wait_state | refresh0 | refresh1,
					"1111" when others;	

  ras_a <= 				"00" when (present_state_a = refresh1)
				else "01" when ((present_state_a = ras_assert or 
							present_state_a = col_address or
							present_state_a = cas_assert or 
							present_state_a = data_ready or
							present_state_a = wait_state) and stored(20)='1')
				else "10" when ((present_state_a = ras_assert or
							present_state_a = col_address or
							present_state_a = cas_assert or 
							present_state_a = data_ready or
							present_state_a = wait_state) and stored(20)='0')
				else "11";

	we_a <=			'0' when ((present_state_a = col_address or 
							present_state_a = cas_assert or
							present_state_a = data_ready or 
							present_state_a = wait_state) and read = '0')
				else '1';

	ack_a <= 			'0' when (present_state_a = address_detect and match = '1')
				else '1';

	ready_a <=				'0' when (read = '1' and (present_state_a = data_ready or
							present_state_a = wait_state)) 
					else '1';

------------------------------------------------------------
--       DRAM State Machine B                             --
------------------------------------------------------------
state_tr_b: process (present_state_a, ref_request, ads, match)
begin
	case present_state_a is									--next_state_b depends on present_state_a
	when idle => 
		if ref_request = '1' then
			next_state_b <= refresh0;
		elsif ads = '0' then
			next_state_b <= address_detect;
		else
			next_state_b <= idle;
		end if;
	when address_detect =>
		if match = '1' then
			next_state_b <= row_address;
		else 
			next_state_b <= idle;
		end if;
	when row_address =>
		next_state_b <= ras_assert;
	when ras_assert =>
		next_state_b <= col_address;
	when col_address =>
		next_state_b <= cas_assert;
	when cas_assert =>
		next_state_b <= data_ready;
	when data_ready =>
		next_state_b <= wait_state;
	when wait_state =>
		next_state_b <= idle;
	when refresh0 =>
		next_state_b <= refresh1;
	when refresh1 =>
		next_state_b <= idle;
	end case;
end process;

clocked_b: process (reset, clock)
	begin 
		if reset = '1' then
			present_state_b <= idle;
		elsif (clock'event and clock = '0') then
			present_state_b <= next_state_b;	
		end if;
	end process;

	with present_state_b select
	cas_b <=				"0000" when cas_assert | data_ready | wait_state |
							refresh0 | refresh1,
					"1111" when others;	

	ras_b <=				"00" when (present_state_b = refresh1) 
					else "01" when ((present_state_b = ras_assert or
							present_state_b = col_address or
							present_state_b = cas_assert or 
							present_state_b = data_ready or
							present_state_b = wait_state) and stored(20)='1')
					else "10" when ((present_state_b = ras_assert or
							present_state_b = col_address or
							present_state_b = cas_assert or
							present_state_b = data_ready or
							present_state_b = wait_state) and stored(20)='0')
						else "11";

	we_b <=			'0' when ((present_state_b = col_address or 
							present_state_b = cas_assert or
							present_state_b = data_ready) and read = '0')
				else '1';

	ack_b <=			'0' when (present_state_b = address_detect and match = '1')
				else '1';

	ready_b <=				'0' when (read = '1' and (present_state_b = data_ready or
							present_state_b = wait_state)) 
					else '1';


-----------------------------------------------------
--	Output Multiplexers
-----------------------------------------------------
	cas   <= cas_a when clock = '1' else cas_b;
	ras   <= ras_a when clock = '1' else ras_b;
	we    <= we_a  when clock = '1' else we_b;
	ack   <= ack_a when clock = '1' else ack_b;
	dram  <= dram_a when clock = '1' else dram_b;
	ready <= ready_a when clock = '1' else ready_b;

end controller;
