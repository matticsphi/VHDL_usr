entity fcadd3 is port (
	  CI                  : in bit;
          A2,A1,A0,B2,B1,B0   : in  bit;
          SUM2, SUM1,SUM0     : out bit;
          E,R                 : out bit);
end fcadd3;

architecture archfcadd3 of fcadd3 is
	signal c1, c2: bit;
begin
    sum0 <= a0 xor b0 xor CI;
    sum1 <= a1 xor b1 xor c1;
    sum2 <= a2 xor b2 xor c2;

	c1 <= (a0 and b0) or ((a0 or b0) and ci);
	c2 <= (a1 and b1) or ((a1 or b1) and (a0 and b0)) or
		((a1 or b1) and (a0 or b0) and ci);

    e <= (a2 and b2) or ((a2 or b2) and (a1 and b1)) or 
	((a2 or b2) and (a1 or b1) and (a0 and b0));
    r <= (a2 or b2) and (a1 or b1) and (a0 or b0);
end archfcadd3;


entity fcadd8_3 is
    port (CI : in bit;
        A7,A6,A5,A4,A3,A2,A1,A0: in bit;
        B7,B6,B5,B4,B3,B2,B1,B0: in bit;
        SUM7,SUM6,SUM5,SUM4,SUM3,SUM2,SUM1,SUM0 : out bit;
        CO: out bit);
end fcadd8_3;
architecture archFCADD8_3 of FCADD8_3 is
	component fcadd3 port(
          CI                  : in bit;
          A2,A1,A0,B2,B1,B0   : in  bit;
          SUM2, SUM1,SUM0     : out bit;
          E,R                 : out bit);
	end component;
   component fcadd2 port(
          CI            : in bit;
          A1,A0,B1,B0   : in  bit;
          SUM1,SUM0     : out bit;
          E,R           : out bit);
   end component;
        signal c3,c6 : bit;
        attribute synthesis_off of c3,c6 : signal is true;
        signal e0,e1,e2 : bit;
        attribute synthesis_off of e1,e2 : signal is true;
        signal r0,r1,r2 : bit;
        attribute synthesis_off of r1,r2 : signal is true;
		  signal vss : bit := '0';
begin
    U1: fcadd3 port map (ci,a2,a1,a0,b2,b1,b0,sum2,sum1,sum0,e0,r0);
    U2: fcadd3 port map (c3,a5,a4,a3,b5,b4,b3,sum5,sum4,sum3,e1,r1);
    U3: fcadd2 port map (c6,a7,a6,b7,b6,sum7,sum6,e2,r2);

    c3 <= e0 or (r0 and ci); 
    c6 <= e1 or (r1 and e0) or (r1 and r0 and ci); 
    co <= e2 or (r2 and e1) or (r2 and r1 and e0) or 
			(r2 and r1 and r0 and ci);
end archFCADD8_3;
