library ieee;
use ieee.std_logic_1164.all;

entity in3_out4_modus is
  port ( 
    clk : in std_logic;
    s_modus : in std_logic;
    reset : in std_logic;
    enableSnake : out std_logic;
    enableGray : out std_logic;
    enableGol : out std_logic;
    modus : out integer
  );
end in3_out4_modus;

architecture mymodus of in3_out4_modus is
  signal vmodus : integer := 1;
  signal vsnake : std_logic := '0';
  signal vgray : std_logic := '1';
  signal vgol : std_logic := '0';
begin
  pmodus : process(clk, s_modus, reset)
  variable s_modus_pressed : std_logic := '0';
  begin
   if (reset = '1') then
    vmodus <= 1;
	elsif (clk'event and clk = '1') then
		if (s_modus_pressed = '0' and s_modus='1') then
			s_modus_pressed := '1';
			if (vmodus = 1) then
				vmodus <= 2;
				vsnake <= '1';
				vgol <= '0';
				vgray <= '0';
			elsif (vmodus = 2) then
				vmodus <= 3;
				vsnake <= '0';
				vgol <= '1';
				vgray <= '0';
			elsif (vmodus = 3) then
				vmodus <= 1;
				vsnake <= '0';
				vgol <= '0';
				vgray <= '1';
			end if;
		elsif (s_modus = '0' and s_modus_pressed = '1') then
			s_modus_pressed := '0';
		end if;
	end if;
  end process pmodus;
  modus <= vmodus;
  enableSnake <= vsnake;
  enableGol <= vgol;
  enableGray <= vgray;
end mymodus;