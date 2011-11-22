library ieee;
use ieee.std_logic_1164.all;

entity testbench is
  -- leer
end testbench;

architecture mynandbench of testbench is
component in2_out1_mynand
  port (a: in std_logic; b : in std_logic; c : out std_logic);
end component;
signal s1, s2, s3 : std_logic;
for t1: in2_out1_mynand use entity work.in2_out1_mynand(mynand);
begin
  t1: in2_out1 port map (a => s1, b => s2, c => s3);
  process is 
  begin
    s1 <= '1';
    s2 <= '1';
    wait for 50 ns;
    s1 <= '1';
    s2 <= '0';
    wait for 50 ns;
    s1 <= '0';
    s2 <= '1';
    wait for 50 ns;
    s1 <= '0';
    s2 <= '0';
    wait for 50 ns;
  end process;
end mynandbench;