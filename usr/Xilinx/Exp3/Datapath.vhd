library IEEE;
   use IEEE.STD_LOGIC_1164.ALL;
   use IEEE.STD_LOGIC_ARITH.ALL;
   use IEEE.STD_LOGIC_UNSIGNED.ALL;

    entity DP is
      Port (  CLK  : in STD_LOGIC;
              SW74 : in STD_LOGIC_VECTOR(3 downto 0);
              SW30 : in STD_LOGIC_VECTOR(3 downto 0);
             CTRLS : in STD_LOGIC_VECTOR(7 downto 0);
               ACC : out STD_LOGIC_VECTOR(7 downto 0);
			     MUXO : out STD_LOGIC_VECTOR(7 downto 0));
   end DP;

    architecture Behavioral of DP is
    
      component CLK_DIV_FS
         Port (      CLK : in std_logic;
               FCLK,SCLK : out std_logic);
      end component;
   
      component Reg
         Port (  CLK : in STD_LOGIC;
               SW : in STD_LOGIC_VECTOR(7 downto 0);
              CLR : in STD_LOGIC;
             LoaD : in STD_LOGIC;
               RO : out STD_LOGIC_VECTOR(7 downto 0));   
      end component;
   
      component Mux21
         Port (   MX : in STD_LOGIC;
             ZERO : in STD_LOGIC_VECTOR(7 downto 0);
              ONE : in STD_LOGIC_VECTOR(7 downto 0); 
               MO : out STD_LOGIC_VECTOR(7 downto 0));  
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
		Port ( MuxIn : in  STD_LOGIC_VECTOR (7 downto 0);
           AccIn : in  STD_LOGIC_VECTOR (7 downto 0);
           CIN : in  STD_LOGIC;
           AddOut : out  STD_LOGIC_VECTOR (7 downto 0));
		end component;
   
   
      signal sigroa, sigrob, sigsum, sigmo1, sigmo2, sigacc : STD_LOGIC_VECTOR(7 downto 0);
		
   begin
		
      RA: Reg port map (    CLK => CLK,--input
                             SW => sigmo1, --Mux1
                            CLR => CTRLS(3),--input
                           LoaD => CTRLS(0),--input
                             RO => sigroa);--to Mux2
                             
      RB: Reg port map (    CLK => CLK,--input
                          SW(7) => SW30(3),--sign extend
                          SW(6) => SW30(3),--sign extend
                          SW(5) => SW30(3),--sign extend
                          SW(4) => SW30(3),--sign extend
                          SW(3) => SW30(3),--input
                          SW(2) => SW30(2),--input
                          SW(1) => SW30(1),--input
                          SW(0) => SW30(0),--input
                            CLR => CTRLS(3),--input
                           LoaD => CTRLS(0),--input
                             RO => sigrob);--to Mux2
    
      Mux1: Mux21 port map (  MX => CTRLS(4),--input
                           ZERO => sigacc,--from RACC
                         ONE(7) => SW74(3),--sign extend
                         ONE(6) => SW74(3),--sign extend
                         ONE(5) => SW74(3),--sign extend
                         ONE(4) => SW74(3),--sign extend
                         ONE(3) => SW74(3),--input
                         ONE(2) => SW74(2),--input
                         ONE(1) => SW74(1),--input
                         ONE(0) => SW74(0),--input
                             MO => sigmo1);--to RA
                            
	   Mux2: Mux41 port map ( MX(0) => CTRLS(5),--input
                            MX(1) => CTRLS(6),--input
                             ZERO => not sigroa,--from RA
                              ONE => sigroa,--from RA
                              TWO => not sigrob,--from RB
                            THREE => sigrob, --from RB
                               MO => sigmo2);--to Adder
                            
		Adder: Eightbit_Adder port map ( MuxIn => sigmo2,--From Mux2
													AccIn => sigacc,--From RACC
													  CIN => CTRLS(7),--input
												  AddOut => sigsum);--to RACC
		
		
      RACC: Reg port map (   CLK => CLK,--input
                             SW => sigsum,--from Adder
                            CLR => CTRLS(3),--input
                           LoaD => CTRLS(2),--input
                             RO => sigacc );--to Adder, Mux1, and Output
		ACC <= sigacc;
	   MUXO <= sigmo1;
		
   end Behavioral;
