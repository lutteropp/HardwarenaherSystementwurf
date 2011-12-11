library ieee;
use ieee.std_logic_1164.all;

entity in3_out1_richtung is
  port ( 
    clk : in std_logic;
    s_richtung : in std_logic;
    reset : in std_logic;
    richtung : out std_logic
  );
end in3_out1_richtung;

architecture myrichtung of in3_out1_richtung is
  signal vrichtung : std_logic := '1';
begin
  prichtung : process(clk, s_richtung, reset)
  variable s_richtung_pressed : std_logic := '0';
  begin
   if (reset = '1') then
    vrichtung <= '1';
   elsif (clk'event and clk='1') then
      if (s_richtung_pressed = '0' and s_richtung='1') then
         vrichtung <= not vrichtung;
			s_richtung_pressed := '1';
		elsif (s_richtung = '0' and s_richtung_pressed='1') then
			s_richtung_pressed := '0';
      end if;
   end if;
  end process prichtung;
  richtung <= vrichtung;
end myrichtung;