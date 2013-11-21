library ieee;
use ieee.std_logic_1164.all;
entity memory_controller is port (
     reset, read_write, ready,
     burst, clk                   : in std_logic;
     bus_id                       : in std_logic_vector(7 downto 0);
     oe, we                       : out std_logic;
     addr                         : out std_logic_vector(1 downto 0));
end memory_controller;

architecture state_machine of memory_controller is
	type StateType is (idle, decision, read1, read2, read3, read4, write);
	signal present_state, next_state : StateType;
begin
state_comb:process(reset, bus_id, present_state, burst, read_write, ready) begin
	if (reset = '1') then
		oe <= '-'; we <= '-'; addr <= "--";
		next_state <= idle;
	else
		case present_state is
			when idle    => 		oe <= '0'; we <= '0'; addr <= "00";
				if (bus_id = "11110011") then
					next_state <= decision;
				else
					next_state <= idle;
				end if;
			when decision=>  		oe <= '0'; we <= '0'; addr <= "00";
				if (read_write = '1') then
					next_state <= read1;
				else                    --read_write='0'
					next_state <= write;
				end if;
			when read1   =>  		oe <= '1'; we <= '0'; addr <= "00";
				if (ready = '0') then
					next_state <= read1;
				elsif (burst = '0') then
					next_state <= idle;
				else
					next_state <= read2;
				end if;
			when read2   =>  		oe <= '1'; we <= '0'; addr <= "01";
				if (ready = '1') then
					next_state <= read3;
				else
					next_state <= read2;
				end if;
			when read3   =>  		oe <= '1'; we <= '0'; addr <= "10";
				if (ready = '1') then
					next_state <= read4;
				else
					next_state <= read3;
				end if;
			when read4   =>  		oe <= '1'; we <= '0'; addr <= "11";
				if (ready = '1') then
					next_state <= idle;
				else
					next_state <= read4;
				end if;
			when write   =>  		oe <= '0'; we <= '1'; addr <= "00";
				if (ready = '1') then
					next_state <= idle;
				else
					next_state <= write;
				end if;
		end case;
	end if;
end process state_comb;

state_clocked:process(clk) begin
	if rising_edge(clk) then
		present_state <= next_state;
	end if;
end process state_clocked;

end;
