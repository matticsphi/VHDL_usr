library IEEE;
   use IEEE.STD_LOGIC_1164.ALL;
   use IEEE.STD_LOGIC_ARITH.ALL;
   use IEEE.STD_LOGIC_UNSIGNED.ALL;

    entity Reg is
      Port (  CLK : in STD_LOGIC;
               SW : in STD_LOGIC_VECTOR(7 downto 0);
              CLR : in STD_LOGIC;
             LoaD : in STD_LOGIC;
               RO : out STD_LOGIC_VECTOR(7 downto 0));   
      end Reg;

  architecture Behavioral of Reg is
   
   begin
   
		process(CLK, CLR)
      begin
			if(CLR = '1') then 
				RO <= "00000000";
         elsif (rising_edge(CLK))then 
            if(LoaD = '1') then RO <= SW;
            end if;
         end if;
      end process;
  
   End Behavioral;