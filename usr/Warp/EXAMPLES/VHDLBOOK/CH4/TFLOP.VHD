library ieee;
use ieee.std_logic_1164.all;
entity tff_logic is port (
	t, clk : in std_logic;
	q      : buffer std_logic
);
end tff_logic;
architecture t_example of tff_logic is
begin
	process (clk) begin
		if (clk'event and clk = '1') then
			if (t = '1') then
				q <= not(q);
			else
				q <= q;
			end if;
		end if;
	end process;
end t_example;
