                                                    11/9/94

                      EXAMPLES READ ME FILE         
                      ---------------------

    The Warp VHDL examples are organized into the following design 
directories:

       1) \examples\counters (counter designs)

       2) \examples\logic (standard logic and arithmetic designs) 

       3) \examples\fsm (finite state machine designs)

       4) \examples\wtutor (files/data needed for Warp Tutorials)

       5) \examples\vhdlbook (files/data needed for the VHDL Book)

    Brief descriptions of each example file found in the directories are 
given below. The design descriptions are ordered in level of complexity,
the first one being the least complex. All designs can be compiled and
synthesized to a CY7C371 except cnt4_exp.vhd as noted. 

    Items (3) and (4) are not described here and you will need to refer
to the Warp Tuturials Section of the Warp Users Guide and the VHDL Book
respectively.


\logic
------
     nand2_ts.vhd   Tri-state two input NAND gate.

     ff_v1.vhd      Different versions of a single flip-flop.
     ff_v2.vhd
 
     dec24.vhd      Two to four bit decoder.

     mux41_v1.vhd   Different versions of a three bit, four to one MUX.
     mux41_v2.vhd 
     mux41_v3.vhd
     mux41_v4.vhd

     comp4_v1.vhd   Different versions of a four bit comparator.
     comp4_v2.vhd
     comp4_v3.vhd
     comp4_v4.vhd

     pins.vhd       Five input AND gate using the CY7C371 PLCC part and assigning 
                    inputs and outputs to specific pins.



\counters
---------
     cnt4.vhd       Four bit up counter with load.

     cnt4_sr.vhd    Four bit up counter with load and syncronous reset.

     cnt4_ar.vhd    Four bit up counter with load, enable and asyncronous
                    reset.

     cnt4_arp.vhd   Four bit up counter with load, enable, asyncronous 
                    reset and asyncronous preset.

     cnt4_exp.vhd   Four bit counter with syncronous reset. The counter 
                    uses expressions for clocks and resets. Must target
		    a device with expression clocks (34X, 38X).

     cnt4_flg.vhd   Four bit up counter that flags the count, "1001".

     cnt8_oe.vhd    Eight bit counter with load on the bidirectional pins.

     cnt4_rec.vhd   Four bit counter with load on the bidirectional pins 
                    and syncronous reset. The VHDL code uses a RECORD to 
                    simplify the design.

     cntn_gen.vhd   N bit counter  with load on the bidirectional pins and
                    syncronous reset. The VHDL code uses the GENERIC
                    statement to specify the counter size. 

     cnt4_pkg.vhd   This is the package definition of a four bit up 
                    counter. The package is used in the cnt4x3.vhd design.
      
     cnt4x3.vhd     Three four bit up counters using two clocks. The up 
                    counters are defined in the counter_pkg found in the 
                    file, cnt4_pkg.vhd.



\fsm
----
     moore_v1.vhd   Different versions of a state machine that produces
     moore_v2.vhd   only Moore output signals.
     moore_v3.vhd
     moore_v4.vhd

     mealy.vhd      A finite state machine that produces both Mealy and
                    Moore outputs.

     drink.vhd      A drink dispensing machine controller.

     security.vhd   A state machine that implements a home security system.

     traffic.vhd    A traffic light controller. 

     ttf.vhd        A second version of the home security system. This 
                    version implements the state machine using a state 
                    table.

     ttf2.vhd       Another version of the moore machines above. This 
                    version uses a truth table, and the truth table
		    function.

     

