library ieee ;
use ieee.std_logic_1164.all ;

entity compare is port(
	a, b:	in std_logic_vector(0 to 3);
	aeqb:	out std_logic);
end compare;

use work.lpmpkg.all;
architecture archcompare of compare is
begin
    c0: Mcompare
	generic map(
		lpm_width => a'length,		-- Evaluates to 4
		lpm_representation => lpm_unsigned,
		lpm_hint => speed)
	port map(
		dataa => a,	datab => b,
		alb => open,	aeb => aeqb,	agb => open,	
		aleb => open,	aneb => open,	ageb => open);
end;
