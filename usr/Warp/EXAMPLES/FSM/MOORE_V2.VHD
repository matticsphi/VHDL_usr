library ieee;
use ieee.std_logic_1164.all;

entity moore2 is port(
	clk, rst:	in std_logic;
	id:		in std_logic_vector(3 downto 0);
	y:		out std_logic_vector(1 downto 0));
end moore2;

architecture archmoore2 of moore2 is
	type states is (state0, state1, state2, state3, state4);
	signal state: states;
begin
moore: process (clk, rst) 
	begin
		if rst='1' then 
			state <= state0;
			y <= "00";
		elsif (clk'event and clk='1') then
			case state is
				when state0 =>
					if id = x"3" then
						state <= state1;
						y <= "10";
					else
						state <= state0;
						y <= "00";
					end if;
				when state1 =>
					state <= state2;
					y <= "11";
				when state2 =>
					if id = x"7" then
						state <= state3;
						y <= "10";
					else
						state <= state2;
						y <= "11";
					end if;
				when state3 =>
					if id < x"7" then 
						state <= state0;
						y <= "00";
					elsif id = x"9" then
						state <= state4;
						y <= "11";
					else
						state <= state3;
						y <= "10";
					end if;
				when state4 =>
					if id = x"b" then
						state <= state0;
						y <= "00";
					else
						state <= state4;
						y <= "11";
					end if;
			end case;
		end if;
	end process;

end archmoore2;
