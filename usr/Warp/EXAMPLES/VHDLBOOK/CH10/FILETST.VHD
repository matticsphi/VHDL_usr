------------------------------------------------------------------------
-- test fixture for memory controller
-- reads file "memory.inp" ; writes file "memory.out"
------------------------------------------------------------------------
entity test_fixture_of_memory is end;
library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use work.myio.all;
use work.memory_pkg.all; 
architecture testmemory of test_fixture_of_memory is 
   signal clk: std_logic := '0';
   signal reset, read_write, ready, burst, oe, we : std_logic;
   signal bus_id: std_logic_vector(7 downto 0);
   signal addr: std_logic_vector(1 downto 0);
begin
    -- instantiate the unit under test 
    uut: memory_controller port map(
		reset => reset,
		read_write => read_write,
		ready => ready, 
		burst => burst,
		clk => clk,
		bus_id => bus_id,
		oe => oe,
		we => we,
		addr => addr );

test: process
  file vector_file : text is in "memory.inp";
  file output_file : text is out "memory.out"; 
  variable invecs, outvecs : line;
  variable good : boolean;
  variable ch : character;
  variable vbus_id: std_logic_vector(7 downto 0);
  variable vreset, vread_write, vready, vburst : std_logic;
  variable out_vec: std_logic_vector(3 downto 0);
begin
    while not endfile(vector_file) loop
        -- read a line from the file
        readline(vector_file, invecs);
	
	--skip line if it does not begin with a tab
	read(invecs, ch, good);
	if not good or ch /= HT then next; end if;
        
   -- skip line if next value is not a std_logic 
	read(invecs, vreset, good);
	next when not good;

	-- found a vector
	-- read vreset, vread_write, vready, vburst, vbus_id
	-- with tabs in between 
	read(invecs,ch);
	read(invecs,vread_write);
	read(invecs,ch);
	read(invecs,vready);
	read(invecs,ch);
	read(invecs,vburst);
	read(invecs,ch);
	read(invecs,vbus_id);

	-- wait for 10 ns before scheduling the vector (we want
	-- to introduce skew between the vectors and clock edges)
   wait for 10 ns;

	-- schedule vectors
	reset <= vreset;
	read_write <= vread_write;
	ready <= vready;
	burst <= vburst;
	bus_id <= vbus_id;

	-- apply vectors with plenty of setup time
	-- also, record the current output vector 
	-- we will record output vectors 10 ns before rising
	-- edge of clock for each clock cycle
	wait for 10 ns;
	out_vec := oe & we & addr;
	write(outvecs, out_vec); writeline(output_file, outvecs); 	

	-- schedule and execute clock transition
	clk <= not (clk);
	wait for 20 ns;

	-- schedule and ensure execution of next clock transition
	clk <= not (clk) after 0 ns;

    end loop;

    assert false report "Test complete";
    end process; 
end;
