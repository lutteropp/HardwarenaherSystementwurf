library ieee;
use ieee.std_logic_1164.all;

entity in2_out1_mynand is
  port ( 
    a : in std_logic;
    b : in std_logic;
    c : out std_logic
  );
end in2_out1_mynand;

architecture mynand of in2_out1_mynand is
  component in2_out1_myand
    port (a : in std_logic; b : in std_logic; c : out std_logic);
  end component;
  component in1_out1_mynot
    port (a : in std_logic; b : out std_logic);
  end component;
  signal s1, s2, s3, s4 : std_logic;

  for t1: in2_out1_myand use entity work.in2_out1_myand(myand);
  for t2: in1_out1_mynot use entity work.in1_out1_mynot(mynot);

begin
  t1: in2_out1_myand port map (s1, s2, s3);
  t2: in1_out1_mynot port map (s3, s4);
  s1 <= a;
  s2 <= b;
  c <= s4;
end mynand;