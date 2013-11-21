----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:43:04 10/08/2009 
-- Design Name: 
-- Module Name:    DataPath - myDataPath 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DataPath is
    Port ( SCLK : in  STD_LOGIC;
           CTRL : in  STD_LOGIC_VECTOR (4 downto 0);
           SWITCHES : in  STD_LOGIC_VECTOR (7 downto 0);
           CLR : in  STD_LOGIC;
           ACC_Final : out  STD_LOGIC_VECTOR (7 downto 0));
end DataPath;

architecture myDataPath of DataPath is

component Eightbit_Register
    Port ( RegIn : in  STD_LOGIC_VECTOR (7 downto 0);
           Enable, CLR, SCLK : in  STD_LOGIC;
           RegOut : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component Eightbit_Mux 
    Port (  RegInA : in  STD_LOGIC_VECTOR (7 downto 0);
				RegInB : in  STD_LOGIC_VECTOR (7 downto 0);
				muxSel : in  STD_LOGIC_VECTOR (1 downto 0);
            MuxOut : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component Eightbit_Adder
    Port ( MuxIn : in  STD_LOGIC_VECTOR (7 downto 0);
           AccIn : in  STD_LOGIC_VECTOR (7 downto 0);
           CIN : in  STD_LOGIC;
           AddOut : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

signal RA_In, RA_Out, RB_In, RB_Out, MuxOut, Acc_Out, AddOut: std_logic_vector(7 downto 0);
signal muxSel: std_logic_vector(1 downto 0);

begin

RA_In <= SWITCHES(7) & SWITCHES(7) & SWITCHES(7) & SWITCHES(7) & SWITCHES(7) & SWITCHES(6) & SWITCHES(5) & SWITCHES(4);
RB_In <= SWITCHES(3) & SWITCHES(3) & SWITCHES(3) & SWITCHES(3) & SWITCHES(3) & SWITCHES(2) & SWITCHES(1) & SWITCHES(0);
muxSel <= CTRL(3) & CTRL(2);
ACC_Final <= Acc_Out;

RA: Eightbit_Register port map 	(	RegIn => RA_In,
												CLR => CLR,
												SCLK => SCLK,
												Enable => CTRL(0),
												RegOut => RA_Out);

RB: Eightbit_Register port map 	(	RegIn => SWITCHES,
												CLR => CLR,
												SCLK => SCLK,
												Enable => CTRL(1),
												RegOut => RB_Out);

ACC: Eightbit_Register port map 	(	RegIn => AddOut,
												CLR => CLR,
												SCLK => SCLK,
												Enable => CTRL(4),
												RegOut => ACC_Out);


Adder: Eightbit_Adder port map 	(	MuxIn => MuxOut,
												AccIn => Acc_Out,
												CIN => CTRL(2),
												AddOut => AddOut);
											
Mux: Eightbit_Mux port map 		(	RegInA => RA_Out,
												RegInB => RB_Out,
												muxSel => muxSel,
												MuxOut => MuxOut);

end myDataPath;

