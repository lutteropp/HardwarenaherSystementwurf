library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- bietet Konvertierungsfkt. integer zu std_logic_vector

entity in5_out1_gray is
  port ( 
    reset : in std_logic;
    enable : in std_logic;
    clk : in std_logic;
    richtung : in std_logic; -- 1 für hochzählen 0 für runterzählen
    dip : in std_logic_vector(7 downto 0);
    led_belegung : out std_logic_vector(7 downto 0)
  );
end in5_out1_gray;

architecture mygray of in5_out1_gray is
  begin
  pgray : process(reset,clk)
  variable led_belegung_help : std_logic_vector(7 downto 0) := "00000000";
  variable zaehler_help_help : std_logic_vector(7 downto 0) := "00000000";
  variable zaehler, zaehler_help : integer := 0;
  variable dip_before : std_logic_vector(7 downto 0) := "00000000";
  variable dip_changed, dip_checked : std_logic := '0';

  begin
	if (reset = '1') then
		led_belegung_help := "00000000";
      dip_before := "00000000";
      dip_changed := '0';
      dip_checked := '0';
    elsif (clk'event and clk = '1' and enable='1') then
		for I in 0 to 7 loop
			if (dip(I) = dip_before(I)) then
				dip_checked := '1';
			else
				dip_changed := '1';
				dip_checked := '1';
			end if;
		end loop;
		if (dip_checked = '1') then
			dip_before := dip;
			dip_checked := '0';
			if (dip_changed = '1') then
				led_belegung_help := dip;
				dip_changed := '0';
			else
				if (richtung = '1') then
					if (zaehler < 255) then
						zaehler := zaehler + 1;
					else
						zaehler := 0;
					end if;
				else
					if (zaehler > 0) then
						zaehler := zaehler - 1;
					else
						zaehler := 255;
					end if;
				end if;
				zaehler_help := zaehler / 2;
				led_belegung_help := std_logic_vector(to_unsigned(zaehler, 8)); -- konvertieren
				zaehler_help_help := std_logic_vector(to_unsigned(zaehler_help, 8)); -- konvertieren
				led_belegung_help := led_belegung_help xor zaehler_help_help;
			end if;
		end if;
	end if;
	led_belegung <= led_belegung_help;
  end process pgray;
end mygray;