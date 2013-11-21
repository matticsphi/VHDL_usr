----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:17:07 10/08/2009 
-- Design Name: 
-- Module Name:    REGISTER_8BIT - Behavioral 
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

entity REGISTER_8BIT is
port (    CLOCK        : in std_logic;
			  CLEAR         : in std_logic;
			  LOAD 	  : in std_logic;
			  INPUT 	        : in std_logic_vector(7 downto 0);
			  REG_OUT    	  : out std_logic_vector(7 downto 0));
end REGISTER_8BIT;

architecture Behavioral of REGISTER_8BIT is
signal store : std_logic_vector(7 downto 0);
begin
REGISTER_BIT8: process (CLOCK,CLEAR,LOAD,INPUT)
begin
		if(rising_edge(CLOCK) AND LOAD ='1') then		--store the swith when rising edge
			store<=INPUT;
			end if;
		if (CLEAR='1') then
			store <="00000000";							--clear all this shit
		end if;
end process;
REG_OUT<= store;
end Behavioral;

