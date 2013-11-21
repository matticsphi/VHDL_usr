library IEEE;
   use IEEE.STD_LOGIC_1164.ALL;
   use IEEE.STD_LOGIC_ARITH.ALL;
   use IEEE.STD_LOGIC_UNSIGNED.ALL;

    entity DP is
      Port (  CLK  : in STD_LOGIC;
              SW_74 : in STD_LOGIC_VECTOR(3 downto 0);
              SW_30 : in STD_LOGIC_VECTOR(3 downto 0);
             CTRLS : in STD_LOGIC_VECTOR(7 downto 0);
           Rx, RyC : in STD_LOGIC_VECTOR(3 downto 0);
            DP_OUT : out STD_LOGIC_VECTOR(7 downto 0));
			    --TEST : out STD_LOGIC_VECTOR(7 downto 0));
	end DP;

    architecture Behavioral of DP is
      
      component DMX12
         Port (    D : in STD_LOGIC;
                ZERO : out STD_LOGIC_VECTOR(3 downto 0);
                 ONE : out STD_LOGIC_VECTOR(3 downto 0); 
                  DI : in STD_LOGIC_VECTOR(3 downto 0));  
   end component;
   
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
   
   
      signal sigC, sigRay : STD_LOGIC_VECTOR(3 downto 0);
      signal sigMOW, sigMOA, sigRx, sigRy, sigsum : STD_LOGIC_VECTOR(7 downto 0);
		
   begin
                              
	   DM: DMX12 port map (     D => CTRLS(7), --input
                            ZERO => sigC,
                             ONE => sigRay,
                              DI => RyC);--input 
     
      Reg_File: regfile port map(clk => CLK,--input
                             we3 => CTRLS(0),--input
                             ra1 => Rx, --input
                             ra2 => sigRay,
                             wa3 => Rx, --input
                             wd3 => sigMOW,
                             rd1 => sigRx,
                             rd2 => sigRy);
      
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
                              TWO => sigsum,
                            THREE => "00000000", --not used
                               MO => sigMOW);--to Adder
                               
      MuxA: Mux41 port map (MX(0) => CTRLS(3),--input
                            MX(1) => CTRLS(4),--input
                             ZERO => sigRy,
                              ONE => not sigRy,
                           TWO(7) => sigC(3),
									TWO(6) => sigC(3),
									TWO(5) => sigC(3),
									TWO(4) => sigC(3),
									TWO(3) => sigC(3),
									TWO(2) => sigC(2),
									TWO(1) => sigC(1),
									TWO(0) => sigC(0),
								 THREE(7) => not sigC(3),
								 THREE(6) => not sigC(3),
								 THREE(5) => not sigC(3),
								 THREE(4) => not sigC(3),
								 THREE(3) => not sigC(3),
								 THREE(2) => not sigC(2),
								 THREE(1) => not sigC(1),
								 THREE(0) => not sigC(0),
                               MO => sigMOA);--to Adder
                                 
		Adder: Eightbit_Adder port map (     A => sigRx,--From Reg_File
													    B => sigMOA,--From MXA
													  Cin => CTRLS(2),--input
												  AddOut => sigsum);--to MXW
		
		
		DP_OUT <= sigRx when CTRLS(1) = '1' else "00000000";
		

		
   end Behavioral;
