library ieee;
use ieee.std_logic_1164.all;

package cntrlpkg is
	component cntrl port (
	instr:          in      std_logic_vector(3 downto 0);
	functionsel:    out     std_logic_vector(2 downto 0);
	addsubsel:      out     std_logic);
	end component;
end cntrlpkg;

library ieee;
use ieee.std_logic_1164.all;

entity cntrl is port (
   instr:       in      std_logic_vector(3 downto 0); -- what function should the ALU perform
   functionsel: out     std_logic_vector(2 downto 0); -- select lines for 1-of-8 mux 
   addsubsel:   out     std_logic); -- perform A + B or A - B 
   
   -- selmag = 0 yields mag[3:0] = [A>=B        A>B     A<=B    A<B]
   -- selmag = 1 yields mag[3:0] = [0   0       A/=B    A=B]
   -- where A>=B, A>B, A<=B, A<B, A/=B, and A=B would be replaced by a logic 1 or 0 depending on
   -- whether the statement is true. 
end cntrl;

architecture archcntrl of cntrl is

begin

control:  process (instr)
  begin
	case instr is
	  when x"0" =>
		functionsel     <= b"000"; -- select the output of the adder/subtractor 
		addsubsel       <= '1'; -- A + B        
	  when x"1" =>
		functionsel     <= b"000"; -- select the output of the adder/subtractor
		addsubsel       <= '0'; -- A - B
	  when x"2" =>
		functionsel    <= b"001"; -- select magb[3:0] = [A>=B        A>B     A<=B    A<B]
		addsubsel       <= '-';
	  when x"3" =>
		functionsel    <= b"010"; -- select maga[3:0] = [0   0       A/=B    A=B]
		addsubsel       <= '-';
	  when x"4" =>
		functionsel    <= b"011"; -- select the output of A and B
		addsubsel       <= '-';
	  when x"5" =>
		functionsel    <= b"100"; -- select the output of A or B
		addsubsel      <= '-';
	  when x"6" =>
		functionsel    <= b"101"; -- select the output of A xor B
		addsubsel       <= '-';
	  when x"7" =>
		functionsel    <= b"110"; -- select the output of the inverse of A 
		addsubsel       <= '-';
	  when x"8" =>
		functionsel    <= b"111"; -- select the output of the inverse of B
		addsubsel       <= '-';
	  when others => -- to cover the other 6550+ possibilities  
		functionsel     <= "---";
		addsubsel       <= '-';
	  end case;
end process control;

end archcntrl; -- end architecture
