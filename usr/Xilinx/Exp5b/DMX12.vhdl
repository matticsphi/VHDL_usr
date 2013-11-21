library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

    entity DMX12 is
      Port (    D : in STD_LOGIC;
             ZERO : out STD_LOGIC_VECTOR(3 downto 0);
              ONE : out STD_LOGIC_VECTOR(3 downto 0); 
               DI : in STD_LOGIC_VECTOR(3 downto 0));  
   end DMX12;

    architecture Behavioral of DMX12 is
   
   begin
    
   comb_proc: process(D, DI)
      begin
		   case D is
			   when '0' =>  --Constant
               ZERO <= DI;
            when '1' =>  --Ry
               ONE <= DI;
            when others =>
               ZERO <= "0000";
               ONE <= "0000";
            end case;
      end process comb_proc;  
   
   End Behavioral;