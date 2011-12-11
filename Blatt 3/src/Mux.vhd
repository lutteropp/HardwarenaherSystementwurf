library ieee;
use ieee.std_logic_1164.all;

entity in5_out1_mux is
  port ( 
    gol : in std_logic_vector(7 downto 0);
    gray : in std_logic_vector(7 downto 0);
    snake : in std_logic_vector(7 downto 0);
    clk : in std_logic;
    modus : in integer;
    ledout : out std_logic_vector(7 downto 0)
  );
end in5_out1_mux;

architecture mymux of in5_out1_mux is
signal led : std_logic_vector(7 downto 0) := "00000000";
begin
  pmux : process(clk)
  begin
   if (clk'event and clk='1') then
      case modus is
	when 1      => led <= gray;
	when 2      => led <= snake;
	when 3      => led <= gol;
	when others => led <= "00000000";
      end case;
   end if;
  end process pmux;
  ledout <= led;
end mymux;