library ieee;
use ieee.std_logic_1164.all;

entity testbench is
  -- leer
end testbench;

architecture modusbench of testbench is
component in3_out4_modus is
  port ( 
    clk : in std_logic;
    s_modus : in std_logic;
    reset : in std_logic;
    enableSnake : out std_logic;
    enableGray : out std_logic;
    enableGol : out std_logic;
    modus : out integer
  );
end component;
signal s1, sig_modus, sreset : std_logic;
begin
  t1: in3_out4_modus port map (clk => s1, reset => sreset, s_modus => sig_modus);
  clockGenerator : process is 
  begin
    s1 <= '1';
    wait for 50 ns;
    s1 <= '0';
    wait for 50 ns;
  end process clockGenerator;
  
  modusChanger : process is 
  begin
    sig_modus <= '0';
    wait for 200 ns;
    sig_modus <= '1';
    wait for 200 ns;
  end process modusChanger;

  resetter : process is
  begin
    sreset <= '0';
    wait for 3000 ns;
    sreset <= '1';
    wait for 3000 ns;
  end process resetter;

end modusbench;