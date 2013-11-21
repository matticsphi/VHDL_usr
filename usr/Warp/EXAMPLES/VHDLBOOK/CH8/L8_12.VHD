library ieee;
use ieee.std_logic_1164.all;
use work.std_arith.all;
entity dram_controller is port (
					addr: 			in std_logic_vector(31 downto 0);											 -- system address
					clock,													 	 -- clock 20MHz
					ads,														 -- address strobe
					read_write,				 										 -- read/write
					reset:			in std_logic;											 -- system reset
					ack:  			out std_logic;											 -- acknowledge
					we:   			out std_logic;											 -- write enable
					ready:			out std_logic;											 -- data ready for latching
					dram: 			out std_logic_vector (9 downto 0);											-- DRAM address
					ras:  			out std_logic_vector(1 downto 0);	 										-- row address strobe
					cas:  			out std_logic_vector(3 downto 0));											-- column address strobe
end dram_controller;

architecture controller of dram_controller is
	type states is (idle, address_detect, row_address, ras_assert,
					col_address, cas_assert, data_ready, wait_state, refresh0,
					refresh1);
	signal present_state, next_state: states;
	signal stored: 						std_logic_vector(31 downto 0);											-- latched addr
	signal ref_timer:						std_logic_vector(8 downto 0);											-- refresh timer
	signal ref_request: 						std_logic;											-- refresh request
	signal match: 						std_logic;			 								-- address match
	signal read: 						std_logic;			 								-- latched read_write
	-- row and column address aliases
	alias row_addr: 					std_logic_vector(9 downto 0) is stored(19 downto 10);
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
--                    Address Multiplexer                   --
--------------------------------------------------------------
-- The address multiplexer selects the row, column, or refresh 
-- address depending on the current cycle

multiplexer: process (row_addr, col_addr, present_state)
	begin
		if ( present_state = row_address or present_state = ras_assert) then
			dram <= row_addr;
		else
			dram <= col_addr;
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
			   (ref_request = '1' and present_state /= refresh0))
		 else '0';

------------------------------------------------------------
--       DRAM State Machine                               --
------------------------------------------------------------
-- The DRAM controller state machine controls the state of
-- the address multiplexer select lines as well as the
-- state of RAS and CAS 

state_tr: process (present_state, ref_request, ads, match)
	begin
		case present_state is
	when idle => 
		if ref_request = '1' then
			next_state <= refresh0;
		elsif ads = '0' then
			next_state <= address_detect;
		else
			next_state <= idle;
		end if;
	when address_detect =>
		if match = '1' then
			next_state <= row_address;
		else 
			next_state <= idle;
		end if;
	when row_address =>
		next_state <= ras_assert;
	when ras_assert =>
		next_state <= col_address;
	when col_address =>
		next_state <= cas_assert;
	when cas_assert =>
		next_state <= data_ready;
	when data_ready =>
		next_state <= wait_state;
	when wait_state =>
		next_state <= idle;
	when refresh0 =>
		next_state <= refresh1;
	when refresh1 =>
		next_state <= idle;
		end case;
	end process;

clocked: process (reset, clock)
	begin 
		if reset = '1' then
			present_state <= idle;
		elsif (clock'event and clock = '1') then
			present_state <= next_state;	
		end if;
	end process;

	with present_state select
		cas <=			"0000" when cas_assert | data_ready | wait_state | 
									refresh0 | refresh1,
					"1111" when others;	

	ras <= 			"00" when (present_state = refresh1) 
				else "01" when ((present_state = ras_assert or 
								present_state = col_address or
								present_state = cas_assert or 
								present_state = data_ready or
								present_state = wait_state) and stored(20)='1')
				else "10" when ((present_state = ras_assert or 
								present_state = col_address or
								present_state = cas_assert or 
							present_state = data_ready or
							present_state = wait_state) and stored(20)='0')
		else "11";

	we <=		'0' when ((present_state = col_address or 
						  present_state = cas_assert or
						  present_state = data_ready) and read = '0')
			else '1';

	ack <= 			'0' when (present_state = address_detect and match = '1') 
				else '1';

	ready <= 			'0' when (read = '1' and (present_state = data_ready or 
						    present_state = wait_state)) 
				else '1';

end controller;
