library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FSM is
	Port (      X : in STD_LOGIC;
	         SQ2 : in STD_LOGIC;
	         SQ5 : in STD_LOGIC;
	         CLK : in STD_LOGIC;
	              Z : out STD_LOGIC );   
end FSM;

architecture Behavioral of FSM is

	type state_type is (ST0, ST1, ST2, ST3, ST4, ST5, ST6);
	signal PS, NS : state_type; 

begin

sync_proc: process(CLK, NS)
	begin
	
		if (rising_edge(CLK)) then PS <= NS;
		end if;
	end process sync_proc;

comb_proc: process(PS, X)
	begin
		Z <= '0'; 
		case PS is
			when ST0 =>
				Z <= '0';
				if (X = '0') then NS <= ST1;
				else NS <= ST0;
				end if;
			when ST1 =>
				Z <= '0';
				if (X = '0') then NS <= ST1;
				else NS <= ST2;
				end if;
			when ST2 =>
				Z <= '0';
				if ((SQ2 = '0' )and (X = '1')) then NS <= ST0;
				elsif (SQ2 = '1' and X = '0') then NS <= ST1;
				else NS <= ST3;
				end if;
			when ST3 =>
				Z <= '0';
				if (X = '0') then NS <= ST4;
				elsif (SQ2 = '0') then NS <= ST2;
				else NS <= ST0;
				end if;
			when ST4 =>
				Z <= '0';
				if (SQ5 = '1' and X = '0') then NS <= ST1;
				elsif (SQ5 = '0' and X = '1') then NS <= ST2;
				else NS <= ST5;
				end if;
			when ST5 =>
				Z <= '0';
				if (X = '0') then NS <= ST6;
				elsif (SQ5 = '0' and X = '1') then NS <= ST2;
				else NS <= ST0;
				end if;
			when ST6 =>
				Z <= '1';
				if (X = '0') then NS <= ST1;
				else NS <= ST2;
				end if;
			when others =>
				NS <= ST0; Z <= '0';
		end case;
	end process comb_proc;
end Behavioral;