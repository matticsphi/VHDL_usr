----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:41:44 10/07/2009 
-- Design Name: 
-- Module Name:    MUX - Behavioral 
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

entity MUX8b_4_2_1 is
port ( A            : in std_logic_vector(7 downto 0);
		 B            : in  std_logic_vector(7 downto 0);
	    SEL		     : in std_logic_vector(1 downto 0);
	    MUX_OUT 	  : out std_logic_vector(7 downto 0));
	
end MUX8b_4_2_1;


architecture behavioral of MUX8b_4_2_1 is
begin
with SEL select						--select is the key to get one or the other.
	MUX_OUT <=		 A when "00",
					NOT A when "01",				--inverters built right on it
						 B when "10",
					NOT B when "11",				--inverter built right on you can put in TOP MODULE
					"00000000" when others;
end behavioral;
