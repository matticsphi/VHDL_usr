LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE work.std_arith.all;

PACKAGE count_lib IS
COMPONENT counter
-- setting the default size of the counter
        GENERIC (counter_size: integer:=4 );
        PORT ( 	trigger	:	in std_logic;
			reset 	:	in std_logic;
			count	:	inout std_logic_vector(counter_size downto 0) );
END COMPONENT;

END count_lib;

LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE work.std_arith.all;
entity counter is
-- setting the default size of the counter
        GENERIC (counter_size: integer:=4 );
        PORT ( 	trigger	:	in std_logic;
			reset 	:	in std_logic;
			count	:	inout std_logic_vector(counter_size downto 0) );
END counter;

ARCHITECTURE archcounter OF counter IS

BEGIN
  PROCESS (reset, trigger)
	BEGIN
		IF reset='1' THEN
			count <= (others => '0');
		ELSIF (trigger'event and trigger='1') then
			count <= count+1;
		END IF;
  END PROCESS;
END archcounter;



