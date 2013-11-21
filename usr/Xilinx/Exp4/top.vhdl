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

entity top is
    Port ( CLK : in  STD_LOGIC;
           SW74 : in  STD_LOGIC_VECTOR (3 downto 0);
           SW30 : in  STD_LOGIC_VECTOR (3 downto 0);
           LD0 : out  STD_LOGIC;
           SEGMENTS : out  STD_LOGIC_VECTOR (6 downto 0);
           DISP_EN : out  STD_LOGIC_VECTOR (3 downto 0);
			  LEDS : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is

	component DP
      Port (  CLK  : in STD_LOGIC;
             SW_74, SW_30, Rx, RyC, CNT : in STD_LOGIC_VECTOR(3 downto 0);
             CTRLS                      : in STD_LOGIC_VECTOR(7 downto 0);
				 N								  	 : out STD_LOGIC;
				 TEST : out STD_LOGIC_Vector (7 downto 0);
             DP_OUT, X                  : out STD_LOGIC_VECTOR(7 downto 0));
   end component;
   
   component CU
		Port ( CLK, N  : in  STD_LOGIC;
	          X       : in STD_LOGIC_VECTOR (7 downto 0);
             CTRLS   : out  STD_LOGIC_VECTOR (7 downto 0);
             Rx, RyC, CO : out  STD_LOGIC_VECTOR (3 downto 0));
   end component;
	
   component clk_div_fs
    Port (       CLK : in std_logic;
           FCLK,SCLK : out std_logic);
	end component;

	component sseg_dec
    Port (  YA,YB,YC,YD : in std_logic_vector(3 downto 0);
                ALU_VAL : in std_logic_vector(7 downto 0); 
                    CLK : in std_logic;
               ALU_DISP : in std_logic;
                DISP_EN : out std_logic_vector(3 downto 0);
               SEGMENTS : out std_logic_vector(6 downto 0));
	end component;
	
	signal sigsclk, sigfclk, sigN : STD_LOGIC;
       
	signal sigDPO, sigctrls, sigX, sigCCO: std_logic_vector(7 downto 0);
      
   signal sigRx, sigRyC, sigCO : STD_LOGIC_VECTOR(3 downto 0);
   
	
  begin

	Clock: clk_div_fs port map (  CLK => CLK,
										  FCLK => sigfclk,--to Display 
										  SCLK => sigsclk);--to Control Unit & Datapath
   
   Control_Unit: CU Port map ( CLK => sigsclk, --from Clock
                             CTRLS => sigctrls, --to Datapath
                                Rx => sigRx,
										  CO => sigCO,
										   N => sigN,
											X => sigX,
                               RyC => sigRyC); 

   
	Datapath: DP port map (  CLK  => sigsclk,--from Clock
                            SW_74 => SW74,
                            SW_30 => SW30,
                           CTRLS => sigctrls,
                              Rx => sigRx,
                             RyC => sigRyC,
									  CNT => sigCO,
									    N => sigN,
										 X => sigX,
										 TEST => sigCCO,
								  DP_OUT => sigDPO);
	
	Display: sseg_dec port map (     	YA => "0000",
													YB => "0000",
											      YC => "0000",
											      YD => "0000",
                                  ALU_VAL => sigDPO,--from Datapath
                                      CLK => sigfclk,--from clock
                                 ALU_DISP => '1',
                                  DISP_EN => DISP_EN,--Output
                                 SEGMENTS => SEGMENTS);--Output
	
  -- sigCCO <= "0000" & sigCO;
	
	LD0 <= sigsclk;
	--LEDS(7 downto 4) <= SW74;
	--LEDS(3 downto 0) <= SW30;
	
end Behavioral;

