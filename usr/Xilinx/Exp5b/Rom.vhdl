library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity romrom is

   Port ( addr    : in std_logic_vector(3 downto 0);
          OP      : out std_logic_vector (2 downto 0);
          Rx, RyC : out std_logic_vector (3 downto 0));

end romrom;

architecture Behavioral of romrom is
  
   type vector_arrayOP is ARRAY (0 to 15) of std_logic_vector(2 downto 0);
	type vector_arrayX is ARRAY (0 to 15) of std_logic_vector(3 downto 0);
	type vector_arrayY is ARRAY (0 to 15) of std_logic_vector(3 downto 0);
      
   --3*(SW7:4-1)-2*SW3:0
   constant memOP: vector_arrayOP := ( "000", "000", "001", "101", "101", 
													"010", "010", "100", "100", "110", 
													"110", "110", "110", "110", "110", "111");
   constant memX: vector_arrayX := ( "0010", "0000", "0001", "0000", "0010", 
												 "0000", "0000", "0000", "0000", "0000", 
												 "0000", "0000", "0000", "0000", "0000", "1110");
   constant memYC: vector_arrayY := ( "1111", "1111", "1111", "0001", "0001", 
												  "0010", "0010", "0001", "0001", "1111", 
												  "1111", "1111", "1111", "1111", "1111", "1111");
                                      
   Begin
     
      OP <= memOP(conv_integer(addr));
      Rx <= memX(conv_integer(addr));
      RyC <= memYC(conv_integer(addr));

end Behavioral;