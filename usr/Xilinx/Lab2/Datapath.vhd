library IEEE;
   use IEEE.STD_LOGIC_1164.ALL;
   use IEEE.STD_LOGIC_ARITH.ALL;
   use IEEE.STD_LOGIC_UNSIGNED.ALL;

    entity DP is
      Port (  CLK  : in STD_LOGIC;
            CLR : in STD_LOGIC;
           SW74 : in STD_LOGIC_VECTOR(3 downto 0);
           SW30 : in STD_LOGIC_VECTOR(3 downto 0);
            LDA : in STD_LOGIC;
            LDB : in STD_LOGIC;
          LDACC : in STD_LOGIC;
            Cin : in STD_LOGIC;
             MX : in STD_LOGIC_VECTOR(1 downto 0);
            ACC : out STD_LOGIC_VECTOR(7 downto 0));
   end DP;

    architecture Behavioral of DP is
   
      component FSM 
         Port (  CLK : in STD_LOGIC;
              LDA : out STD_LOGIC;
              LDB : out STD_LOGIC;
            LDACC : out STD_LOGIC;
              Cin : out STD_LOGIC;
               MX : out STD_LOGIC_VECTOR(1 downto 0));   
      end component;
   
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
   
      component Mux
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
   
   
      signal sigroa, sigrob, sigsum, sigmo, sigacc : STD_LOGIC_VECTOR(7 downto 0);
		
   begin
		
      RA: Reg port map (    CLK => CLK,
                          SW(7) => SW74(3),
                          SW(6) => SW74(3),
                          SW(5) => SW74(3),
                          SW(4) => SW74(3),
                          SW(3) => SW74(3),
                          SW(2) => SW74(2),
                          SW(1) => SW74(1),
                          SW(0) => SW74(0),
                            CLR => CLR,
                           LoaD => LDA,
                             RO => sigroa);
                             
      RB: Reg port map (    CLK => CLK,
                          SW(7) => SW30(3),
                          SW(6) => SW30(3),
                          SW(5) => SW30(3),
                          SW(4) => SW30(3),
                          SW(3) => SW30(3),
                          SW(2) => SW30(2),
                          SW(1) => SW30(1),
                          SW(0) => SW30(0),
                            CLR => CLR,
                           LoaD => LDB,
                             RO => sigrob);   
    
      MyMux: Mux port map ( MX => MX,
                          ZERO => not sigroa, 
                           ONE => sigroa,
                           TWO => not sigrob,
                         THREE => sigrob, 
                            MO => sigmo);
		
		Adder: Eightbit_Adder port map ( MuxIn => sigmo,
													AccIn => sigacc,
													  CIN => Cin,
												  AddOut => sigsum);
		
		
      RACC: Reg port map (   CLK => CLK,
                             SW => sigsum,
                            CLR => CLR,
                           LoaD => LDACC,
                             RO => sigacc ); 
		ACC <= sigacc;
		
   end Behavioral;
