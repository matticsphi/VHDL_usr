entity flop8 is port(
        clk, rst, pst:  in bit;
        data_in:        in bit_vector(7 downto 0);
        data:           out bit_vector(7 downto 0));
end flop8;

use work.myflops.all;
architecture archflop8 of flop8 is
begin
        dff(data_in,clk,rst,pst,data);
end archflop8;
