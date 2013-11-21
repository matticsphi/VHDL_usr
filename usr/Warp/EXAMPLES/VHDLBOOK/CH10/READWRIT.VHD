-- Oveloaded read and write procedures

library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

package myio is
  procedure Read (L: inout Line; Value: out std_logic; Good: out boolean);
  procedure Read (L: inout Line; Value: out std_logic);
  procedure Read (L: inout Line; Value: out std_logic_vector; Good: out boolean);
  procedure Read (L: inout Line; Value: out std_logic_vector);
  procedure Write (L: inout Line; Value: in std_logic;
                        Justified:in Side := Right; Field: in Width := 0);
  procedure Write (L: inout Line; Value: in std_logic_vector;
                        Justified:in Side := Right; Field: in Width := 0);
  type std_logic_chars is array (character) of std_logic;
  constant to_stdlogic: std_logic_chars :=
        ('U' => 'U', 'X' => 'X', '0' => '0', '1' => '1', 'Z' => 'Z',
         'W' => 'W', 'L' => 'L', 'H' => 'H', '-' => '-', others => 'X');
  type character_chars is array (std_logic) of character;
  constant to_character: character_chars :=
        ('U' => 'U', 'X' => 'X', '0' => '0', '1' => '1', 'Z' => 'Z',
         'W' => 'W', 'L' => 'L', 'H' => 'H', '-' => '-');
end myio;

package body myio is

  procedure Read (L: inout Line; Value: out std_logic; Good: out boolean) is
    variable temp: character;
    variable good_character: boolean;
  begin
        read(L, temp, good_character);
        if good_character = true then
            good := true;
            value := to_stdlogic(temp);
        else
          good := false;
        end if;
  end Read;

  procedure Read (L: inout Line; Value: out std_logic) is
    variable temp: character;
    variable good_character: boolean;
  begin
        read(L, temp, good_character);
        if good_character = true then
          value := to_stdlogic(temp);
        end if;
  end Read;

  procedure Read (L: inout Line; Value: out std_logic_vector; Good: out boolean) is
    variable temp: string(value'range);
    variable good_string: boolean;
  begin
        read(L, temp, good_string);
        if good_string = true then
            good := true;
            for i in temp'range loop
              value(i) := to_stdlogic(temp(i));
            end loop;
        else
          good := false;
        end if;
  end Read;
  procedure Read (L: inout Line; Value: out std_logic_vector) is
    variable temp: string(value'range);
    variable good_string: boolean;
  begin
        read(L, temp, good_string);
        if good_string = true then
          for i in temp'range loop
              value(i) := to_stdlogic(temp(i));
          end loop;
        end if;
  end Read;

 procedure Write (L: inout Line; Value: in std_logic;
                        Justified:in Side := Right; Field: in Width := 0) is
    variable write_value: character;
  begin
        write_value := to_character(value);
        write(L, write_value, Justified, Field);
  end Write;

 procedure Write (L: inout Line; Value: in std_logic_vector;
                        Justified:in Side := Right; Field: in Width := 0) is
    variable write_value: string(value'range);
  begin
        for i in value'range loop
          write_value(i) := to_character(value(i));
        end loop;
        write(L, write_value, Justified, Field);
  end Write;

end myio;
