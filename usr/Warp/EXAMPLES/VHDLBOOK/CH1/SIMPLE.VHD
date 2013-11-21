entity simple is port(
	a, b, clk:	in bit;
	x, y:		buffer bit);
end simple;
architecture break_out of simple is
begin
	y <= a or b;
p1: process begin
		wait until clk = '1';
			x <= a xor b;
	end process;
end break_out;
