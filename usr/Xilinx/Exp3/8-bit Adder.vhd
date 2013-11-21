----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:47:10 10/07/2009 
-- Design Name: 
-- Module Name:    8-bit Adder - Behavioral 
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

entity Eightbit_Adder is
    Port ( MuxIn : in  STD_LOGIC_VECTOR (7 downto 0);
           AccIn : in  STD_LOGIC_VECTOR (7 downto 0);
           CIN : in  STD_LOGIC;
           AddOut : out  STD_LOGIC_VECTOR (7 downto 0));
end Eightbit_Adder;

architecture allAdd of Eightbit_Adder is

begin

AddOut <= MuxIn + AccIn + CIN;

end allAdd;

