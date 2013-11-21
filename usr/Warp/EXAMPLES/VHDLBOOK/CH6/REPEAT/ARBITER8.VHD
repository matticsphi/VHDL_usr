library ieee, basic;
use ieee.std_logic_1164.all;
use basic.regs_pkg.all;
use basic.synch_pkg.all;
use basic.counters_pkg.all;
-- The following lines are added for Warp to find entities in the
-- basic library.
use basic.rdff1; use basic.pdff1;

entity arbiter8 is port(
		 txclk:                 in std_logic;   -- TX_CLK
		 areset:                in std_logic;   -- Asynch Reset
		 activity1:             in std_logic;   -- Port Activity 1       
		 activity2:             in std_logic;   -- Port ACtivity 2
		 activity3:             in std_logic;   -- Port ACtivity 3
		 activity4:             in std_logic;   -- Port Activity 4       
		 activity5:             in std_logic;   -- Port ACtivity 5
		 activity6:             in std_logic;   -- Port ACtivity 6
		 activity7:             in std_logic;   -- Port ACtivity 7
		 activity8:             in std_logic;   -- Port ACtivity 8
		 sel1:                  buffer std_logic;  -- Port Select 1
		 sel2:                  buffer std_logic;  -- Port Select 2
		 sel3:                  buffer std_logic;  -- Port Select 3
		 sel4:                  buffer std_logic;  -- Port Select 4
		 sel5:                  buffer std_logic;  -- Port Select 5
		 sel6:                  buffer std_logic;  -- Port Select 6
		 sel7:                  buffer std_logic;  -- Port Select 7
		 sel8:                  buffer std_logic;  -- Port Select 8
		 nosel:                 buffer std_logic;  -- No Port Selected
		 carrier:               buffer std_logic;  -- Carrier Detected
		 collision:             buffer std_logic); -- Collision Detected
end arbiter8;

architecture archarbiter8 of arbiter8 is
--      Signals

signal  colin, carin: std_logic;
signal  activityin1, activityin2, activityin3, activityin4: std_logic;
signal  activityin5, activityin6, activityin7, activityin8: std_logic;
signal  noactivity: std_logic;

begin
--      Components

u1: rdff1 port map  (txclk, areset, activityin1, sel1);
u2: rdff1 port map  (txclk, areset, activityin2, sel2);
u3: rdff1 port map  (txclk, areset, activityin3, sel3);
u4: rdff1 port map  (txclk, areset, activityin4, sel4);
u5: rdff1 port map  (txclk, areset, activityin5, sel5);
u6: rdff1 port map  (txclk, areset, activityin6, sel6);
u7: rdff1 port map  (txclk, areset, activityin7, sel7);
u8: rdff1 port map  (txclk, areset, activityin8, sel8);

u9: pdff1 port map  (txclk, areset, noactivity, nosel);

u10: rdff1 port map (txclk, areset, colin, collision);
u11: rdff1 port map (txclk, areset, carin, carrier);

--      Arstd_logicration Select Logic
	activityin1  <= activity1;

	activityin2  <= activity2 
		       AND NOT activity1;

	activityin3  <= activity3 
		       AND NOT(activity1 OR activity2);
		   
	activityin4  <= activity4
		       AND NOT(activity1 OR activity2 OR activity3);

	activityin5  <= activity5
		       AND NOT(activity1 OR activity2 OR activity3 OR activity4);

	activityin6  <= activity6
		       AND NOT(activity1 OR activity2 OR activity3 OR activity4 OR
			   activity5);

	activityin7  <= activity7 
		       AND NOT(activity1 OR activity2 OR activity3 OR activity4 OR
			   activity5 OR activity6);

	activityin8  <= activity8 
		       AND NOT(activity1 OR activity2 OR activity3 OR activity4 OR
			   activity5 OR activity6 OR activity7);


	noactivity   <= NOT(activity1 OR activity2 OR activity3 OR activity4 OR
			 activity5 OR activity6 OR activity7 OR activity8);
 
-- inserted parenthesis around each group for (a * (b + c + ...)) OR (...
	colin        <= (activity1 AND (activity2 OR activity3 OR activity4 OR
		       activity5 OR activity6 OR activity7 OR activity8)) OR

		       (activity2 AND (activity1 OR activity3 OR activity4 OR
		       activity5 OR activity6 OR activity7 OR activity8)) OR

		       (activity3 AND (activity1 OR activity2 OR activity4 OR
		       activity5 OR activity6 OR activity7 OR activity8)) OR

		       (activity4 AND (activity1 OR activity2 OR activity3 OR
		       activity5 OR activity6 OR activity7 OR activity8)) OR

		       (activity5 AND (activity1 OR activity2 OR activity3 OR
		       activity4 OR activity6 OR activity7 OR activity8)) OR

		       (activity6 AND (activity1 OR activity2 OR activity3 OR
		       activity4 OR activity5 OR activity7 OR activity8)) OR

		       (activity7 AND (activity1 OR activity2 OR activity3 OR
		       activity4 OR activity5 OR activity6 OR activity8)) OR

		       (activity8 AND (activity1 OR activity2 OR activity3 OR
		       activity4 OR activity5 OR activity6 OR activity7)) ;

  
	carin        <= activity1 OR activity2 OR activity3 OR activity4 OR
		       activity5 OR activity6 OR activity7 OR activity8 ;
end archarbiter8;        
