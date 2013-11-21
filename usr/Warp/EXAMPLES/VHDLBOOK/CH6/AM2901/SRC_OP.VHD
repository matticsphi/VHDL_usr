library ieee;
use ieee.std_logic_1164.all;
use work.numeric_std.all;
use work.mnemonics.all;
entity src_op is port(
	d, ad, bd, q:	in unsigned(3 downto 0);
	src_ctl:		in std_logic_vector(2 downto 0);
	r, s:			buffer unsigned(3 downto 0));
end src_op;
architecture src_op of src_op is
begin
-- decode alu operand r:
with src_ctl select
	r <=	ad when aq | ab,
			"0000" when zq | zb | za,
			d when others;

with src_ctl select
	s <=	q when aq | zq | dq,
			bd when ab | zb,
			ad when za | da,
			"0000" when others;
end src_op;

 
