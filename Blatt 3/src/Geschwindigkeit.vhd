library ieee;
use ieee.std_logic_1164.all;

entity in4_out1_geschw is
  port ( 
    schneller : in std_logic;
    langsamer : in std_logic;
    reset : in std_logic;
    clk : in std_logic;
    b : out std_logic
  );
end in4_out1_geschw;

architecture mygeschw of in4_out1_geschw is
signal anzahl : integer := 20000000;
signal counter : integer := 0;
signal outsig : std_logic := '0';
begin
  pgeschw : process(clk, reset, langsamer, schneller, anzahl, outsig)
  variable schneller_pressed, langsamer_pressed : std_logic := '0';
  begin
   if (reset = '1') then
     anzahl <= 20000000;

   else
      if (langsamer = '1' and schneller = '1') then
	  -- do nothing
      else -- nur ein button gedrückt
	  if (langsamer = '1' and langsamer_pressed = '0') then
	      anzahl <= anzahl + 2000000;
	      langsamer_pressed := '1';
	  elsif (langsamer = '0' and langsamer_pressed = '1') then
	      langsamer_pressed := '0';
	  end if;
	  if (schneller = '1' and schneller_pressed = '0') then
	      if (anzahl > 2000000) then
		anzahl <= anzahl - 2000000;
	      else 
	      anzahl <= 2000000;
	      end if;
	      schneller_pressed := '1';
	  elsif (schneller = '0' and schneller_pressed = '1') then
	      schneller_pressed := '0';
	  end if;
      end if;

      if (clk'event and clk='1') then
	if (counter >= anzahl-1) then
	  outsig <= not outsig;
	  counter <= 0;
	else 
	  counter <= counter + 1;
	end if;
      end if;
   end if;
   b <= outsig;
  end process pgeschw;
end mygeschw;