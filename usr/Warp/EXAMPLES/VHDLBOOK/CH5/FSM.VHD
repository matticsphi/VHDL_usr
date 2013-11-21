entity example is port (
	read_write, ready, clk  : in bit;
	oe, we                  : out bit);
end example;

architecture state_machine of example is
	type StateType is (idle, decision, read, write);
	signal present_state, next_state : StateType;
begin
state_comb:process(present_state, read_write, ready) begin
	case present_state is
		when idle => 		oe <= '0'; we <= '0';
			if ready = '1' then
				next_state <= decision;
			else
				next_state <= idle;
			end if;
		when decision => 		oe <= '0'; we <= '0'; 
			if (read_write = '1') then
				next_state <= read;
			else        --read_write='0'
				next_state <= write;
			end if;
		when read =>			oe <= '1'; we <= '0'; 
			if (ready = '1') then
				next_state <= idle;
			else
				next_state <= read;
			end if;
		when write => 			oe <= '0'; we <= '1'; 
			if (ready = '1') then
				next_state <= idle;
			else
				next_state <= write;
			end if;
	end case;
end process state_comb;

state_clocked:process(clk) begin
	if (clk'event and clk='1') then
		present_state <= next_state;
	end if;
end process state_clocked;

end architecture state_machine; --"architecture" is optional; for clarity
