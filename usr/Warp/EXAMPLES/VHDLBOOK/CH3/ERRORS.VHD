entity many_errors is port					--line 1
		a: bit_vector(3 to 0);				--line 2
		b: out std_logic_vector(0 to 3);		--line 3
		c: in bit_vector(6 downto 0);)		--line 4
end many_errors							--line 5
					    				line 6
architecture not_so_good of many_errors 		--line 7
begin 								--line 8
my_label: process							--line 9
		begin							--line 10
		if c = x"F" then 					--line 11
			b <= a					--line 12
		else							--line 13
			b <= '0101';				--line 14
		end if						--line 15
  end process;							--line 16
end not_so_good							--line 17
