library ieee;
use ieee.std_logic_1164.all;
use work.std_arith.all;
entity wierdcnt16 is port(
	clk, rst:			in std_logic;
	en,up,by2,by3,by5:	in std_logic;
	d:			in std_logic_vector(3 downto 0);
	c:			inout std_logic_vector(3 downto 0));
end wierdcnt16;

architecture archwierdcnt16 of wierdcnt16 is
begin
counter: process (clk, rst) 
	begin
		if rst = '1' then 
			c <= (others => '0');
		elsif (clk'event and clk='1') then
			if en = '1' then
				if up = '1' then
					if by2 = '1' then
						c <= c + 2;
					elsif  by3 = '1' then
						c <= c + 3;
					elsif by5 = '1' then
						c <= c + 5;
					else
						c <= c + d;
					end if;
				elsif by2 =  '1' then
					c <= c - 2;
				elsif by3 = '1' then
					c <= c - 3;
				elsif by5 = '1' then 
					c <= c - 5;
				else
					c <= c - d;
				end if;
			else
				c <= c;
			end if;
		end if;
	end process counter;
end archwierdcnt16;
