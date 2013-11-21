----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:29:49 10/08/2009 
-- Design Name: 
-- Module Name:    top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( CLK : in  STD_LOGIC;
           SW74 : in  STD_LOGIC_VECTOR (3 downto 0);
           SW30 : in  STD_LOGIC_VECTOR (3 downto 0);
           CLR : in  STD_LOGIC;
           LD0 : out  STD_LOGIC;
           SEGMENTS : out  STD_LOGIC_VECTOR (6 downto 0);
           DISP_EN : out  STD_LOGIC_VECTOR (3 downto 0));
end top;

architecture Behavioral of top is

	component DP
      Port (  CLK  : in STD_LOGIC;
            CLR : in STD_LOGIC;
           SW74 : in STD_LOGIC_VECTOR(3 downto 0);
           SW30 : in STD_LOGIC_VECTOR(3 downto 0);
            LDA : in STD_LOGIC;
            LDB : in STD_LOGIC;
          LDACC : in STD_LOGIC;
            Cin : in STD_LOGIC;
             MX : in STD_LOGIC_VECTOR(1 downto 0);
            ACC : out STD_LOGIC_VECTOR(7 downto 0));
   end component;

	component FSM
	Port (     CLK : in STD_LOGIC;
	           LDA : out STD_LOGIC;
              LDB : out STD_LOGIC;
            LDACC : out STD_LOGIC;
              Cin : out STD_LOGIC;
               mx : out STD_LOGIC_VECTOR(1 downto 0));   
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
	
	signal sigsclk, sigfclk, sigla, siglb, siglac, sigcin : STD_LOGIC;
	signal sigac : std_logic_vector(7 downto 0);
	signal sigmx : STD_LOGIC_VECTOR(1 downto 0);
	
begin

	Clock: clk_div_fs port map (  CLK => CLK,
										  FCLK => sigfclk,
										  SCLK => sigsclk);
	
	Control_Unit: FSM port map(   CLK => sigsclk,
										   LDA => sigla,
                                 LDB => siglb,
                               LDACC => siglac,
                                 Cin => sigcin,
                                  mx => sigmx);  
	
	Datapath: DP port map (  CLK  => sigsclk,
											  CLR => CLR,
                                  SW74 => SW74,
                                  SW30 => SW30,
                                   LDA => sigla,
                                   LDB => siglb,
                                 LDACC => siglac,
                                   Cin => sigcin,
                                    MX => sigmx,
                                   ACC => sigac);
	
	Display: sseg_dec port map (     	YA => "0000",
													YB => "0000",
											      YC => "0000",
											      YD => "0000",
                                  ALU_VAL => sigac,
                                      CLK => sigfclk,
                                 ALU_DISP => '1',
                                  DISP_EN => DISP_EN,
                                 SEGMENTS => SEGMENTS);
											
	LD0 <= sigsclk;

end Behavioral;

