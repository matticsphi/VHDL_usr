LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.std_arith.all;
USE work.count_lib.all;
ENTITY total IS
	GENERIC (size:integer:=5);
	PORT (          car_enter       : in std_logic;
			car_exit        : in std_logic; 
			reset           : in std_logic;
			lot_empty       : buffer std_logic;
			lot_full        : buffer std_logic; 
	  count1          : inout std_logic_vector((size-1) downto 0);
	  count2          : inout std_logic_vector((size-1) downto 0);
	  total           : buffer std_logic_vector ((size-1) downto 0));
attribute synthesis_off of total:signal is true;
END total;



ARCHITECTURE archtotal OF total IS

SIGNAL full     : std_logic_vector((size-1) downto 0);

BEGIN


full <= (others => '1'); 
	lot_empty <= '1' when (total ="0000") else '0';
	lot_full <= '1' when (total = full) else '0';

counter1: counter
	GENERIC MAP(size-1)
	PORT MAP(car_enter, reset, count1);

counter2: counter
	  GENERIC MAP(size-1)
	PORT MAP(car_exit, reset, count2);
	
total <= count1 - count2;


END archtotal;

