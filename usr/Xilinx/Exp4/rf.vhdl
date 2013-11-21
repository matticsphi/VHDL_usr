----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:14:38 10/23/2008 
-- Design Name: 
-- Module Name:    rf - Behavioral 
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

entity regfile is -- three-port register file
  port(clk:           in  STD_LOGIC;
       we3:           in  STD_LOGIC;
       ra1, ra2, wa3: in  STD_LOGIC_VECTOR(3 downto 0);
       wd3:           in  STD_LOGIC_VECTOR(7 downto 0);
       rd1, rd2:      out STD_LOGIC_VECTOR(7 downto 0));
end;

architecture Behavioral of regfile is
  type ramtype is array (15 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
  signal mem: ramtype;
begin
  -- three-ported register file
  -- read two ports combinationally
  -- write third port on rising edge of clock
  
  process(clk) begin
    if (clk'event and clk = '1') then
       if we3 = '1' then mem(CONV_INTEGER(wa3)) <= wd3;
       end if;
    end if;
  end process;

  rd1 <= mem(CONV_INTEGER(ra1));
  rd2 <= mem(CONV_INTEGER(ra2));



end Behavioral;

