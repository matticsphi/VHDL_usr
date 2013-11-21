-- this is a test bench; it cannot be synthesized
-- it is for use with a VHDL simulator

library ieee;
use ieee.std_logic_1164.all;
use work.numeric_std.all;
use work.mnemonics.all;

entity testbench is end;
architecture testbench of testbench is
component am2901 port(
    clk, rst:   in std_logic;
    a, b:       in unsigned(3 downto 0);              -- address inputs
    d:          in unsigned(3 downto 0);              -- direct data
    i:          in std_logic_vector(8 downto 0);    -- micro instruction
    c_n:        in std_logic;                       -- carry in
    oe:         in std_logic;                       -- output enable
    ram0, ram3: inout std_logic;                    -- shift lines to ram
    q0, q3:     inout std_logic;                    -- shift lines to q
    y:          buffer unsigned(3 downto 0);          -- data outputs (3-state)
    g_bar,p_bar:buffer std_logic;                   -- carry generate, propagate
    ovr:        buffer std_logic;                   -- overflow
    c_n4:       buffer std_logic;                   -- carry out
    f_0:        buffer std_logic;                   -- f = 0
    f3:         buffer std_logic);                  -- f(3) w/o 3-state
end component;

	signal clk: 		std_logic := '0';
	signal rst: 		std_logic := '1';
	signal a, b: 		unsigned(3 downto 0) := "0000";
	signal d:		unsigned(3 downto 0) := "0000";
	signal i: 		std_logic_vector(8 downto 0);
	signal c_n: 		std_logic := '0';
	signal oe: 		std_logic := '0';
	signal ram0, ram3: 	std_logic;
	signal q0, q3: 		std_logic;
	signal y: 		unsigned(3 downto 0);
	signal g_bar, p_bar: 	std_logic;
	signal ovr:		std_logic;
	signal c_n4:		std_logic;
	signal f_0:		std_logic;
	signal f3:		std_logic;

        alias dest_ctl: std_logic_vector(2 downto 0) is i(8 downto 6);
        alias alu_ctl:  std_logic_vector(2 downto 0) is i(5 downto 3);
        alias src_ctl:  std_logic_vector(2 downto 0) is i(2 downto 0);
	
begin
u1: am2901 port map (clk => clk, rst => rst, a => a, b => b,
		d => d, i => i, c_n => c_n, oe => oe, ram0 => ram0,
		ram3 => ram3, q0 => q0, q3 => q3, y => y, 
		g_bar => g_bar, p_bar => p_bar, ovr => ovr, f_0 => f_0,
		f3 => f3);

clk <= not(clk) after 50 ns;

verify: process 
	begin
		-- fill ram_reg array
		for i in 0 to 15 loop
			wait until clk = '1';
				rst <= '0';
				b <= to_unsigned(i,4);
				d <= to_unsigned(i,4);
				dest_ctl <= ramf;
				alu_ctl <= add;
				src_ctl <= dz;
		end loop;

		-- add a + b; check output
		for i in 0 to 15 loop
			wait until clk = '1'; 
				a <= to_unsigned(i,4);
				b <= to_unsigned(i,4);
				src_ctl <= ab;
		end loop;

		-- check all 8 alu instructions for ab regs;
		for j in 0 to 8 loop
			for i in 0 to 15 loop
				wait until clk = '1';
					a <= to_unsigned((15 - i), 4);	
					b <= to_unsigned(i, 4);
					alu_ctl <= std_logic_vector(to_unsigned(j,3));
			end loop;
		end loop;

		-- check all 8 src operand combinations
		for i in 0 to 8 loop
			wait until clk = '1';
				a <= "1100";
				b <= "1010";
				d <= "0101";
				src_ctl <= std_logic_vector(to_unsigned(i, 3));
		end loop; 
	end process;
end;
