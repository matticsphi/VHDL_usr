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
-- state signal is a std_logic_vector rather than an enumeration type
	signal state : std_logic_vector(4 downto 0);
	constant idle    : std_logic_vector(4 downto 0) := "00000";
	constant decision: std_logic_vector(4 downto 0) := "00001";
	constant read1   : std_logic_vector(4 downto 0) := "00100";
	constant read2   : std_logic_vector(4 downto 0) := "01100";
	constant read3   : std_logic_vector(4 downto 0) := "10100";
	constant read4   : std_logic_vector(4 downto 0) := "11100";
	constant write   : std_logic_vector(4 downto 0) := "00010";
begin
state_tr:process(reset, clk) begin											
	if reset = '1' then
		state <= idle;
	elsif rising_edge(clk) then
		case state is						-- outputs not defined here
			when idle    =>
				if (bus_id = "11110011") then
					state <= decision;
				end if; 					-- no else; implicit memory
			when decision=>
				if (read_write = '1') then
					state <= read1;
				else						--read_write='0'
					state <= write;
				end if;
			when read1   =>
				if (ready = '0') then
					state <= read1;
				elsif (burst = '0') then
					state <= idle;
				else
					state <= read2;
				end if;
			when read2   =>
				if (ready = '1') then
					state <= read3;
				end if; 					-- no else; implicit memory
			when read3   =>
				if (ready = '1') then
					state <= read4;
				end if; 					-- no else; implicit memory
			when read4   =>
				if (ready = '1') then
					state <= idle;
				end if; 					-- no else; implicit memory
			when write   =>
				if (ready = '1') then
					state <= idle;
				end if; 					-- no else; implicit memory
			when others =>  
					state <= "-----";			-- don't care if undefined state
		end case;
	end if;
end process state_tr;

-- outputs associated with register values
  we <= state(1);
  oe <= state(2);
  addr <= state(4 downto 3);

end state_machine;
