--$Binding file
--VHDL Netlister -V4 IR x56
--Created: Wednesday, March 27, 1996 9:30 am
--Copyright (c) 1995 Cypress Semiconductor, Inc.

library ieee;
use ieee.std_logic_1164.all;

package pldpkg is
component pld
    port(result0: INOUT std_logic;
         result1: INOUT std_logic;
         result2: INOUT std_logic;
         result3: INOUT std_logic;
         functsel0: IN std_logic;
         functsel1: IN std_logic;
         functsel2: IN std_logic;
         bin0: IN std_logic;
         bin1: IN std_logic;
         bin2: IN std_logic;
         bin3: IN std_logic;
         ain0: IN std_logic;
         ain1: IN std_logic;
         ain2: IN std_logic;
         ain3: IN std_logic;
         add_sub_sel: IN std_logic;
         addsub_cout: INOUT std_logic);
end component;
end pldpkg;

library ieee;
use ieee.std_logic_1164.all;
use work.lpmpkg.all;
use work.rtlpkg.all;

entity pld is
    port(result0: INOUT std_logic;
         result1: INOUT std_logic;
         result2: INOUT std_logic;
         result3: INOUT std_logic;
         functsel0: IN std_logic;
         functsel1: IN std_logic;
         functsel2: IN std_logic;
         bin0: IN std_logic;
         bin1: IN std_logic;
         bin2: IN std_logic;
         bin3: IN std_logic;
         ain0: IN std_logic;
         ain1: IN std_logic;
         ain2: IN std_logic;
         ain3: IN std_logic;
         add_sub_sel: IN std_logic;
         addsub_cout: INOUT std_logic);
end pld;

architecture archpld of pld is
    signal magb3: std_logic;
    signal magb2: std_logic;
    signal magb1: std_logic;
    signal magb0: std_logic;
    signal maga3: std_logic;
    signal maga2: std_logic;
    signal maga1: std_logic;
    signal maga0: std_logic;
    signal invb3: std_logic;
    signal invb2: std_logic;
    signal invb1: std_logic;
    signal invb0: std_logic;
    signal inva3: std_logic;
    signal inva2: std_logic;
    signal inva1: std_logic;
    signal inva0: std_logic;
    signal axorb3: std_logic;
    signal axorb2: std_logic;
    signal axorb1: std_logic;
    signal axorb0: std_logic;
    signal aorb3: std_logic;
    signal aorb2: std_logic;
    signal aorb1: std_logic;
    signal aorb0: std_logic;
    signal addsub3: std_logic;
    signal addsub2: std_logic;
    signal addsub1: std_logic;
    signal addsub0: std_logic;
    signal aandb3: std_logic;
    signal aandb2: std_logic;
    signal aandb1: std_logic;
    signal aandb0: std_logic;
    signal zero: std_logic := '0';
    signal  one: std_logic := '1';

begin
	maga3 <= '0';
	maga2 <= '0';
    vl1i4: mmux
        generic map(lpm_width => 4,
                   lpm_size => 8,
                   lpm_widths => 3,
                   lpm_hint => speed)
	port map(data(3) => addsub3,
                 data(2) => addsub2,
                 data(1) => addsub1,
                 data(0) => addsub0,
                 data(7) => magb3,
                 data(6) => magb2,
                 data(5) => magb1,
                 data(4) => magb0,
                 data(11) => maga3,
                 data(10) => maga2,
                 data(9) => maga1,
                 data(8) => maga0,
                 data(15) => aandb3,
                 data(14) => aandb2,
                 data(13) => aandb1,
                 data(12) => aandb0,
                 data(19) => aorb3,
                 data(18) => aorb2,
                 data(17) => aorb1,
                 data(16) => aorb0,
                 data(23) => axorb3,
                 data(22) => axorb2,
                 data(21) => axorb1,
                 data(20) => axorb0,
                 data(27) => inva3,
                 data(26) => inva2,
                 data(25) => inva1,
                 data(24) => inva0,
                 data(31) => invb3,
                 data(30) => invb2,
                 data(29) => invb1,
                 data(28) => invb0,
                 result(3) => result3,
                 result(2) => result2,
                 result(1) => result1,
                 result(0) => result0,
                 sel(2) => functsel2,
                 sel(1) => functsel1,
                 sel(0) => functsel0);

    vl1i3: minv
        generic map(lpm_hint => speed,
                   lpm_width => 4)
	port map(data(3) => bin3,
                 data(2) => bin2,
                 data(1) => bin1,
                 data(0) => bin0,
                 result(3) => invb3,
                 result(2) => invb2,
                 result(1) => invb1,
                 result(0) => invb0);

    vl1i2: mcompare
        generic map(lpm_representation => lpm_unsigned,
                   lpm_width => 4,
                   lpm_hint => speed)
	port map(aeb => maga0,
                 agb => magb2,
                 ageb => magb3,
                 alb => magb0,
                 aleb => magb1,
                 aneb => maga1,
                 dataa(3) => ain3,
                 dataa(2) => ain2,
                 dataa(1) => ain1,
                 dataa(0) => ain0,
                 datab(3) => bin3,
                 datab(2) => bin2,
                 datab(1) => bin1,
                 datab(0) => bin0);

    vl1i15: minv
        generic map(lpm_hint => speed,
                   lpm_width => 4)
	port map(data(3) => ain3,
                 data(2) => ain2,
                 data(1) => ain1,
                 data(0) => ain0,
                 result(3) => inva3,
                 result(2) => inva2,
                 result(1) => inva1,
                 result(0) => inva0);

    vl1i14: mxor
        generic map(lpm_hint => speed,
                   lpm_width => 4,
                   lpm_size => 2)
	port map(data(3) => ain3,
                 data(2) => ain2,
                 data(1) => ain1,
                 data(0) => ain0,
                 data(7) => bin3,
                 data(6) => bin2,
                 data(5) => bin1,
                 data(4) => bin0,
                 result(3) => axorb3,
                 result(2) => axorb2,
                 result(1) => axorb1,
                 result(0) => axorb0);

    vl1i13: mor
        generic map(lpm_hint => speed,
                   lpm_width => 4,
                   lpm_size => 2)
	port map(data(3) => ain3,
                 data(2) => ain2,
                 data(1) => ain1,
                 data(0) => ain0,
                 data(7) => bin3,
                 data(6) => bin2,
                 data(5) => bin1,
                 data(4) => bin0,
                 result(3) => aorb3,
                 result(2) => aorb2,
                 result(1) => aorb1,
                 result(0) => aorb0);

    vl1i12: mand
        generic map(lpm_hint => speed,
                   lpm_width => 4,
                   lpm_size => 2)
	port map(data(3) => ain3,
                 data(2) => ain2,
                 data(1) => ain1,
                 data(0) => ain0,
                 data(7) => bin3,
                 data(6) => bin2,
                 data(5) => bin1,
                 data(4) => bin0,
                 result(3) => aandb3,
                 result(2) => aandb2,
                 result(1) => aandb1,
                 result(0) => aandb0);

    vl1i1: madd_sub
        generic map(lpm_direction => lpm_no_typ,
                   lpm_representation => lpm_unsigned,
                   lpm_width => 4,
                   lpm_hint => area)
	port map(add_sub => add_sub_sel,
                 cout => addsub_cout,
                 dataa(3) => ain3,
                 dataa(2) => ain2,
                 dataa(1) => ain1,
                 dataa(0) => ain0,
                 datab(3) => bin3,
                 datab(2) => bin2,
                 datab(1) => bin1,
                 datab(0) => bin0,
                 result(3) => addsub3,
                 result(2) => addsub2,
                 result(1) => addsub1,
                 result(0) => addsub0,
                 cin => zero,
                 overflow => open);

end archpld;

library ieee;
use ieee.std_logic_1164.all;

package top_alupkg is
component top_alu
    port(cout: INOUT std_logic;
         answer3: INOUT std_logic;
         answer2: INOUT std_logic;
         answer1: INOUT std_logic;
         answer0: INOUT std_logic;
         instruction3: IN std_logic;
         instruction2: IN std_logic;
         instruction1: IN std_logic;
         instruction0: IN std_logic;
         a3: IN std_logic;
         a2: IN std_logic;
         a1: IN std_logic;
         a0: IN std_logic;
         b3: IN std_logic;
         b2: IN std_logic;
         b1: IN std_logic;
         b0: IN std_logic);
end component;
end top_alupkg;

library ieee;
use ieee.std_logic_1164.all;
use work.cntrlpkg.all;
use work.pldpkg.all;
use work.rtlpkg.all;

entity top_alu is
    port(cout: INOUT std_logic;
         answer3: INOUT std_logic;
         answer2: INOUT std_logic;
         answer1: INOUT std_logic;
         answer0: INOUT std_logic;
         instruction3: IN std_logic;
         instruction2: IN std_logic;
         instruction1: IN std_logic;
         instruction0: IN std_logic;
         a3: IN std_logic;
         a2: IN std_logic;
         a1: IN std_logic;
         a0: IN std_logic;
         b3: IN std_logic;
         b2: IN std_logic;
         b1: IN std_logic;
         b0: IN std_logic);
end top_alu;

architecture archtop_alu of top_alu is
    signal function_sel2: std_logic;
    signal function_sel1: std_logic;
    signal function_sel0: std_logic;
    signal addsub_sel: std_logic;
    signal zero: std_logic := '0';
    signal  one: std_logic := '1';

begin
    vl1i2: cntrl
	port map(addsubsel => addsub_sel,
                 functionsel(2) => function_sel2,
                 functionsel(1) => function_sel1,
                 functionsel(0) => function_sel0,
                 instr(3) => instruction3,
                 instr(2) => instruction2,
                 instr(1) => instruction1,
                 instr(0) => instruction0);

    vl1i1: pld
	port map(addsub_cout => cout,
                 add_sub_sel => addsub_sel,
                 ain3 => a3,
                 ain2 => a2,
                 ain1 => a1,
                 ain0 => a0,
                 bin3 => b3,
                 bin2 => b2,
                 bin1 => b1,
                 bin0 => b0,
                 functsel2 => function_sel2,
                 functsel1 => function_sel1,
                 functsel0 => function_sel0,
                 result3 => answer3,
                 result2 => answer2,
                 result1 => answer1,
                 result0 => answer0);

end archtop_alu;

