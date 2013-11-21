library ieee;
use ieee.std_logic_1164.all;
USE work.STD_ARITH.all;

-- This state machine implements a simple traffic light.
-- The N - S light is usually green, and remains green
-- for a minimum of five clocks after being red. If a 
-- car is travelling E-W, the E-W light turns green for
-- only one clock.
										
ENTITY traffic_light IS 
	PORT(clk, car: IN std_logic;			--car is an E-W travelling car
	     lights: BUFFER std_logic_VECTOR(0 TO 5));
END traffic_light;

ARCHITECTURE moore1 OF traffic_light IS
-- The lights (outputs) are encoded in the following states.  For example, the
-- state green_red indicates the N-S light is green and the E-W light is red.
-- "001" indicates green light, "010" yellow, "100" red; "&" concatenates
	CONSTANT green_red 	: std_logic_VECTOR(0 TO 5) := "001" & "100";
	CONSTANT yellow_red 	: std_logic_VECTOR(0 TO 5) := "010" & "100";
	CONSTANT red_green 	: std_logic_VECTOR(0 TO 5) := "100" & "001";
	CONSTANT red_yellow 	: std_logic_VECTOR(0 TO 5) := "100" & "010";

-- nscount to verify five consecutive N-S greens
	SIGNAL nscount: INTEGER RANGE 0 TO 5; 	

BEGIN
	PROCESS
	BEGIN
		WAIT UNTIL clk = '1';
		CASE lights IS
			WHEN green_red =>
				IF nscount < 5 THEN		 
					lights <= green_red;	
					nscount <= nscount + 1;
				ELSIF car = '1' THEN 
					lights <= yellow_red;
					nscount <= 0;
				ELSE
					lights <= green_red;
				END IF;
			WHEN yellow_red =>
				lights <= red_green;
			WHEN red_green =>
				lights <= red_yellow;
			WHEN red_yellow =>
				lights <= green_red;
			WHEN others =>
				lights <= green_red;
		END CASE;
	END PROCESS;
END moore1;
