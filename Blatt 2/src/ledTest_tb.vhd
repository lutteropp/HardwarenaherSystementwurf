library ieee;
use ieee.std_logic_1164.all;

entity testbench is
  -- leer
end testbench;

architecture ledbench of testbench is
component in1_out1_myLEDtest
  port(clk : in std_logic;led : out std_logic);
end component;
signal s1 : std_logic;
begin
  t1: in1_out1_myLEDtest port map (clk => s1);
  clockGenerator : process is 
  begin
    s1 <= '1';
    wait for 50 ns;
    s1 <= '0';
    wait for 50 ns;
  end process clockGenerator;
end ledbench;