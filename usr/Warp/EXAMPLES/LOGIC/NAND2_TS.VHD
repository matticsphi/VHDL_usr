library ieee;
use ieee.std_logic_1164.all;

--Two input NAND gate with three-state output
--This design is DEVICE DEPENDENT.  

USE work.rtlpkg.all;			-- needed for triout

ENTITY threeStateNand2 IS
	PORT (a, b, outen: IN std_logic;
		c: INOUT std_logic);
END threeStateNand2;

ARCHITECTURE show OF threeStateNand2 IS
SIGNAL temp: std_logic;

BEGIN
	temp <= a NAND b;
	tri1: triout PORT MAP (temp, outen, c);
END show;

