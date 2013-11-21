library ieee;
use ieee.std_logic_1164.all;
use work.numeric_std.all;
use work.am2901_comps.all;
entity am2901 is port(
	clk, rst:	in std_logic;
	a, b:		in unsigned(3 downto 0);		-- address inputs
	d:		in unsigned(3 downto 0); 		-- direct data
	i:		in std_logic_vector(8 downto 0); 	-- micro instruction
	c_n:		in std_logic;				-- carry in
	oe:		in std_logic;				-- output enable
	ram0, ram3:	inout std_logic;				-- shift lines to ram
	qs0, qs3:	inout std_logic;				-- shift lines to q
	y:		buffer unsigned(3 downto 0);		-- data outputs (3-state)
	g_bar,p_bar:buffer std_logic;			-- carry generate, propagate
	ovr:		buffer std_logic;				-- overflow
	c_n4:		buffer std_logic;				-- carry out
	f_0:		buffer std_logic;				-- f = 0
	f3:			buffer std_logic);		-- f(3) w/o 3-state
end am2901;
architecture am2901 of am2901 is
	alias dest_ctl: std_logic_vector(2 downto 0) is i(8 downto 6);
	alias alu_ctl:  std_logic_vector(2 downto 0) is i(5 downto 3);
	alias src_ctl:  std_logic_vector(2 downto 0) is i(2 downto 0);

	signal ad, bd:	unsigned(3 downto 0);
	signal q:		unsigned(3 downto 0);
	signal r, s:	unsigned(3 downto 0);
	signal f:		unsigned(3 downto 0);
begin

-- instantiate and connect components
u1: ram_regs port map(clk => clk, rst => rst, a => a, b => b, f => f,
					dest_ctl => dest_ctl, ram0 => ram0, ram3 => ram3,
					ad => ad, bd => bd);
u2: q_reg port map(clk => clk, rst => rst, f => f, dest_ctl => dest_ctl,
					qs0 => qs0, qs3 => qs3, q => q);
u3: src_op port map(d => d, ad => ad, bd => bd, q => q,
					src_ctl => src_ctl, r => r, s => s);
u4: alu port map(r => r, s => s, c_n => c_n, alu_ctl => alu_ctl,
					f => f, g_bar => g_bar, p_bar => p_bar,
					c_n4 => c_n4, ovr => ovr);
u5: out_mux port map(ad => ad, f => f, dest_ctl => dest_ctl,
					oe => oe, y => y);

-- define f_0 and f3 outputs
f_0 <= '0' when f = "0000" else 'Z';
f3 <= f(3);

end am2901;
