----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:16:46 10/07/2009 
-- Design Name: 
-- Module Name:    ADDER - Behavioral 
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

entity ADDER is
port (     C_IN       : in std_logic;
			  A    		 : in std_logic_vector(7 downto 0);
			  B    	    : in std_logic_vector(7 downto 0);
			  S   		 : out std_logic_vector(7 downto 0));
end ADDER;

architecture Behavioral of ADDER is

begin

S <= A + B + C_IN ;				--simple adder.


end Behavioral;

