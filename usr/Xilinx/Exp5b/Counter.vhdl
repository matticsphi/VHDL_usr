library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Count_3B is
	port ( Clk, Reset : in std_logic;
  			 Cnt_Out    : out std_logic_vector (3 downto 0 ));

end Count_3B;

architecture count of COUNT_3B is 
	signal cnt : std_logic_vector ( 3 downto 0 ); 
begin
	process (Clk)
	begin
		if (rising_edge(Clk)) then
			if (Reset = '1') then
				cnt <= "0000";
			else
				cnt <= cnt + 1;
			end if;
		end if;
	end process;
	Cnt_Out <= cnt;
end count; 