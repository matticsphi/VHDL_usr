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
           DISP_EN : out  STD_LOGIC_VECTOR (3 downto 0));
			 -- LEDS : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is

	component DP
      Port (  CLK  : in STD_LOGIC;
              SW74 : in STD_LOGIC_VECTOR(3 downto 0);
              SW30 : in STD_LOGIC_VECTOR(3 downto 0);
             CTRLS : in STD_LOGIC_VECTOR(7 downto 0);
               ACC : out STD_LOGIC_VECTOR(7 downto 0);
				  MUXO : out STD_LOGIC_VECTOR(7 downto 0));
   end component;
   
   component Count_3B 
	   port ( Clk, Up : in std_logic;
  	         Bin_Out  : out std_logic_vector (3 downto 0 ));
   end component;
      
   component romrom
           Port ( addr : in std_logic_vector(3 downto 0);
               out_val : out std_logic_vector (7 downto 0));
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
	
	signal sigsclk, sigfclk : STD_LOGIC;
          -- SCLK,    FCLK,   LDA,   LDB,   LACC,    Cin
	signal sigacc, sigctrls, sigmo : std_logic_vector(7 downto 0);
          --ACC
   signal sigaddr : STD_LOGIC_VECTOR(3 downto 0);
begin

	Clock: clk_div_fs port map (  CLK => CLK,
										  FCLK => sigfclk,--to Display 
										  SCLK => sigsclk);--to Control Unit & Datapath
   
   Control_Unit: Count_3B port map (     Clk => sigsclk,
                                          Up => '1',
  	                                 Bin_Out  => sigaddr);
      
   Program_ROM: romrom port map (    addr => sigaddr,
                                  out_val => sigctrls);

	Datapath: DP port map (  CLK  => sigsclk,--from Clock
                            SW74 => SW74,
                            SW30 => SW30,
                           CTRLS => sigctrls,
                             ACC => sigacc,
								    MUXO => sigmo);
	
	Display: sseg_dec port map (     	YA => "0000",
													YB => "0000",
											      YC => "0000",
											      YD => "0000",
                                  ALU_VAL => sigacc,--from Datapath
                                      CLK => sigfclk,--from clock
                                 ALU_DISP => '1',
                                  DISP_EN => DISP_EN,--Output
                                 SEGMENTS => SEGMENTS);--Output
											
	LD0 <= sigsclk;
	--LD0 <= '0';
	
end Behavioral;

