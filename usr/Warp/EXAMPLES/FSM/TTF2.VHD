entity ttf_fsm is port(
	clk, rst:	in bit;
	id:		in bit_vector(0 to 3);
	y:		out bit_vector(0 to 1));
end ttf_fsm;

use work.table_bv.all;
architecture archttf_fsm of ttf_fsm is
	signal table_out: bit_vector(0 to 4);
	signal state: bit_vector(0 to 2);
constant state0:	x01_vector(0 to 2) := "000";
constant state1: 	x01_vector(0 to 2) := "001";
constant state2: 	x01_vector(0 to 2) := "010";
constant state3: 	x01_vector(0 to 2) := "011";
constant state4: 	x01_vector(0 to 2) := "100";

constant table: x01_table(0 to 21, 0 to 11) := (
--	present state  inputs  nextstate  output
--	-------------  ------  ---------  ------
	    state0  &  "xx0x" &  state0 &  "00",
	    state0  &  "xxx0" &  state0 &  "00",
	    state0  &  "0011" &  state1 &  "10",
	    state1  &  "xxxx" &  state2 &  "11",
	    state2  &  "1xxx" &  state2 &  "11",
	    state2  &  "x0xx" &  state2 &  "11",
	    state2  &  "xx0x" &  state2 &  "11",
	    state2  &  "xxx0" &  state2 &  "11",
	    state2  &  "0111" &  state3 &  "10",
	    state3  &  "0111" &  state3 &  "10",
	    state3  &  "1000" &  state3 &  "10",
	    state3  &  "11xx" &  state3 &  "10",
	    state3  &  "101x" &  state3 &  "10",
	    state3  &  "0110" &  state0 &  "00",
	    state3  &  "010x" &  state0 &  "00",
	    state3  &  "00xx" &  state0 &  "00",
	    state3  &  "1001" &  state4 &  "11",
	    state4  &  "0xxx" &  state3 &  "10",
	    state4  &  "100x" &  state3 &  "10",
	    state4  &  "11xx" &  state4 &  "11",
	    state4  &  "1010" &  state4 &  "11",
	    state4  &  "1011" &  state0 &  "00");

begin
machine: process (clk, rst) 
	begin
		if rst ='1' then 
			table_out <= "00000";
		elsif (clk'event and clk='1') then
			table_out <= ttf(table,state & id);
		end if;
	end process;
state <= table_out(0 to 2);

--assign state outputs;
y <= table_out(3 to 4);
end archttf_fsm;
