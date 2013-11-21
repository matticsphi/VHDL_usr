library IEEE;
   use IEEE.STD_LOGIC_1164.ALL;
   use IEEE.STD_LOGIC_ARITH.ALL;
   use IEEE.STD_LOGIC_UNSIGNED.ALL;

    entity FF is
      Port (  CLK : in STD_LOGIC;
                D : in STD_LOGIC;
                Q : out STD_LOGIC);   
      end FF;

    architecture Behavioral of FF is
   
   begin
   
   sync_proc: 
       process(CLK)
      begin
         if (rising_edge(CLK))then 
				Q <= D;
         end if;
      end process sync_proc;
      
   End Behavioral;