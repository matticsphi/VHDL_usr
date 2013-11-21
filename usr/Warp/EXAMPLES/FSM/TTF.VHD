--This Mealy machine implements a security system with a state table.
--The machine has three states (securityOff, securityOn, and 
--securityBreach) and two inputs or sensors (set and intruder).
--The security system can be turned to the Off state by deasserting
--set.  A horn(output) sounds if the system is On and intruder is
--asserted.  The primary purpose of this example is to 
--illustrate the use of the ttf function.

USE work.table_bv.all;

ENTITY securitySystem IS
	PORT (set, intruder, clk: IN BIT;
		horn: OUT BIT);
END securitySystem;

ARCHITECTURE stateTable OF securitySystem IS
SIGNAL state: BIT_VECTOR(0 TO 1);
SIGNAL nextState: BIT_VECTOR(0 TO 2);  -- nextState also contains output
CONSTANT securityOff:       x01_VECTOR(0 TO 1) := "00";
CONSTANT securityOn:        x01_VECTOR(0 TO 1) := "01";
CONSTANT securityBreach:    x01_VECTOR(0 TO 1) := "10";
CONSTANT table: x01_table(0 TO 6, 0 TO 6) := (
--      present state   inputs    next state         output
--      -------------   ------   ------------       -------
	securityOff 	& "1x"  & securityOn        & "0",
	securityOn  	& "0x"  & securityOff       & "0",
	securityOn  	& "10"  & securityOn        & "0",
	securityOn  	& "11"  & securityBreach    & "1",    
	securityBreach  & "0x"  & securityOff       & "0",
	securityBreach  & "10"  & securityBreach    & "1",
	securityBreach  & "11"  & securityBreach    & "1");

BEGIN
	p1: PROCESS
	BEGIN
		WAIT UNTIL clk = '1';
		state <= nextState(0 TO 1); --don't need the last bit (output)
	END PROCESS;
	p2: PROCESS (set, intruder)
	BEGIN
		nextState <= ttf(table,(state & set & intruder));
	END PROCESS;
	horn <= nextState(2);
END stateTable;
