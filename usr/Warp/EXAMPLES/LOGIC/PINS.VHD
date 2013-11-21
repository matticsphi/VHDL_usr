library ieee;
use ieee.std_logic_1164.all;

--This example shows how to use attributes to assign pins.
--Signals that are not assigned to pins can be automatically
--assigned pins by Warp.  This design uses the CY7C371 PLCC.

ENTITY and5Gate IS
	PORT 	(a: IN std_logic_VECTOR(0 TO 4);
		 f: OUT std_logic);

ATTRIBUTE part_name of and5Gate:ENTITY IS "C371";
ATTRIBUTE pin_numbers of and5Gate:ENTITY IS
	    "a(0):2 a(1):3 " --The spaces after 3 and 5 are necessary
	  & "a(2):4 a(3):5 " --for concatenation (& operator)
	  & "f:6";  	     --signal a(4) will be assined a pin by warp
END and5Gate;

ARCHITECTURE see OF and5Gate IS
BEGIN
	f <= a(0) AND a(1) AND a(2) AND a(3) AND a(4);
END see;


