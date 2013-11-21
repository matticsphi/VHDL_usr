----------------------------------------------------------------------------------
-- Company: Ratner Engineering
-- Engineer: bryan mealy
-- 
-- Create Date:    15:27:40 05/28/2007 
-- Design Name: 
-- Module Name:    BC_DEC
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Special 7-segment display driver (4-letter words only)
--
--  One Input:  Z
--
--      Z = '1': COOL
--      Z = '0': CrAP 
-- Dependencies: 
--
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

-------------------------------------------------------------
-- Two wordt seven-segment display driver. Outputs are active
-- low and configured ABCEDFG in "segment" output. 
--------------------------------------------------------------
entity BC_DEC is
    Port (    CLK,Z : in std_logic;   
            DISP_EN : out std_logic_vector(3 downto 0);
           SEGMENTS : out std_logic_vector(7 downto 0));
end BC_DEC;

-------------------------------------------------------------
-- description of ssegment decoder
-------------------------------------------------------------
architecture BC_DEC of BC_DEC is

   component clk_div
       Port (  clk : in std_logic;
              sclk : out std_logic);
   end component;
   
   -- intermediate signal declaration -----------------------
   signal   cnt_dig : std_logic_vector(1 downto 0); 
   signal   digit   : std_logic_vector (3 downto 0); 
   signal   sclk    : std_logic; 

begin

   my_clk: clk_div 
   port map (clk => clk,
             sclk => sclk ); 

   -- advance the count (used for display multiplexing) -----
   process (SCLK)
   begin
      if (rising_edge(SCLK)) then 
         cnt_dig <= cnt_dig + 1; 
      end if; 
   end process; 

   -- select the display sseg data abcdefg (active low) -----
   segments <= "01100011" when digit = "0000"  else -- C
               "00000011" when digit = "0001"  else -- O
               "00000011" when digit = "0010"  else -- O
               "11100011" when digit = "0011"  else -- L
               "01100011" when digit = "0100"  else -- C
               "11110101" when digit = "0101"  else -- r
               "00010001" when digit = "0110"  else -- A
               "00110001" when digit = "0111"  else -- P
               "11111111"; 

   -- actuate the correct display --------------------------
   disp_en <= "1110" when cnt_dig = "00" else 
              "1101" when cnt_dig = "01" else
              "1011" when cnt_dig = "10" else
              "0111" when cnt_dig = "11" else
              "1111"; 

 
   process (cnt_dig,Z)
      begin
      if (Z = '1') then
         case cnt_dig is
            when "00" => digit <= "0000"; -- cool
            when "01" => digit <= "0001"; 
            when "10" => digit <= "0010"; 
            when "11" => digit <= "0011"; 
            when others => digit <= "0000"; 
         end case; 
      else
         case cnt_dig is 
            when "00" => digit <= "0100"; -- bad
            when "01" => digit <= "0101"; 
            when "10" => digit <= "0110"; 
            when "11" => digit <= "0111"; 
            when others => digit <= "0000";
         end case;
      end if;
   end process;
         
end BC_DEC;




-----------------------------------------------------------------------
-----------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-----------------------------------------------------------------------
-- Module to divide the clock 
-----------------------------------------------------------------------
entity clk_div is
    Port (  clk : in std_logic;
           sclk : out std_logic);
end clk_div;

architecture my_clk_div of clk_div is
   constant max_count : integer := (1100);  
   signal tmp_clk : std_logic := '0'; 
begin
   my_div: process (clk,tmp_clk)              
      variable div_cnt : integer := 0;   
   begin
      if (rising_edge(clk)) then   
         if (div_cnt = MAX_COUNT) then 
            tmp_clk <= not tmp_clk; 
            div_cnt := 0; 
         else
            div_cnt := div_cnt + 1; 
         end if; 
      end if; 
      sclk <= tmp_clk; 
   end process my_div; 
end my_clk_div;
