library IEEE;
   use IEEE.STD_LOGIC_1164.ALL;
   use IEEE.STD_LOGIC_ARITH.ALL;
   use IEEE.STD_LOGIC_UNSIGNED.ALL;

    entity DP is
      Port (CLK                        : in STD_LOGIC;
            SW_74, SW_30, Rx, RyC, CNT : in STD_LOGIC_VECTOR(3 downto 0);
            CTRLS                      : in STD_LOGIC_VECTOR(7 downto 0);
				N									: out STD_LOGIC;
            DP_OUT, X                  : out STD_LOGIC_VECTOR(7 downto 0);
			   TEST : out STD_LOGIC_Vector (7 downto 0));
	end DP;

    architecture Behavioral of DP is
   
      component regfile  
         port(clk:           in  STD_LOGIC;
              we3:           in  STD_LOGIC;
				  ra1, ra2, wa3: in  STD_LOGIC_VECTOR(3 downto 0);
              wd3:           in  STD_LOGIC_VECTOR(7 downto 0);
              rd1, rd2:      out STD_LOGIC_VECTOR(7 downto 0));
      end component;
       
      component Mux41
         Port (   MX : in STD_LOGIC_VECTOR(1 downto 0);
                ZERO : in STD_LOGIC_VECTOR(7 downto 0);
                 ONE : in STD_LOGIC_VECTOR(7 downto 0);
                 TWO : in STD_LOGIC_VECTOR(7 downto 0);
               THREE : in STD_LOGIC_VECTOR(7 downto 0); 
                  MO : out STD_LOGIC_VECTOR(7 downto 0));  
      end component;
		
		component Eightbit_Adder
		   Port (     A : in  STD_LOGIC_VECTOR (7 downto 0);
                    B : in  STD_LOGIC_VECTOR (7 downto 0);
                  Cin : in  STD_LOGIC;
               AddOut : out  STD_LOGIC_VECTOR (7 downto 0));
		end component;
      
      component FF is
         Port (  CLK : in STD_LOGIC;
                   D : in STD_LOGIC;
                   Q : out STD_LOGIC);   
      end component;
   
       signal sigMOW, sigMOA, sigRx, sigRy, sigsum : STD_LOGIC_VECTOR(7 downto 0);
		 signal sigwe, sigN : STD_LOGIC;
		 
   begin
     
	  sigwe <= '0' when (CTRLS(7) = '1' and sigN = '0') else CTRLS(0); --Enables Reg15 load
	--   sigwe <= CTRLS(0);	
		Reg_File: regfile port map(clk => CLK,--input
                             we3 => sigwe,--input
                             ra1 => Rx, --input
                             ra2 => RyC, --from DM
                             wa3 => Rx, --input
                             wd3 => sigMOW, -- from MUXW
                             rd1 => sigRx, -- to Adder
                             rd2 => sigRy); -- to MUXA
      
      MuxW: Mux41 port map (MX(0) => CTRLS(5),--input
                            MX(1) => CTRLS(6),--input
                          ZERO(7) => SW_74(3),--input
                          ZERO(6) => SW_74(3),--input
                          ZERO(5) => SW_74(3),--input
                          ZERO(4) => SW_74(3),--input
                          ZERO(3) => SW_74(3),--input
                          ZERO(2) => SW_74(2),--input
                          ZERO(1) => SW_74(1),--input
                          ZERO(0) => SW_74(0),--input
                           ONE(7) => SW_30(3),--input
                           ONE(6) => SW_30(3),--input
                           ONE(5) => SW_30(3),--input
                           ONE(4) => SW_30(3),--input
                           ONE(3) => SW_30(3),--input
                           ONE(2) => SW_30(2),--input
                           ONE(1) => SW_30(1),--input
                           ONE(0) => SW_30(0),--input 
                              TWO => sigsum, -- from adder
                THREE(7 downto 4) => "0000",--sign extend
					 THREE(3 downto 0) => CNT, --input
                               MO => sigMOW);--to Reg File
                               
      MuxA: Mux41 port map (MX(0) => CTRLS(3),--input
                            MX(1) => CTRLS(4),--input
                             ZERO => sigRy, --From Reg_File
                              ONE => not sigRy,--From Reg_File
                           TWO(7) => RyC(3), --From DM
									TWO(6) => RyC(3),
									TWO(5) => RyC(3),
									TWO(4) => RyC(3),
									TWO(3) => RyC(3),
									TWO(2) => RyC(2),
									TWO(1) => RyC(1),
									TWO(0) => RyC(0),
								 THREE(7) => not RyC(3), --From DM
								 THREE(6) => not RyC(3),
								 THREE(5) => not RyC(3),
								 THREE(4) => not RyC(3),
								 THREE(3) => not RyC(3),
								 THREE(2) => not RyC(2),
								 THREE(1) => not RyC(1),
								 THREE(0) => not RyC(0),
                               MO => sigMOA);--to Adder
                                 
		Adder: Eightbit_Adder port map (     A => sigRX,--From Reg_File
													    B => sigMOA,--From MXA
													  Cin => CTRLS(2),--input
												  AddOut => sigsum);--to MXW
		
      FlipFlop: FF Port map (  CLK => CLK, --input
                                 D => sigsum(7), --from adder
                                 Q => sigN); --output
		
		DP_OUT <= sigRx when CTRLS(1) = '1' else "00000000"; --Enables Output
		
		X <= sigRx;
		N <= sigN;
		TEST <= sigsum;
		
   end Behavioral;
