library ieee;
use ieee.std_logic_1164.all;
use work.std_arith.all;
entity cnt28 is port(
	clk, rst, oe, shift:			in std_logic;
	count:					buffer std_logic_vector(27 downto 0));
end cnt28;
architecture cnt28 of cnt28 is
	signal en_high: std_logic;
	attribute synthesis_off of en_high:signal is true;  -- explained below
	signal cnt: std_logic_vector(27 downto 0);
	alias lowcnt: std_logic_vector(14 downto 0) is cnt(14 downto 0);
	alias highcnt: std_logic_vector(12 downto 0) is cnt(27 downto 15);
begin
p1: process (clk, rst)
	begin
		if rst = '1' then 
			cnt <= (others => '0');
		elsif (clk'event and clk='1') then
			if shift = '1' then
				cnt <= count(26 downto 0) & count (27);
			else
				lowcnt <= lowcnt + 1;
				if en_high = '1' then
					highcnt <= highcnt + 1;
				end if;
			end if;
		end if;
	end process;
	
	en_high <= '1' when lowcnt = "111111111111111" else '0';

	count <= cnt when oe = '1' else (others => 'Z');

end;
