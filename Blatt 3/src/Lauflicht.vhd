library ieee;
use ieee.std_logic_1164.all;

entity in7_out1_mylauflicht is
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
end in7_out1_mylauflicht;

architecture mylauflicht of in7_out1_mylauflicht is
  component in3_out1_richtung
    port (clk : in std_logic;
    s_richtung : in std_logic;
    reset : in std_logic;
    richtung : out std_logic);
  end component;
  component in3_out4_modus
    port ( clk : in std_logic;
    s_modus : in std_logic;
    reset : in std_logic;
    enableSnake : out std_logic;
    enableGray : out std_logic;
    enableGol : out std_logic;
    modus : out integer);
  end component;
  component in4_out1_geschw
    port (schneller : in std_logic;
    langsamer : in std_logic;
    reset : in std_logic;
    clk : in std_logic;
    b : out std_logic);
  end component;
  component in5_out1_mux
    port (gol : in std_logic_vector(7 downto 0);
    gray : in std_logic_vector(7 downto 0);
    snake : in std_logic_vector(7 downto 0);
    clk : in std_logic;
    modus : in integer;
    ledout : out std_logic_vector(7 downto 0));
  end component;
  component in5_out1_snake
    port (reset : in std_logic;
    enable : in std_logic;
    clk : in std_logic;
    richtung : in std_logic; -- 1 fr vorw�ts 0 fr rckw�ts
    dip : in std_logic_vector(7 downto 0);
    led_belegung : out std_logic_vector(7 downto 0));
  end component;
 component in5_out1_gol
    port (reset : in std_logic;
    enable : in std_logic;
    clk : in std_logic;
    richtung : in std_logic; -- 1 fr vorw�ts 0 fr rckw�ts
    dip : in std_logic_vector(7 downto 0);
    led_belegung : out std_logic_vector(7 downto 0));
  end component;
 component in5_out1_gray
    port (reset : in std_logic;
    enable : in std_logic;
    clk : in std_logic;
    richtung : in std_logic; -- 1 fr vorw�ts 0 fr rckw�ts
    dip : in std_logic_vector(7 downto 0);
    led_belegung : out std_logic_vector(7 downto 0));
  end component;
  component myDCM
    port(CLKIN_IN        : in    std_logic; 
          RST_IN          : in    std_logic; 
          CLKFX_OUT       : out   std_logic; 
          CLKIN_IBUFG_OUT : out   std_logic; 
          CLK0_OUT        : out   std_logic; 
          LOCKED_OUT      : out   std_logic);
  end component;
  signal clksig, s_resetsig, s_modussig, s_richtungsig, s_slowersig, dcmsig : std_logic;
  signal s_fastersig, richtungsig, bsig, enableSnakesig, enableGraysig, enableGolsig : std_logic;
  signal snakeledsig, golledsig, grayledsig, ledoutsig, dipsig : std_logic_vector(7 downto 0);
  signal modussig : integer;

  for t1: in3_out1_richtung use entity work.in3_out1_richtung(myrichtung);
  for t2: in3_out4_modus use entity work.in3_out4_modus(mymodus);
  for t3: in4_out1_geschw use entity work.in4_out1_geschw(mygeschw);
  for t4: in5_out1_mux use entity work.in5_out1_mux(mymux);
  for t5: in5_out1_snake use entity work.in5_out1_snake(mysnake);
  for t6: in5_out1_gol use entity work.in5_out1_gol(mygol);
  for t7: in5_out1_gray use entity work.in5_out1_gray(mygray);
  for t8: myDCM use entity work.myDCM(BEHAVIORAL);

begin
  t1: in3_out1_richtung port map (dcmsig, s_richtungsig, s_resetsig, richtungsig);
  t2: in3_out4_modus port map (dcmsig, s_modussig, s_resetsig, enableSnakesig, enableGraysig, enableGolsig, modussig);
  t3: in4_out1_geschw port map (s_fastersig, s_slowersig, s_resetsig, dcmsig, bsig);
  t5: in5_out1_snake port map (s_resetsig, enableSnakesig, bsig, richtungsig, dipsig, snakeledsig);
  t6: in5_out1_gol port map (s_resetsig, enableGolsig, bsig, richtungsig, dipsig, golledsig);
  t7: in5_out1_gray port map (s_resetsig, enableGraysig, bsig, richtungsig, dipsig, grayledsig);
  t4: in5_out1_mux port map (golledsig, grayledsig, snakeledsig, bsig, modussig, ledoutsig);
  t8: myDCM port map(CLKIN_IN => clksig,
		RST_IN => '0',
		CLKFX_OUT => dcmsig,
		CLKIN_IBUFG_OUT => open,
		CLK0_OUT => open,
		LOCKED_OUT => open);

  clksig <= clk;
  s_resetsig <= s_reset;
  s_modussig <= s_modus;
  s_richtungsig <= s_richtung;
  s_slowersig <= s_slower;
  s_fastersig <= s_faster;
  dipsig <= s_dip;
  led_out <= ledoutsig;
end mylauflicht;