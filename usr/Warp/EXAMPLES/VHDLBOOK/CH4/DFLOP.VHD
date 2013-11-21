library ieee;
use ieee.std_logic_1164.all;
entity dff_logic is port (
	d, clk : in std_logic;
	q      : out std_logic
);
end dff_logic;

architecture example of dff_logic is
begin
	process (clk) begin
		if (clk'event and clk = '1') then
			q <= d;
		end if;
	end process;
end example;
