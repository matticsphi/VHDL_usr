entity fcadd2 is
    port (CI            : in bit;
          A1,A0,B1,B0   : in  bit;
          SUM1,SUM0     : out bit;
          E,R           : out bit);
end fcadd2;

architecture archfcadd2 of fcadd2 is
begin
    sum0 <= a0 xor b0 xor CI;
    sum1 <= a1 xor b1 xor ((a0 and b0) or (a0 and CI) or (b0 and CI));

    e <= (a1 and b1) or ((a1 or b1) and (a0 and b0));
    r <= (a1 or b1) and (a0 or b0);
end archfcadd2;


entity fcadd8_2 is
    port (CI : in bit;
        A7,A6,A5,A4,A3,A2,A1,A0: in bit;
        B7,B6,B5,B4,B3,B2,B1,B0: in bit;
        SUM7,SUM6,SUM5,SUM4,SUM3,SUM2,SUM1,SUM0 : out bit;
        CO: out bit);
end fcadd8_2;
architecture archFCADD8_2 of FCADD8_2 is
	component fcadd2 port(
    	  CI            : in bit;
          A1,A0,B1,B0   : in  bit;
          SUM1,SUM0     : out bit;
          E,R           : out bit);
	end component;
        signal c2,c4,c6 : bit;
        attribute synthesis_off of c2,c4,c6 : signal is true;
        signal e0,e1,e2,e3 : bit;
        attribute synthesis_off of e1,e2,e3 : signal is true;
        signal r0,r1,r2,r3 : bit;
        attribute synthesis_off of r1,r2,r3 : signal is true;
begin
    U1: fcadd2 port map (ci,a1,a0,b1,b0,sum1,sum0,e0,r0);
    U2: fcadd2 port map (c2,a3,a2,b3,b2,sum3,sum2,e1,r1);
    U3: fcadd2 port map (c4,a5,a4,b5,b4,sum5,sum4,e2,r2);
    U4: fcadd2 port map (c6,a7,a6,b7,b6,sum7,sum6,e3,r3);

    c2 <= e0 or (r0 and ci); 
    c4 <= e1 or (r1 and e0) or (r1 and r0 and ci); 
    c6 <= e2 or (r2 and e1) or (r2 and r1 and e0) or 
					(r2 and r1 and r0 and ci);
    co <= e3 or (r3 and e2) or (r3 and r2 and e1) or 
				(r3 and r2 and r1 and e0) or (r3 and r2 and r1 and r0 and ci);
end archFCADD8_2;
