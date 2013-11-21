library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

    entity Mux is
      Port (   MX : in STD_LOGIC_VECTOR(1 downto 0);
             ZERO : in STD_LOGIC_VECTOR(7 downto 0);
              ONE : in STD_LOGIC_VECTOR(7 downto 0);
              TWO : in STD_LOGIC_VECTOR(7 downto 0);
            THREE : in STD_LOGIC_VECTOR(7 downto 0); 
               MO : out STD_LOGIC_VECTOR(7 downto 0));  
   end Mux;

    architecture Behavioral of Mux is
   
   begin
    
   comb_proc: process(MX)
      begin
		   case MX is
			   when "00" =>
               MO <= ZERO;
            when "01" =>
               MO <= ONE;
            when "10" =>
               MO <= TWO;
            when "11" =>
               MO <= THREE;
            when others =>
               MO <= "00000000";
            end case;
      end process comb_proc;  
   
   End Behavioral;