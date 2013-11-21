library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SequenceDetector is
	Port (  CLK      : in STD_LOGIC;
	        SQ2      : in STD_LOGIC;
	        SQ5      : in STD_LOGIC;
           SWITCHES   : in STD_LOGIC_VECTOR (7 downto 0);
	        SEG      : out STD_LOGIC_VECTOR (7 downto 0);
           DISP_EN  : out STD_LOGIC_VECTOR (3 downto 0);
	        LEDS     : out STD_LOGIC_VECTOR (7 downto 0));
end SequenceDetector;

architecture Behavioral of SequenceDetector is

	component CLK_DIV_FS
      Port (      CLK : in std_logic;
            FCLK,SCLK : out std_logic);
	end component;

	component SEQ_DVR
      Port (      CLK : in std_logic;   
             SWITCHES : in std_logic_vector(7 downto 0);
			        LEDS : out std_logic_vector(7 downto 0); 
                    X : out std_logic);
	end component;

	component FSM
	   Port (  X : in STD_LOGIC;
	         SQ2 : in STD_LOGIC;
	         SQ5 : in STD_LOGIC;
	         CLK : in STD_LOGIC;
	           Z : out STD_LOGIC );   
	end component;

	component BC_DEC
      Port (    CLK,Z : in std_logic;   
              DISP_EN : out std_logic_vector(3 downto 0);
             SEGMENTS : out std_logic_vector(7 downto 0));
	end component;
   
   signal sigclk, sigx, sigz : STD_LOGIC;
   
   begin
      
      Clock: CLK_DIV_FS port map (CLK  => CLK,
                                  SCLK => sigclk);
     
      Sequence_Divider: SEQ_DVR port map (     CLK => sigclk,   
                                          SWITCHES => SWITCHES,
			                                     LEDS => LEDS, 
                                                 X => sigx);
      
      myFSM: FSM port map (   X => sigx,
	                       SQ2 => SQ2,
	                       SQ5 => SQ5,
	                       CLK => sigclk,
	                         Z => sigz );  
                           
      Display: BC_DEC port map (      CLK => CLK,
                                        Z => sigz,
                                  DISP_EN => DISP_EN,
                                 SEGMENTS => SEG);
   end Behavioral;
