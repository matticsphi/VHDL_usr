library ieee;
use ieee.std_logic_1164.all;
use work.binctr_pkg.all;

entity REFILL is port (
	GIVE_cola: INOUT std_logic;
	GIVE_diet: INOUT std_logic;
	REFILL_BINS: OUT std_logic;
	RESET: IN std_logic;
	CLK: IN std_logic;
	GET_diet: IN std_logic;
	GET_cola: IN std_logic);

attribute pin_numbers of refill:entity is
" GIVE_cola:2 GIVE_diet:3 REFILL_BINS:4 RESET:10 CLK:13" &
" GET_diet:17 GET_cola:35";

end REFILL;

architecture archREFILL of REFILL is
		signal empty_1: std_logic;
		signal empty_2: std_logic;
begin
bin_1: BINCTR
	port map(RESET => RESET,
			 GET_DRINK => GET_cola,
			 CLK => CLK,
			 GIVE_DRINK => GIVE_cola,
			 EMPTY => empty_1);
bin_2: BINCTR
	port map(RESET => RESET,
			 GET_DRINK => GET_diet,
			 CLK => CLK,
			 GIVE_DRINK => GIVE_diet,
			 EMPTY => empty_2);

refill_bins <= '1' when ((empty_1 = '1') and (empty_2 = '1'))
else '0';

end archREFILL; 



