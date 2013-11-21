library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

    entity Dec39 is
      Port (   DI : in STD_LOGIC_VECTOR(2 downto 0);
               DP : out STD_LOGIC_VECTOR(7 downto 0);
               PC  : out STD_LOGIC_VECTOR(1 downto 0));  
   end Dec39;

    architecture Behavioral of Dec39 is
   
   begin
   --BE MW MW MA MA Cin OE WE
	--BE RE
   comb_proc: process(DI)
      begin
		   case DI is
			   when "000" =>  --LD74 X
               DP <= "00000001";
               PC <= "00";
            when "001" =>  --LD30 X
               DP <= "00100001";
               PC <= "00";
            when "010" =>  --ADD X,Y
               DP <= "01000001";
               PC <= "00";
            when "011" =>  --ADDi X
               DP <= "01010001";
               PC <= "00";
            when "100" =>  --SUB X,Y
               DP <= "01001101";
               PC <= "00";
            when "101" =>  --BRN C
               DP <= "11000001";
               PC <= "10";
            when "110" =>  --OUT X
               DP <= "00000010";
               PC <= "00";
            when "111" =>  --RETURN
               DP <= "00000000";
					PC <= "01";
            when others =>
               DP <= "00000000";
					PC <= "00";
            end case;
      end process comb_proc;   
   
   End Behavioral;