library ieee;
use ieee.std_logic_1164.all;
package myflops is
	procedure dff (					signal d: bit_vector;
						signal clk: bit;
						signal q: out bit_vector);
	procedure dff (					signal d: bit_vector;
						signal clk, rst: bit;
						signal q: out bit_vector);
	procedure dff (					signal d: bit_vector;
						signal clk, rst, pst: bit;
						signal q: out bit_vector);
	procedure dff (					signal d: bit_vector;
						signal clk, rst: bit;
						signal q, q_bar: out bit_vector);
	procedure dff (					signal d: std_logic_vector;
						signal clk: std_logic;
						signal q: out std_logic_vector);
	procedure dff (					signal d: std_logic_vector;
						signal clk, rst: std_logic;
						signal q: out std_logic_vector);
	procedure dff (					signal d: std_logic_vector;
						signal clk, rst, pst: std_logic;
						signal q: out std_logic_vector);
	procedure dff (					signal d: std_logic_vector;
						signal clk, rst: std_logic;
						signal q, q_bar: out std_logic_vector);
end myflops;

package body myflops is
procedure dff (					signal d: bit_vector;
					signal clk: bit;
					signal q: out bit_vector) is
begin
	if clk'event and clk = '1' then
		q <= d;
	end if;
end procedure;

procedure dff (					signal d: bit_vector;
					signal clk, rst: bit;
					signal q: out bit_vector) is
begin
	if rst = '1' then q <= (others => '0');
	elsif clk'event and clk = '1' then
		q <= d;
	end if;
end procedure;

procedure dff (					signal d: bit_vector;
					signal clk, rst, pst: bit;
					signal q: out bit_vector) is
begin
	if rst = '1' then q <= (others => '0');
	elsif pst = '1' then q <= (others => '1');
	elsif clk'event and clk = '1' then
		q <= d;
	end if;
end procedure;

procedure dff (					signal d: bit_vector;
					signal clk, rst: bit;
					signal q, q_bar: out bit_vector) is 
begin
	if rst = '1' then q <= (others => '0');
	elsif clk'event and clk = '1' then
		q <= d; q_bar <= not d;
	end if;
end procedure;

procedure dff (					signal d: std_logic_vector;
					signal clk: std_logic;
					signal q: out std_logic_vector) is
begin
	if clk'event and clk = '1' then
		q <= d;
	end if;
end procedure;

procedure dff (					signal d: std_logic_vector;
					signal clk, rst: std_logic;
					signal q: out std_logic_vector) is
begin
	if rst = '1' then q <= (others => '0');
	elsif clk'event and clk = '1' then
		q <= d;
	end if;
end procedure;

procedure dff (					signal d: std_logic_vector;
					signal clk, rst, pst: std_logic;
					signal q: out std_logic_vector) is
begin
	if rst = '1' then q <= (others => '0');
	elsif pst = '1' then q <= (others => '1');
	elsif clk'event and clk = '1' then
		q <= d;
	end if;
end procedure;

procedure dff (					signal d: std_logic_vector;
					signal clk, rst: std_logic;
					signal q, q_bar: out std_logic_vector) is
begin
	if rst = '1' then q <= (others => '0');
	elsif clk'event and clk = '1' then
		q <= d; q_bar <= not d;
	end if;
end procedure;

end myflops;
