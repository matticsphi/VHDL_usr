----------------------------------------------------------------------------------
-- Engineer: Cailin Cushing and Darren Childers
-- 
-- Create Date:    11:29:49 10/08/2009 
-- Module Name:    top - Behavioral 
-- Project Name:   Lab 2

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CU is
    Port ( CLK, N  : in  STD_LOGIC;
	        X       : in STD_LOGIC_VECTOR (7 downto 0);
           CTRLS   : out  STD_LOGIC_VECTOR (7 downto 0);
           Rx, RyC, CO : out  STD_LOGIC_VECTOR (3 downto 0));
end CU;

architecture Behavioral of CU is
  
   component Dec39
      Port (   DI : in STD_LOGIC_VECTOR(2 downto 0);
               DP : out STD_LOGIC_VECTOR(7 downto 0);
               PC  : out STD_LOGIC_VECTOR(1 downto 0)); 
   end component;
   
   component Count_3B 
	   port (  Clk, N  : in std_logic;
				  CTRLS   : in std_logic_vector(1 downto 0);
				  X       : in std_logic_vector(7 downto 0);
				  C       : in std_logic_vector(3 downto 0);
  			     Cnt_Out : out std_logic_vector (3 downto 0 ));
   end component;
      
   component romrom
           Port ( addr : in std_logic_vector(3 downto 0);
                  OP      : out std_logic_vector (2 downto 0);
                  Rx, RyC : out std_logic_vector (3 downto 0));
   end component;

	signal sigaddr, sigRyC : STD_LOGIC_VECTOR(3 downto 0);
   
   signal sigOP: STD_LOGIC_VECTOR(2 downto 0);
	
	signal sigPC: STD_LOGIC_VECTOR(1 downto 0);
	
begin
  
   PC: Count_3B port map (     Clk => CLK, --input
										   N => N,
									  CTRLS => sigPC,
                                 X => X,
											C => sigRyC,
  	                       Cnt_Out  => sigaddr);
      
   Imem: romrom port map (    addr => sigaddr,
                                OP => sigOP,
                                Rx => Rx,  --output
                               RyC => sigRyC);--output
   
   Control: Dec39 Port map (   DI => sigOp,
                               DP => CTRLS,--output
                               PC => sigPC);  

	RyC <= sigRyC;
	CO <= sigaddr;
end Behavioral;

