-- counter with synchronous reset and synchronous load
-- uses bidirectional pins; loads on the i/o pins
-- temp is a RECORD used to simplify insantiating bufoe

library ieee;
use ieee.std_logic_1164.all;
USE work.STD_ARITH.all;
USE work.rtlpkg.all;

ENTITY counter IS 
	PORT   (clk, reset, load, outen: IN STD_LOGIC;
		count: INOUT std_logic_VECTOR(0 TO 3));
END counter;

ARCHITECTURE behavior OF counter IS
TYPE bufRec IS					-- record for bufoe
	RECORD					-- inputs and feedback
		cnt: STD_LOGIC_VECTOR(0 TO 3);
		dat: STD_LOGIC_VECTOR(0 TO 3);
END RECORD;
SIGNAL temp: bufRec;

CONSTANT counterSize: INTEGER := 3;
BEGIN
g1:	FOR i IN 0 TO counterSize GENERATE
		bx: bufoe PORT MAP(temp.cnt(i), outen, count(i), temp.dat(i));
	END GENERATE;

proc1:	PROCESS
       	BEGIN
	WAIT UNTIL (clk = '1');
	     	IF reset = '1' THEN
			temp.cnt <= "0000";
		ELSIF load = '1' THEN
			temp.cnt <= temp.dat;
		ELSE
			temp.cnt <= temp.cnt + 1;  -- increment std_logic vector
		END IF;
	END process;
END behavior;




