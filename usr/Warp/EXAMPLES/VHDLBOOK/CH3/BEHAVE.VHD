library ieee;
use ieee.std_logic_1164.all;
entity eqcomp4 is port(
	a, b:			in std_logic_vector(3 downto 0);
	equals:		out std_logic);
end eqcomp4;

architecture behavioral of eqcomp4 is
begin
comp: process (a, b)
	begin
		if a = b then
			equals <= '1';
		else
			equals <= '0';
		end if;
	end process comp;
end behavioral;
