library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FSM is
	Port (     CLK : in STD_LOGIC;
	           LDA : out STD_LOGIC;
              LDB : out STD_LOGIC;
            LDACC : out STD_LOGIC;
              Cin : out STD_LOGIC;
               mx : out STD_LOGIC_VECTOR(1 downto 0));   
end FSM;

architecture Behavioral of FSM is

	type state_type is (LDRA, LDRB, ADDA, SUBB, ADDB);
	signal PS, NS : state_type; 

begin

sync_proc: process(CLK, NS)
	begin
	
		if (rising_edge(CLK)) then PS <= NS;
		end if;
	end process sync_proc;

comb_proc: process(PS)
	begin
      LDA <= '0'; LDB <= '0'; LDACC <= '0'; Cin <= '0'; mx <= "00"; 
		case PS is
			when LDRA =>
				NS    <= LDRB; 
            LDA   <= '1';
            LDB   <= '0'; 
            LDACC <= '0';
			when LDRB =>
				NS    <= ADDA; 
            LDA   <= '0';
            LDB   <= '1'; 
            LDACC <= '0';
			when ADDA =>
				NS    <= SUBB; 
            LDA   <= '0';
            LDB   <= '0'; 
            LDACC <= '1'; 
            Cin   <= '0'; 
            mx    <= "01";
			when SUBB =>
				NS    <= ADDB; 
            LDA   <= '0';
            LDB   <= '0'; 
            LDACC <= '1'; 
            Cin   <= '1'; 
            mx    <= "10";
			when ADDB =>
				NS    <= LDRA; 
            LDA   <= '0';
            LDB   <= '0'; 
            LDACC <= '1'; 
            Cin   <= '0'; 
            mx    <= "11";
			when others =>
				NS    <= LDRA; 
            LDA   <= '0';
            LDB   <= '0'; 
            LDACC <= '0'; 
            Cin   <= '0'; 
            mx    <= "00";
		end case;
	end process comb_proc;
 end Behavioral;