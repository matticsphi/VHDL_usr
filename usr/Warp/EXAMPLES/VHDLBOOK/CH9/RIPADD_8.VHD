entity full_adder is
    port (ci:			in bit;
          a,b:			in  bit;
          sum, co:		out bit);
end full_adder;
architecture full_adder of full_adder is
begin
	sum <= a xor b xor ci;
	co <= ((a or b) and ci) or (a and b);
end;
entity ripadd_8 is
    port (CI:				in bit;
        A7,A6,A5,A4,A3,A2,A1,A0:	in bit;
        B7,B6,B5,B4,B3,B2,B1,B0:	in bit;
        SUM7,SUM6,SUM5,SUM4,SUM3,SUM2,SUM1,SUM0 : out bit;
        CO: out bit);
end ripadd_8;
architecture ripadd_8 of ripadd_8 is
	component full_adder 
	    port (ci:						in bit;
 	         a,b:						in  bit;
 	         sum, co:						out bit);
	end component;
	signal c1, c2, c3, c4, c5, c6, c7: bit;
begin
	u1: full_adder port map(ci, a0, b0, sum0, c1);
	u2: full_adder port map(c1, a1, b1, sum1, c2);
	u3: full_adder port map(c2, a2, b2, sum2, c3);
	u4: full_adder port map(c3, a3, b3, sum3, c4);
	u5: full_adder port map(c4, a4, b4, sum4, c5);
	u6: full_adder port map(c5, a5, b5, sum5, c6);
	u7: full_adder port map(c6, a6, b6, sum6, c7);
	u8: full_adder port map(c7, a7, b7, sum7, co);
end;
