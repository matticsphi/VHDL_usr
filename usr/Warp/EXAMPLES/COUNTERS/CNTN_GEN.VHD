-- Like cnt4_rec, cntn_gen.vhd is a counter with synchronous
-- reset and load.  The counter loads on the i/o pins when outen
-- is deasserted and load is asserted.  A record is used to simplify
-- instantiating bufoe.  The primary purpose of this example is to
-- demonstrate the use of the GENERIC statement which is used here 
-- to define an n-std_logic counter.  When instantiated, the number of std_logics
-- is declared in the generic port map, otherwise it defaults to 4. 

library ieee;
use ieee.std_logic_1164.all;
USE work.STD_ARITH.all;

USE work.rtlpkg.all;
	
ENTITY nBitCounter IS
	GENERIC (counterSize: INTEGER := 4);
	PORT   (clk, reset, load, outen: IN STD_LOGIC;
		count: INOUT STD_LOGIC_VECTOR(0 TO counterSize-1));
END nBitCounter;

ARCHITECTURE behavior OF nBitCounter IS
TYPE bufRec IS                  -- record for bufoe
	RECORD                  -- inputs and feedback
		cnt: STD_LOGIC_VECTOR(0 TO counterSize-1);
		dat: STD_LOGIC_VECTOR(0 TO counterSize-1);
	END RECORD;
SIGNAL temp: bufRec;

BEGIN
g1: FOR i IN 0 TO (counterSize-1) GENERATE
		bx: bufoe PORT MAP(temp.cnt(i), outen, count(i), temp.dat(i));
	END GENERATE;

proc1:	PROCESS
		BEGIN
	WAIT UNTIL (clk = '1');
 		IF reset = '1' THEN
			FOR i IN 0 TO counterSize-1 LOOP
				temp.cnt(i) <= '0';
			END LOOP;
		ELSIF load = '1' THEN
			temp.cnt <= temp.dat;
		ELSE
			temp.cnt <= temp.cnt + 1;  -- increment std_logic vector
		END IF;
       	END process;
END behavior;


library ieee;
use ieee.std_logic_1164.all;

--The entity/architecture pair described above is declared a component
--below.  The generic counterSize allows us to instantiate an nBitCounter
--of any size.  Below, however, count is declared as 8 std_logics, so for the
--instantiation below, counterSize is also restricted restricted to 8 std_logics,
ENTITY Counter IS
	PORT    (clk, reset, load, outen: IN STD_LOGIC;
		count: INOUT STD_LOGIC_VECTOR(0 TO 7));
END Counter;


ARCHITECTURE neat OF Counter IS
COMPONENT nBitCounter
	GENERIC (counterSize: INTEGER := 4);
	PORT   (clk, reset, load, outen: IN STD_LOGIC;
		count: INOUT STD_LOGIC_VECTOR(0 TO counterSize-1));
END COMPONENT;

BEGIN
	c1:nBitCounter
	GENERIC MAP (counterSize => 8)		--choose a counterSize
	PORT MAP (clk, reset, load, outen,	
			count(0 TO counterSize-1));
END neat;
