use work.bit_arith.all;
entity counter is port (
	clk, rst, e: 	in bit;
	a, b, c, x, y:	out bit);
end counter;
architecture counter of counter is
	signal count: bit_vector(2 downto 0);
begin
p1: process (clk, rst)
	begin
		if rst = '1' then
			count <= "000";
		elsif clk'event and clk = '1' then
			if e = '1' then
				count <= count + 1;
			end if;
		end if;
	end process;
	a <= count(2);
	b <= count(1);
	c <= count(0);
	x <= '1' when count > 3 else '0';
	y <= '1' when count = 6 else '0';
end counter;
