library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Count_3B is
	port ( Clk, Up : in std_logic;
  			Bin_Out  : out std_logic_vector (3 downto 0 ));

end Count_3B;

architecture count of COUNT_3B is 
	signal cnt : std_logic_vector ( 3 downto 0 ); 
begin
	process (Clk)
	begin
		if (rising_edge(Clk)) then
			if (Up = '1') then
				cnt <= cnt +1;
			else
				cnt <= cnt -1;
			end if;
		end if;
	end process;
	Bin_Out <= cnt;
end count; 