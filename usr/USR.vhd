----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:49:38 01/07/2011 
-- Design Name: 
-- Module Name:    USR - Behavioral 
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

entity USR is
    port ( 		SEL : in std_logic_vector(1 downto 0);
				P_LOAD : in std_logic_vector(7 downto 0);
				 D_OUT : out std_logic_vector(7 downto 0);
					CLK : in std_logic;
		 DR_IN,DL_IN : in std_logic); -- right and left side inputs
end USR;

architecture my_sr of USR is

signal tmp_D : std_logic_vector(7 downto 0);

begin
	process (CLK,SEL,DR_IN,DL_IN,P_LOAD)
	begin
		if (rising_edge(CLK)) then
			case SEL is
				-- do nothing (don't change state) --------------
				when "00" => tmp_D <= tmp_D;
				-- parallel load --------------------------------
				when "01" => tmp_D <= P_LOAD;
				-- shift right ----------------------------------
				when "10" => tmp_D <= DL_IN & tmp_D(7 downto 1);
				-- shift left -----------------------------------
				when "11" => tmp_D <= tmp_D(6 downto 0) & DR_IN;
				-- default case ---------------------------------
				when others => tmp_D <= "00000000";
			end case;
		end if;
	end process;
	
D_OUT <= tmp_D;

end my_sr;