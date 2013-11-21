
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:09:06 01/07/2011
-- Design Name:   USR
-- Module Name:   C:/USR/USR_tb.vhd
-- Project Name:  USR
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: USR
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends 
-- that these types always be used for the top-level I/O of a design in order 
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY USR_tb_vhd IS
END USR_tb_vhd;

ARCHITECTURE behavior OF USR_tb_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT USR
	PORT(
		SEL : IN std_logic_vector(1 downto 0);
		P_LOAD : IN std_logic_vector(7 downto 0);
		CLK : IN std_logic;
		DR_IN : IN std_logic;
		DL_IN : IN std_logic;          
		D_OUT : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	--Inputs
	SIGNAL CLK :  std_logic := '0';
	SIGNAL DR_IN :  std_logic := '0';
	SIGNAL DL_IN :  std_logic := '0';
	SIGNAL SEL :  std_logic_vector(1 downto 0) := "01";
	SIGNAL P_LOAD :  std_logic_vector(7 downto 0) := "00000000";

	--Outputs
	SIGNAL D_OUT :  std_logic_vector(7 downto 0);
	
	--Expected Values
	signal D_EXP : std_logic_vector(7 downto 0) := "00000000";
	
	--Clock period definitions
	constant CLK_PERIOD : time := 100ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: USR PORT MAP(
		SEL => SEL,
		P_LOAD => P_LOAD,
		D_OUT => D_OUT,
		CLK => CLK,
		DR_IN => DR_IN,
		DL_IN => DL_IN
	);
	
	--Test cases
	P_LOAD <= "00000001" after 400ns,
	          "10011101" after 500ns,
				 "00000000" after 800ns;
	
	SEL <= "01" after 200ns,
			 "00" after 300ns,
			 "01" after 400ns,
			 "10" after 600ns,
			 "11" after 700ns,
			 "01" after 800ns;
	
	DR_IN <= '1' after 700ns,
	         '0' after 800ns;
	
	DL_IN <= '1' after 600ns,
	         '0' after 800ns;
	
	D_EXP <= "00000000" after 250ns,
				"00000000" after 350ns,
	         "00000001" after 450ns,
				"10011101" after 550ns,
				"11001110" after 650ns,
				"10011101" after 750ns,
				"00000000" after 850ns;
				
   --clock cycle 50ns
   clk_process: process
	begin
		CLK <= '0';
		wait for CLK_PERIOD/2;
		CLK <= '1';
		wait for CLK_PERIOD/2;
	end process;

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		-- test for errors
		assert (D_OUT = D_EXP)
		 report "Mismatch at t=" & time'image(now) &
		  " D_OUT=" & integer'image(conv_integer(D_OUT)) &
		  " D_EXP=" & integer'image(conv_integer(D_EXP))
		  severity failure;
		  
		-- no errors found
		assert false
		 report "No error found (t=" & time'image(now) & ")"
		 severity note;

	END PROCESS;

END;
