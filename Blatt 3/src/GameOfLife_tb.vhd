library ieee;
use ieee.std_logic_1164.all;

entity testbench is
  -- leer
end testbench;

architecture golbench of testbench is
component in5_out1_gol
  port(
    reset : in std_logic;
    enable : in std_logic;
    clk : in std_logic;
    richtung : in std_logic; 
    dip : in std_logic_vector(7 downto 0);
    led_belegung : out std_logic_vector(7 downto 0)
  );
end component;
signal s1, s2 : std_logic;
signal sigdip : std_logic_vector(7 downto 0) := "00000000";
begin
  t1: in5_out1_gol port map (clk => s1, reset => '0', enable => '1', richtung => s2, dip => sigdip);
  clockGenerator : process is 
  begin
    s1 <= '1';
    wait for 50 ns;
    s1 <= '0';
    wait for 50 ns;
  end process clockGenerator;
  
  directionChanger : process is 
  begin
    s2 <= '1';
    wait for 4000 ns;
    s2 <= '0';
    wait for 4000 ns;
  end process directionChanger;

  dipPresser : process is
  begin
    wait for 500 ns;
    sigdip(0) <= '1';
    wait for 500 ns;
    sigdip(1) <= '1';
    wait for 500 ns;
    sigdip(1) <= '0';
    wait for 500 ns;
    sigdip(0) <= '0';
    wait for 500 ns;
  end process dipPresser;

end golbench;