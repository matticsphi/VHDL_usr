library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

    entity Mux41 is
      Port (   MX : in STD_LOGIC_VECTOR(1 downto 0);
             ZERO : in STD_LOGIC_VECTOR(7 downto 0);
              ONE : in STD_LOGIC_VECTOR(7 downto 0);
              TWO : in STD_LOGIC_VECTOR(7 downto 0);
            THREE : in STD_LOGIC_VECTOR(7 downto 0); 
               MO : out STD_LOGIC_VECTOR(7 downto 0));  
   end Mux41;

    architecture Behavioral of Mux41 is
   
   begin
    
   comb_proc: process(MX)
      begin
		   case MX is
			   when "00" =>  --Subtract Ra
               MO <= ZERO;
            when "01" =>  --Add Ra
               MO <= ONE;
            when "10" =>  --Subtract Rb
               MO <= TWO;
            when "11" =>  --Add Rb
               MO <= THREE;
            when others =>
               MO <= "00000000";
            end case;
      end process comb_proc;  
   
   End Behavioral;