------------------------------------------------------------------------
-- CPE 269 VHDL File: ssegdec_4disp.vhd
-- Description: seven segment display driver; displays either hex values
--              of YA,YB,YC,YD inputs or decimal value of 8-bit ALU input
--
-- Author: bryan mealy  (06-12-04)
--
-- revisions: 
------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-------------------------------------------------------------
-- 4 digit seven-segment display driver. Outputs are active
-- low and configured ABCEDFG in "segment" output. 
--------------------------------------------------------------
entity sseg_dec is
    Port (  YA,YB,YC,YD : in std_logic_vector(3 downto 0);
                ALU_VAL : in std_logic_vector(7 downto 0); 
                    CLK : in std_logic;
               ALU_DISP : in std_logic;
                DISP_EN : out std_logic_vector(3 downto 0);
               SEGMENTS : out std_logic_vector(6 downto 0));
end sseg_dec;

-------------------------------------------------------------
-- description of ssegment decoder
-------------------------------------------------------------
architecture my_sseg of sseg_dec is

   -- declaration of 8-bit binary to 2-digit BCD converter --
   component bin2bcdconv 
       Port ( BIN_CNT_IN : in std_logic_vector(7 downto 0);
                 LSD_OUT : out std_logic_vector(3 downto 0);
                 MSD_OUT : out std_logic_vector(3 downto 0);
                MMSD_OUT : out std_logic_vector(3 downto 0));
   end component;

   -- intermediate signal declaration -----------------------
   signal   cnt_dig : std_logic_vector(1 downto 0); 
   signal   digit : std_logic_vector (3 downto 0); 
   signal   lsd,msd,mmsd : std_logic_vector(3 downto 0); 

begin

   -- instantiation of bin to bcd converter -----------------
   my_conv: bin2bcdconv port map ( BIN_CNT_IN => ALU_VAL, 
                                      LSD_OUT => lsd, 
                                      MSD_OUT => msd, 
                                     MMSD_OUT => mmsd); 



   -- advance the count (used for display multiplexing) -----
   process (clk)
   begin
      if (rising_edge(CLK)) then 
         cnt_dig <= cnt_dig + 1; 
      end if; 
   end process; 

   -- select the display sseg data abcdefg (active low) -----
   segments <= "0000001" when digit = "0000"  else
               "1001111" when digit = "0001"  else
               "0010010" when digit = "0010"  else
               "0000110" when digit = "0011"  else
               "1001100" when digit = "0100"  else
               "0100100" when digit = "0101"  else
               "0100000" when digit = "0110"  else
               "0001111" when digit = "0111"  else
               "0000000" when digit = "1000"  else
               "0000100" when digit = "1001"  else
               "0001000" when digit = "1010"  else
               "1100000" when digit = "1011"  else
               "0110001" when digit = "1100"  else
               "1000010" when digit = "1101"  else
               "0110000" when digit = "1110"  else
               "0111000" when digit = "1111"  else
               "1111111"; 

   -- actuate the correct display --------------------------
   disp_en <= "1110" when cnt_dig = "00" else 
              "1101" when cnt_dig = "01" else
              "1011" when cnt_dig = "10" else
              "0111" when cnt_dig = "11" else
              "1111"; 

   ------------------------------------------------------
   -- send either the ALU data or register data to the 
   -- outputs of the display
   ------------------------------------------------------
   process (ALU_DISP,cnt_dig,YA,YB,YC,YD,lsd,msd,mmsd)
      begin
      if (ALU_DISP = '0') then 
         case cnt_dig is
            when "00" => digit <= YA; 
            when "01" => digit <= YB; 
            when "10" => digit <= YC; 
            when "11" => digit <= YD; 
            when others => digit <= "0000"; 
         end case; 
      else 
         case cnt_dig is
            when "00" => digit <= "0000"; 
            when "01" => digit <= mmsd; 
            when "10" => digit <= msd; 
            when "11" => digit <= lsd; 
            when others => digit <= "0000"; 
         end case; 
      end if;             
   end process; 

end my_sseg;



------------------------------------------------------------------------
-- CPE 269 VHDL File: ssegdec.vhd
-- Description: converts 8-bit binary number to three digit BCD number 
--
-- Author: bryan mealy  (06-12-04)
--
-- revisions: 
------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


--------------------------------------------------------------------
-- interface description for bin to bcd converter 
--------------------------------------------------------------------
entity bin2bcdconv is
    Port ( BIN_CNT_IN : in std_logic_vector(7 downto 0);
              LSD_OUT : out std_logic_vector(3 downto 0);
              MSD_OUT : out std_logic_vector(3 downto 0);
             MMSD_OUT : out std_logic_vector(3 downto 0));
end bin2bcdconv;

---------------------------------------------------------------------
-- description of 8-bit binary to 3-digit BCD converter 
---------------------------------------------------------------------
architecture my_ckt of bin2bcdconv is
begin
   process(bin_cnt_in)
       variable cnt_tot : INTEGER range 0 to 255 := 0; 
	    variable lsd,msd,mmsd : INTEGER range 0 to 9 := 0; 
   begin
	 
	 -- convert input binary value to decimal
	 cnt_tot := 0; 
    if (bin_cnt_in(7) = '1') then cnt_tot := cnt_tot + 128;  end if; 
    if (bin_cnt_in(6) = '1') then cnt_tot := cnt_tot +  64;  end if; 
    if (bin_cnt_in(5) = '1') then cnt_tot := cnt_tot +  32;  end if; 
    if (bin_cnt_in(4) = '1') then cnt_tot := cnt_tot +  16;  end if; 
    if (bin_cnt_in(3) = '1') then cnt_tot := cnt_tot +   8;  end if; 
    if (bin_cnt_in(2) = '1') then cnt_tot := cnt_tot +   4;  end if; 
    if (bin_cnt_in(1) = '1') then cnt_tot := cnt_tot +   2;  end if; 
    if (bin_cnt_in(0) = '1') then cnt_tot := cnt_tot +   1;  end if; 

	 -- initialize intermediate signals
    msd  := 0; 
	 mmsd := 0; 
	 lsd  := 0;
           
    --  calculate the MMSB
    for I in 1 to 2 loop
	    exit when (cnt_tot >= 0 and cnt_tot < 100); 
	    mmsd := mmsd + 1; -- increment the mmds count
	    cnt_tot := cnt_tot - 100;
    end loop; 
      	         
     --  calculate the MSB
    for I in 1 to 9 loop	     
       exit when (cnt_tot >= 0 and cnt_tot < 10); 
       msd := msd + 1; -- increment the mds count
	    cnt_tot := cnt_tot - 10;
    end loop; 
      	    
	 lsd := cnt_tot;   -- lsd is what is left over

	 -- convert lsd to binary
	 case lsd is 
	    when 9 =>  lsd_out <= "1001"; 
	    when 8 =>  lsd_out <= "1000"; 
	    when 7 =>  lsd_out <= "0111"; 
	    when 6 =>  lsd_out <= "0110"; 
	    when 5 =>  lsd_out <= "0101"; 
	    when 4 =>  lsd_out <= "0100"; 
	    when 3 =>  lsd_out <= "0011"; 
	    when 2 =>  lsd_out <= "0010"; 
	    when 1 =>  lsd_out <= "0001"; 
	    when 0 =>  lsd_out <= "0000"; 
	    when others =>  lsd_out <= "0000"; 
    end case; 

	 -- convert msd to binary
	 case msd is 
	    when 9 =>  msd_out <= "1001"; 
	    when 8 =>  msd_out <= "1000"; 
	    when 7 =>  msd_out <= "0111"; 
	    when 6 =>  msd_out <= "0110"; 
	    when 5 =>  msd_out <= "0101"; 
	    when 4 =>  msd_out <= "0100"; 
	    when 3 =>  msd_out <= "0011"; 
	    when 2 =>  msd_out <= "0010"; 
	    when 1 =>  msd_out <= "0001"; 
	    when 0 =>  msd_out <= "0000"; 
	    when others =>  msd_out <= "0000"; 
      end case; 

	 -- convert msd to binary
	 case mmsd is  
	    when 2 =>  mmsd_out <= "0010"; 
	    when 1 =>  mmsd_out <= "0001"; 
	    when 0 =>  mmsd_out <= "0000"; 
	    when others =>  mmsd_out <= "0000"; 
    end case; 

   end process; 
end my_ckt;




