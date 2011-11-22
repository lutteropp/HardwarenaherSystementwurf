library ieee;
use ieee.std_logic_1164.all;

entity testbench is
  -- leer
end testbench;

architecture counterbench of testbench is
component in1_out1_counter
  port (clk: in std_logic; b : out std_logic);
end component;
signal s1, s2 : std_logic;
for t1: in1_out1_counter use entity work.in1_out1_counter(mycounter);
begin
  t1: in1_out1_counter port map (clk => s1, b => s2);
  process is 
  begin
    s1 <= '1';
    wait for 50 ns;
    s1 <= '0';
    wait for 50 ns;
  end process;
end counterbench;