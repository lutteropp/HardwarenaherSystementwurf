library ieee;
use ieee.std_logic_1164.all;

entity in1_out1_myLEDtest is
  port ( 
    clk : in std_logic;
    led : out std_logic
  );
end in1_out1_myLEDtest;

architecture myLEDtest of in1_out1_myLEDtest is

  COMPONENT myDCM
    PORT(
	    CLKIN_IN : IN std_logic;
	    RST_IN : IN std_logic;          
	    CLKFX_OUT : OUT std_logic;
	    CLKIN_IBUFG_OUT : OUT std_logic;
	    CLK0_OUT : OUT std_logic;
	    LOCKED_OUT : OUT std_logic
	    );
    END COMPONENT;
  component in1_out1_counter
    port (clk : in std_logic; b : out std_logic);
  end component;

  signal s1, s2, s4, sreset : std_logic;
begin

  Inst_myDCM: myDCM PORT MAP(
		CLKIN_IN => s1,
		RST_IN => sreset,
		CLKFX_OUT => s2,
		CLKIN_IBUFG_OUT => open,
		CLK0_OUT => open,
		LOCKED_OUT => open
	);
  t1: in1_out1_counter port map (s2, s4);
  s1 <= clk;
  sreset <= '0';
  led <= s4;
end myLEDtest;