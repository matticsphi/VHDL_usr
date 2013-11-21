library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

    entity Mux21 is
      Port (   MX : in STD_LOGIC;
             ZERO : in STD_LOGIC_VECTOR(7 downto 0);
              ONE : in STD_LOGIC_VECTOR(7 downto 0); 
               MO : out STD_LOGIC_VECTOR(7 downto 0));  
   end Mux21;

    architecture Behavioral of Mux21 is
   
   begin
    
   comb_proc: process(MX)
      begin
		   case MX is
			   when '0' =>  --Acc
               MO <= ZERO;
            when '1' =>  --SW74
               MO <= ONE;
            when others =>
               MO <= "00000000";
            end case;
      end process comb_proc;  
   
   End Behavioral;