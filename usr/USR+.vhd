----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:00:32 01/07/2011 
-- Design Name: 
-- Module Name:    USR+ - Behavioral 
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

entity USR+ is
    Port ( SEL : in  STD_LOGIC_VECTOR (1 downto 0);
           P_LOAD : in  STD_LOGIC_VECTOR (7 downto 0);
           D_OUT : out  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           DR_IN, DL_IN : in  STD_LOGIC);
end USR+;

architecture Behavioral of USR+ is

begin


end Behavioral;

