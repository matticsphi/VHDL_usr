library ieee;
use ieee.std_logic_1164.all;
use work.numeric_std.all;
package regs_pkg is
	component rdff1 port (
	    clk, reset: in std_logic;
	    d:      in std_logic; 
	    q:      buffer std_logic); 
	end component;
	component rdff 
	    generic (size: integer := 2);
	    port (  clk, reset: in std_logic;
	        d:      in std_logic_vector(size-1 downto 0); 
	        q:      buffer std_logic_vector(size-1 downto 0)); 
	end component;
	component pdff1 port (
		clk, preset:    in std_logic;
		d:              in std_logic; 
		q:              buffer std_logic); 
	end component;
	component rreg1 port(
	        clk, reset, load:      in std_logic;
	        d:              in std_logic;
	        q:              buffer std_logic);
	end component;
	component rreg 
	        generic (size: integer := 2);
	        port(   clk, reset, load:	in std_logic;
	                d:				in std_logic_vector(size-1 downto 0);
	                q:				buffer std_logic_vector(size-1 downto 	0));
	end component;
	component preg1 port(
		clk, preset, load:      in std_logic;
		d:              in std_logic;
 		q:              buffer std_logic);
	end component;
	component preg 
		generic(size: integer := 2);
		port( 	clk, preset, load:	in std_logic;
			d:						in std_logic_vector(size-1 downto 0);
 			q:						buffer std_logic_vector(size-1 downto 0));
 	end component;
	component reg generic ( size: integer := 2);
	port(   clk, load:      in std_logic;
		rst, pst:       in std_logic;
		d:              in std_logic_vector(size-1 downto 0);
		q:              buffer std_logic_vector(size-1 downto 0));
	end component;
	component ureg 
        generic (size: integer := 2);
        port(   clk, reset, load:	in std_logic;
                d:              	in unsigned(size-1 downto 0);
                q:              	buffer unsigned(size-1 downto 0));
	end component;
end regs_pkg;

library ieee;
use ieee.std_logic_1164.all;
package counters_pkg is
	component ascount  
		generic (CounterSize: integer := 2);
		port(	clk, areset, sreset, enable: in std_logic;
			count:    			buffer std_logic_vector(counterSize-1 downto 0));
	end component;
end counters_pkg;

library ieee;
use ieee.std_logic_1164.all;
package synch_pkg is
	component rsynch port (
		clk, reset:     in std_logic;
		d:              in std_logic; 
		q:              buffer std_logic); 
	end component;
	component psynch port (
		clk, preset:    in std_logic;
		d:              in std_logic; 
		q:              buffer std_logic); 
	end component;
end synch_pkg;

