library ieee;
use ieee.std_logic_1164.all;

entity testbench is
  -- leer
end testbench;

architecture lauflichtbench of testbench is
component in7_out1_mylauflicht is
  port ( 
    clk : in std_logic;
    s_reset : in std_logic;
    s_modus : in std_logic;
    s_richtung : in std_logic;
    s_slower : in std_logic;
    s_faster : in std_logic;
    s_dip : in std_logic_vector(7 downto 0);
    led_out : out std_logic_vector(7 downto 0)
  );
end component;
signal s1 : std_logic;
signal sigreset, sigmodus, sig_richtung, sigslower, sigfaster : std_logic := '1';
signal sigdip : std_logic_vector(7 downto 0) := "00000000";
begin
  t1: in7_out1_mylauflicht port map (clk => s1, s_reset => sigreset, s_modus => sigmodus, s_richtung => sig_richtung,
    s_slower => sigslower, s_faster => sigfaster, s_dip => sigdip);

  clockGenerator : process is 
  begin
    s1 <= '1';
    wait for 50 ns;
    s1 <= '0';
    wait for 50 ns;
  end process clockGenerator;

  modusChanger : process is 
  begin
    sigmodus <= '0';
    wait for 200 ns;
    sigmodus <= '1';
    wait for 200 ns;
  end process modusChanger;

  resetter : process is
  begin
    sigreset <= '0';
    wait for 8000 ns;
    sigreset <= '1';
    wait for 8000 ns;
  end process resetter;

  geschwChanger : process is 
  begin
    sigslower <= '0';
    sigfaster <= '0';
    wait for 200 ns;
    sigfaster <= '1';
    wait for 200 ns;
    sigfaster <= '0';
    wait for 200 ns;
    sigslower <= '1';
    wait for 200 ns;
    sigslower <= '0';
    wait for 200 ns;
    sigfaster <= '1';
    sigslower <= '1';
    wait for 200 ns;
  end process geschwChanger;

  richtungChanger : process is 
  begin
    sig_richtung <= '0';
    wait for 200 ns;
    sig_richtung <= '1';
    wait for 200 ns;
  end process richtungChanger;
end lauflichtbench;