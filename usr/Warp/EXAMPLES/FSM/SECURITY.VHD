library ieee;
use ieee.std_logic_1164.all;

-- simple security system uses a mealy machine

ENTITY securitySystem IS
	PORT (set, intruder, clk: IN std_logic;
		horn: OUT std_logic);
END securitySystem;

ARCHITECTURE behavior OF securitySystem IS
TYPE states IS (securityOff, securityOn, securityBreach);
SIGNAL state, nextState: states;

BEGIN
PROC1:	PROCESS (set, intruder)
	BEGIN
		CASE state IS
		WHEN securityOff =>
			IF set = '1' THEN
				nextState <= securityOn;
			ELSE
				nextState <= securityOff;
			END IF;
		WHEN securityOn =>
			IF intruder = '1' THEN
				horn <= '1';
				nextState <= securityBreach;
			ELSIF set = '0' THEN
				horn <= '0';
				nextState <= securityOff;
			ELSE 
				nextState <= securityOn;
			END IF;
		WHEN securityBreach =>
			IF set = '0' THEN
				horn <= '0';
				nextState <= securityOff;
			ELSE
				nextState <= securityBreach;
			END IF;
		WHEN others =>
			nextState <= securityOff;
		END CASE;
	END PROCESS;
proc2:	PROCESS
	BEGIN
		WAIT UNTIL clk ='1';
		state <= nextState;
	END PROCESS;

END behavior;

			
