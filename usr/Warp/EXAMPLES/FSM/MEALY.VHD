library ieee;
use ieee.std_logic_1164.all;

entity mealy1 is port(
	clk, rst:	in std_logic;
	id:		in std_logic_vector(3 downto 0);
	w:		out std_logic;
	y:		out std_logic_vector(1 downto 0));
end mealy1;

architecture archmealy1 of mealy1 is
	type states is (state0, state1, state2, state3, state4);
	signal state: states;
begin
moore: process (clk, rst) 
	begin
		if rst='1' then 
			state <= state0;
		elsif (clk'event and clk='1') then
			case state is
				when state0 =>
					if id = x"3" then
						state <= state1;
					else
						state <= state0;
					end if;
				when state1 =>
					state <= state2;
				when state2 =>
					if id = x"7" then
						state <= state3;
					else
						state <= state2;
					end if;
				when state3 =>
					if id < x"7" then 
						state <= state0;
					elsif id = x"9" then
						state <= state4;
					else
						state <= state3;
					end if;
				when state4 =>
					if id = x"b" then
						state <= state0;
					else
						state <= state4;
					end if;
			end case;
		end if;
	end process;

--assign moore state outputs;
y <= "00" when (state=state0) else
     "10" when (state=state1 or state=state3) else
     "11"; 
--assign mealy output;
w <= '0' when (state=state3 and id < x"7") else
     '1';
end archmealy1;
