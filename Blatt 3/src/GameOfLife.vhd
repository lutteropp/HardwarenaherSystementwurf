library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- bietet Konvertierungsfkt. integer zu std_logic_vector

entity in5_out1_gol is
  port ( 
    reset : in std_logic;
    enable : in std_logic;
    clk : in std_logic;
    richtung : in std_logic; -- 1 für hochzählen 0 für runterzählen
    dip : in std_logic_vector(7 downto 0);
    led_belegung : out std_logic_vector(7 downto 0)
  );
end in5_out1_gol;

architecture mygol of in5_out1_gol is
constant INITIAL : std_logic_vector(7 downto 0) := "01101011";
constant ANZAHL : integer := 5;
signal counter : integer := 0;
  begin
  pgol : process(reset,clk)
  variable led_belegung_help : std_logic_vector(7 downto 0) := INITIAL;
  variable led_next : std_logic_vector(7 downto 0) := INITIAL;
  variable dip_before : std_logic_vector(7 downto 0) := "00000000";
  variable dip_changed, dip_checked : std_logic := '0';

  begin
		if (reset = '1') then
			led_belegung_help := INITIAL;
			counter <= 0;
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
					led_next := dip;
					dip_changed := '0';
				elsif (counter >= ANZAHL-1) then
					if (richtung = '1') then
						for I in 1 to 6 loop
							led_next(i) := led_belegung_help(i-1) xor led_belegung_help(i+1);
						end loop;
						led_next(7) := led_belegung_help(6) xor led_belegung_help(0);
						led_next(0) := led_belegung_help(7) xor led_belegung_help(1);
					else
						for I in 1 to 6 loop
							led_next(i) := not (led_belegung_help(i-1) xor led_belegung_help(i+1));
						end loop;
						led_next(7) := not (led_belegung_help(6) xor led_belegung_help(0));	
						led_next(0) := not (led_belegung_help(7) xor led_belegung_help(1));
					end if;
					counter <= 0;
				else -- counter < ANZAHL - 1 
					counter <= counter + 1;
				end if;
				led_belegung_help := led_next;
			end if;
		end if;
		led_belegung <= led_belegung_help;
  end process pgol;
end mygol;