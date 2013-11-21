library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

    entity Dec39 is
      Port (   DI : in STD_LOGIC_VECTOR(2 downto 0);
               DO : out STD_LOGIC_VECTOR(7 downto 0);
               R  : out STD_LOGIC);  
   end Dec39;

    architecture Behavioral of Dec39 is
   
   begin
    
   comb_proc: process(DI)
      begin
		   case DI is
			   when "000" =>  --LD74 X
               DO <= "00000001";
               R <= '0';
            when "001" =>  --LD30 X
               DO <= "00100001";
               R <= '0';
            when "010" =>  --ADD X,Y
               DO <= "11000001";
               R <= '0';
            when "011" =>  --ADDi X
               DO <= "01010001";
               R <= '0';
            when "100" =>  --SUB X,Y
               DO <= "11001101";
               R <= '0';
            when "101" =>  --SUBi X
               DO <= "01011101";
               R <= '0';
            when "110" =>  --OUT X
               DO <= "00000010";
               R <= '0';
            when "111" =>  --RESTART
               R <= '1';
            when others =>
               DO <= "00000000";
            end case;
      end process comb_proc;  
   
   End Behavioral;