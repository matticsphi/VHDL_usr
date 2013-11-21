library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity romrom is

   Port ( addr : in std_logic_vector(3 downto 0);
         out_val : out std_logic_vector (7 downto 0));

end romrom;

architecture Behavioral of romrom is
  
   type vector_array is ARRAY (0 to 15) of std_logic_vector(7 downto 0);
   
   --LDRA  00010001
   --LDRB  00000010
   --LDACC 00100100
   --ADDA  00100100
   --ADDB  01100100
   --SUBA  10000100
   --SUBB  11000100
   --CLRC  00001000
   --MOV2A 00000001
	--Nothing 00000000
   
   --3*SW7:4-2*SW3:0
   constant memory: vector_array := ( "00010001", "00000010", "00100100", "00100100", "00100100",
                                      "11000100", "11000100", "00000000", "00000000", "00000000",
                                      "00000000", "00000000", "00000000", "00000000", "00000000", "00001000" );
   Begin
     
    -- output <= place in memory defined by addr  
      out_val <= memory(conv_integer(addr));

end Behavioral;