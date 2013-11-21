library ieee;
use ieee.std_logic_1164.all;
entity reg_logic is port (
	d   : in std_logic_vector(0 to 7);
	clk : in std_logic;
	q   : out std_logic_vector(0 to 7)
);
end reg_logic;
architecture r_example of reg_logic is
begin
	process (clk) begin
		if (clk'event and clk = '1') then
			q <= d;
		end if;
	end process;
end r_example;
