library ieee;
use ieee.std_logic_1164.all;

entity testbench is
  -- leer
end testbench;

architecture geschwbench of testbench is
component in4_out1_geschw
  port ( 
    schneller : in std_logic;
    langsamer : in std_logic;
    reset : in std_logic;
    clk : in std_logic;
    b : out std_logic
  );
end component;
signal s1, s_schneller, s_langsamer, sreset : std_logic;
begin
  t1: in4_out1_geschw port map (clk => s1, reset => sreset, schneller => s_schneller, langsamer => s_langsamer);
  clockGenerator : process is 
  begin
    s1 <= '1';
    wait for 50 ns;
    s1 <= '0';
    wait for 50 ns;
  end process clockGenerator;
  
  geschwChanger : process is 
  begin
    s_langsamer <= '0';
    s_schneller <= '0';
    wait for 200 ns;
    s_schneller <= '1';
    wait for 200 ns;
    s_schneller <= '0';
    wait for 200 ns;
    s_langsamer <= '1';
    wait for 200 ns;
    s_langsamer <= '0';
    wait for 200 ns;
    s_schneller <= '1';
    s_langsamer <= '1';
    wait for 200 ns;
  end process geschwChanger;

  resetter : process is
  begin
    sreset <= '0';
    wait for 3000 ns;
    sreset <= '1';
    wait for 3000 ns;
  end process resetter;

end geschwbench;