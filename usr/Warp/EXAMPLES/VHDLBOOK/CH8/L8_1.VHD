library ieee;
use ieee.std_logic_1164.all;
use work.std_arith.all;
entity counter is port(
					clk, reset: in std_logic;
					count:      buffer std_logic_vector(3 downto 0));
end counter;

architecture archcounter of counter is
begin
upcount: process (clk, reset)
					begin
						if reset = '1' then
							count <= "1010"; 
						elsif (clk'event and clk= '1') then
							count <= count + 1;
						end if;  
					end process upcount;
end archcounter;
