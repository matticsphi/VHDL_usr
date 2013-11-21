library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Count_3B is
	port ( Clk, N  : in std_logic;
			 CTRLS   : in std_logic_vector(1 downto 0);
          X       : in std_logic_vector(7 downto 0);
          C       : in std_logic_vector(3 downto 0);
  			 Cnt_Out : out std_logic_vector (3 downto 0 ));

end Count_3B;

architecture count of COUNT_3B is 
	signal cnt : std_logic_vector ( 3 downto 0 ); 
begin
	process (Clk, CTRLS)
	begin
		if (rising_edge(Clk)) then
			if (CTRLS(1) = '1') then
            if (N = '1') then
				   cnt <= cnt + C;
				else
					cnt <= cnt + 1;
				end if;
			elsif (CTRLS(0) = '1') then
            cnt <= X(3 downto 0) + 1;
         else
				cnt <= cnt + 1;
			end if;
		end if;
	end process;
	Cnt_Out <= cnt;
end count; 