library ieee;
use ieee.std_logic_1164.all;

entity testbench is
  -- leer
end testbench;

architecture richtungbench of testbench is
component in3_out1_richtung is
  port ( 
    clk : in std_logic;
    s_richtung : in std_logic;
    reset : in std_logic;
    richtung : out std_logic
  );
end component;
signal s1, sig_richtung, sreset : std_logic;
begin
  t1: in3_out1_richtung port map (clk => s1, reset => sreset, s_richtung => sig_richtung);
  clockGenerator : process is 
  begin
    s1 <= '1';
    wait for 50 ns;
    s1 <= '0';
    wait for 50 ns;
  end process clockGenerator;
  
  richtungChanger : process is 
  begin
    sig_richtung <= '0';
    wait for 200 ns;
    sig_richtung <= '1';
    wait for 200 ns;
  end process richtungChanger;

  resetter : process is
  begin
    sreset <= '0';
    wait for 3000 ns;
    sreset <= '1';
    wait for 3000 ns;
  end process resetter;

end richtungbench;