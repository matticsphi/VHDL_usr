library ieee;
use ieee.std_logic_1164.all;

-- two to four demultiplexer/decoder

ENTITY demux2_4 IS			
	PORT(in0, in1: IN std_logic;
	     d0, d1, d2, d3: OUT std_logic);
END demux2_4;

ARCHITECTURE behavior OF demux2_4 IS
BEGIN
	d0 <= (NOT(in1) AND NOT(in0));	
	d1 <= (NOT(in1) AND in0);
	d2 <= (in1 AND NOT(in0));
	d3 <= (in1 AND in0);
END behavior;

