--This is a simple counter with reset.  The purpose of this
--example is to demonstrate using expressions
--for clocks and resets. Design requires a device that
--supports expression clocks (34x, 38x) 

library ieee;
use ieee.std_logic_1164.all;
USE work.STD_ARITH.all;

ENTITY testExpressions IS
	PORT 	(clk1, clk2, res1, res2: IN STD_LOGIC;
		 count: BUFFER STD_LOGIC_VECTOR(0 TO 3));
END testExpressions;

ARCHITECTURE cool OF testExpressions IS
SIGNAL clk, reset: STD_LOGIC;

BEGIN
	clk <= clk1 AND clk2;	--both clocks must be asserted;
	reset <= res1 OR res2; 	--either reset

proc1:	PROCESS 
	BEGIN
	WAIT UNTIL clk = '1';
		IF reset = '1' THEN
			count <= x"0";
		ELSE 
			count <= count + 1;
		END IF;
	END PROCESS;
END cool;

			







