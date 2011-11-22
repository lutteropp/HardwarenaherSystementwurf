library ieee;
use ieee.std_logic_1164.all;

entity in1_out1_counter is
  port ( 
    clk : in std_logic;
    b : out std_logic
  );
end in1_out1_counter;

architecture mycounter of in1_out1_counter is
constant ANZAHL : integer := 20000000;
signal counter : integer := 0;
signal outsig : std_logic := '0';
begin
  pcounter : process(clk, counter, outsig)
  begin
   if (clk'event and clk='1') then
    if (counter >= ANZAHL-1) then
      outsig <= not outsig;
      counter <= 0;
    else 
      counter <= counter + 1;
    end if;
   end if;
   b <= outsig;
  end process pcounter;
end mycounter;