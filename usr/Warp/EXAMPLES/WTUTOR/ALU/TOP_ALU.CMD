restart
stepsize 25ns
vector instr 	instruction[3:0]
vector answer	answer[3:0]
vector a 	a[3:0]
vector b	b[3:0]
wave  top_alu.wfm instr a b answer cout

a a 9\h
a b 5\h
a instr 0\h

cycle 5

a instr 1\h

cycle 5

a instr 2\h

cycle 5

a instr 3\h

cycle 5

a instr 4\h

cycle 5

a instr 5\h

cycle 5

a instr 6\h

cycle 5

a instr 7\h

cycle 5

a instr 8\h

cycle 5
