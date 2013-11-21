library ieee;
use ieee.std_logic_1164.all;
use work.numeric_std.all;
use work.mnemonics.all;
entity out_mux is port(
	ad, f:		in unsigned(3 downto 0);
	dest_ctl: 	in std_logic_vector(2 downto 0);
	oe:			in std_logic;
	y:			buffer unsigned(3 downto 0));
end out_mux;
architecture out_mux of out_mux is
	signal y_int: unsigned(3 downto 0);	-- output before tri-state buffer
begin
	y_int <= ad when dest_ctl = rama else f;
	y <= y_int when oe = '0' else "ZZZZ";
end out_mux;
