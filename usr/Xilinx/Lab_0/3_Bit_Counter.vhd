----------------------------------------------------------------------------------
-- Company: Cal Poly
-- Engineer: Conrad Verser & Winston Ho
-- 
-- Create Date:    12:38:37 09/24/2009 
-- Design Name:    3_Bit_Counter
-- Module Name:    3_Bit_Counter - Behavioral 
-- Project Name:   3_Bit_Counter
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

entity 3_Bit_Counter is
    Port ( CLK : in  STD_LOGIC;
           UP_DOWN : in  STD_LOGIC;
           SEGMENTS : out  STD_LOGIC_VECTOR (0 downto 7);
           DISP_EN : out  STD_LOGIC_VECTOR (0 downto 3));
end 3_Bit_Counter;

architecture Behavioral of 3_Bit_Counter is

	component clk_div_fs-my_clk_div 
		Port (       CLK : in std_logic;
				FCLK,SCLK : out std_logic);
	end component;
	
begin


end Behavioral;

