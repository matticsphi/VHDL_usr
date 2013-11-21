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
	type vector_arrayYC is ARRAY (0 to 15) of std_logic_vector(3 downto 0);
  
   
   --000  LD74 X
   --001  LD30 X
   --010  ADD X, Y
   --011  ADDi X, constant
   --100  SUB X, Y
   --101  BRN constant
   --110  OUT X 
   --111  RETURN
   
    --(SW7:4-1)*SW3:0
   
   constant memOP: vector_arrayOP := ( "000", "001", "100", "100", 
												 "011", "100",
												 "010", "011", "101",
												 "110", "110", "110", "110", "110", "110", "110");
												 
   constant memX: vector_arrayX := ( "0000", "0001", "0010", "0011", 
												 "0000", "0011",
												 "0010", "0011", "1111",
												 "0010", "0010", "0010", "0010",
												 "0010", "0010", "0010");

   constant memYC: vector_arrayYC := ( "1010", "1010", "0010", "0011", 
												 "1111", "0001",
												 "0000", "0001", "1110",
												 "1010", "1010", "1010", "1010",
												 "1010", "1010", "1010");

--   constant memOP: vector_arrayOP := ( "000", "001", "100", "100", 
--												 "011", "100",
--												 "010", "011", "110",
--												 "110", "110", "110", "110", "101", "110", "110");
--												 
--   constant memX: vector_arrayX := ( "0000", "0001", "0010", "0011", 
--												 "0000", "0011",
--												 "0010", "0011", "0010",
--												 "0010", "0010", "0011", "0011",
--												 "1111", "0011", "0011");
--												 
--   constant memYC: vector_arrayYC := ( "0000", "0010", "0010", "0011", 
--												 "1111", "0001",
--												 "0000", "0001", "1010",
--												 "1010", "1010", "1010", "1010",
--												 "1010", "1010", "1110");
	
                                      
   Begin
     
      OP <= memOP(conv_integer(addr));
      Rx <= memX(conv_integer(addr));
      RyC <= memYC(conv_integer(addr));

end Behavioral;