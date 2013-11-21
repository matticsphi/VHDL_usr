----------------------------------------------------------------------------------
-- Company: Ratner Engineering
-- Engineer: bryan mealy
-- 
-- Create Date:    15:27:40 04/27/2007 
-- Design Name: 
-- Module Name:    CLK_DIV_FS
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: This divides the input clock frequency into two slower
--              frequencies. The frequencies are set by the the MAX_COUNT
--              constant in the declarative region of the architecture. 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
--------------------------------------------------------------------------------

-----------------------------------------------------------------------
-----------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-----------------------------------------------------------------------
-- Module to divide the clock 
-----------------------------------------------------------------------
entity clk_div_fs is
    Port (       CLK : in std_logic;
           FCLK,SCLK : out std_logic);
end clk_div_fs;

architecture my_clk_div of clk_div_fs is
   constant MAX_COUNT_SLOW : integer := (9000000);  -- clock divider
   constant MAX_COUNT_FAST : integer := (1100);     -- clock divider 
   signal tmp_clks : std_logic := '0'; 
   signal tmp_clkf : std_logic := '0'; 
	
begin

   my_div_slow: process (clk,tmp_clks)              
      variable div_cnt : integer := 0;   
   begin
      if (rising_edge(clk)) then   
         if (div_cnt = MAX_COUNT_SLOW) then 
            tmp_clks <= not tmp_clks; 
            div_cnt := 0; 
         else
            div_cnt := div_cnt + 1; 
         end if; 
      end if; 
      SCLK <= tmp_clks; 
   end process my_div_slow; 

   my_div_fast: process (clk,tmp_clkf)              
      variable div_cnt : integer := 0;   
   begin
      if (rising_edge(clk)) then   
         if (div_cnt = MAX_COUNT_FAST) then 
            tmp_clkf <= not tmp_clkf; 
            div_cnt := 0; 
         else
            div_cnt := div_cnt + 1; 
         end if; 
      end if; 
      FCLK <= tmp_clkf; 
   end process my_div_fast; 
	
end my_clk_div;

