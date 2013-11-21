-- test bench for use with a VHDL simulator (not for synthesis)

library ieee;
use ieee.std_logic_1164.all;
entity testcnt is
end testcnt;

use work.mycntpkg.all;
architecture mytest of testcnt is
  signal clk, rst: std_logic;
  signal cnt: std_logic_vector(2 downto 0);
  type test_vector is record
        clk: std_logic;
        rst: std_logic;
        cnt: std_logic_vector(2 downto 0);
  end record;
  type test_vector_array is array(natural range <>) of test_vector;
  constant test_vectors: test_vector_array := (
    -- reset the counter
        (clk => '0', rst => '1', cnt => "000"),
        (clk => '1', rst => '1', cnt => "000"),
        (clk => '0', rst => '0', cnt => "000"),
    -- clock the counter several times
        (clk => '1', rst => '0', cnt => "001"),
        (clk => '0', rst => '0', cnt => "001"),
        (clk => '1', rst => '0', cnt => "010"),
        (clk => '0', rst => '0', cnt => "010"),
        (clk => '1', rst => '0', cnt => "011"),
        (clk => '0', rst => '0', cnt => "011"),
        (clk => '1', rst => '0', cnt => "100"),
        (clk => '0', rst => '0', cnt => "100"),
        (clk => '1', rst => '0', cnt => "101"),
        (clk => '0', rst => '0', cnt => "101"),
        (clk => '1', rst => '0', cnt => "110"),
        (clk => '0', rst => '0', cnt => "110"),
        (clk => '1', rst => '0', cnt => "111"),
        (clk => '0', rst => '0', cnt => "111"),
        (clk => '1', rst => '0', cnt => "000"),
        (clk => '0', rst => '0', cnt => "000"),
        (clk => '1', rst => '0', cnt => "001"),
        (clk => '0', rst => '0', cnt => "001"),
        (clk => '1', rst => '0', cnt => "010"),
    -- reset the counter
        (clk => '0', rst => '1', cnt => "000"),
        (clk => '1', rst => '1', cnt => "000"),
        (clk => '0', rst => '0', cnt => "000"),
    -- clock the counter several times
        (clk => '1', rst => '0', cnt => "001"),
        (clk => '0', rst => '0', cnt => "001"),
        (clk => '1', rst => '0', cnt => "010"),
        (clk => '0', rst => '0', cnt => "010")
  );
begin
  -- instantiate unit under test
  uut: count port map(clk => clk, rst => rst, cnt => cnt);

  -- apply test vectors and check results
  verify: process
        variable vector: test_record;
        variable errors: boolean := false;
  begin
        for i in test_vectors'range loop
                -- get vector i
                vector := test_vectors(i);

                -- schedule vector i
                clk <= vector.clk;
                rst <= vector.rst;

                -- wait for circuit to settle
                wait for 20 ns;

                -- check output vectors
                if cnt /= vector.cnt then
                        assert false
                                report "cnt is wrong value ";
                        errors := true;
                end if;
        end loop;

        -- assert reports on false
        assert not errors
          report "Test vectors failed."
          severity note;
        assert errors
          report "Test vectors passed."
          severity note;
        wait;
  end process;
end;
