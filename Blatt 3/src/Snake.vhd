library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- bietet Konvertierungsfkt. integer zu std_logic_vector

entity in5_out1_snake is
  port ( 
    reset : in std_logic;
    enable : in std_logic;
    clk : in std_logic;
    richtung : in std_logic; -- 1 für vorwärts 0 für rückwärts
    dip : in std_logic_vector(7 downto 0);
    led_belegung : out std_logic_vector(7 downto 0)
  );
end in5_out1_snake;

architecture mysnake of in5_out1_snake is
constant INITIAL : std_logic_vector(7 downto 0) := "00000111";
constant ANZAHL : integer := 3;
signal laenge : integer := 3;
signal led_next : std_logic_vector(7 downto 0) := INITIAL;
  begin

  checkdip : process(reset, clk, dip) -- ermittelt die Länge der Snake
  variable dip_before : std_logic_vector(7 downto 0) := "00000000";
  variable laenge_neu : integer := 0;
  variable laenge_changed : std_logic := '0';
  begin
    if (reset = '1') then
      laenge <= 3;
      laenge_changed := '0';
      laenge_neu := 0;
      dip_before := "00000000";
    elsif (clk'event and clk = '1' and enable = '1') then
      for I in 0 to 7 loop
	if (dip(I) = '1') then
	    laenge_neu := laenge_neu + 1;
	end if;
	if (dip(I) = dip_before(I)) then
	else -- Schalteränderung
		laenge_changed := '1';
	end if;
      end loop;
      if (laenge_changed = '1') then
	if (laenge_neu > 0) then
	  laenge <= laenge_neu;
	end if;
      end if;
      laenge_changed := '0';
      laenge_neu := 0;
      dip_before := dip;
    end if;
  end process;

  psnake : process(reset,clk)
  variable led_belegung_help : std_logic_vector(7 downto 0) := INITIAL;
  variable stelle : integer := 0; -- position des hinterteils
  variable counter : integer := 0;

  function CALC_STELLE(vrichtung : std_logic; stellebefore : integer) return integer is
  variable newstelle : integer := 0;
  begin
    if (vrichtung = '1') then -- nach rechts
	if (stellebefore < 7) then
	    newstelle := stellebefore + 1;
	else
	    newstelle := 0;
	end if;
    else -- nach links
	if (stellebefore > 0) then
	    newstelle := stellebefore - 1;
	else
	    newstelle := 7;
	end if;
    end if;
    return newstelle;
  end CALC_STELLE;

  function CALC_SNAKE_POSITION(vstelle: integer; vlaenge: integer) return std_logic_vector is
  variable snake_pos : std_logic_vector(7 downto 0) := "00000000";
  begin
      for I in 0 to 15 loop
	if (I > vstelle - 1 and I < vstelle + vlaenge + 1) then
	  if (I < 8) then
	    snake_pos(I) := '1';
	  else
	    snake_pos(I - 8) := '1';
	  end if;
	end if;
      end loop;
      return snake_pos;
  end CALC_SNAKE_POSITION;

  begin
    if (reset = '1') then
      stelle := 0;
      led_belegung_help := INITIAL;
      led_next <= INITIAL;
      counter := 0;
    elsif (enable = '1' and clk'event and clk = '1') then
      if (counter < ANZAHL) then -- Blinken des Hinterns
	counter := counter + 1;
	if (richtung = '1') then -- stelle entspricht dem Hintern
	  led_next(stelle) <= not led_next(stelle);
	else -- stelle entspricht dem Kopf
	  if (stelle + laenge < 8) then
	    led_next(stelle + laenge) <= not led_next(stelle + laenge);
	  else
	    led_next(stelle + laenge - 8) <= not led_next(stelle + laenge - 8);
	  end if;
	end if;
      else -- Laufen
	counter := 0;
	stelle := CALC_STELLE(richtung, stelle);
	led_next <= CALC_SNAKE_POSITION(stelle, laenge);
      end if;
    end if;
  end process psnake;
  led_belegung <= led_next;
end mysnake;