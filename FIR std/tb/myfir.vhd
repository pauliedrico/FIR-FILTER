library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity myfir is
  generic
  (
    NBIT : integer := 8
  );
  port
  (
    VIN, RST_n, CLK : in std_logic;
    B0              : in std_logic_vector(NBIT - 1 downto 0);
    B1              : in std_logic_vector(NBIT - 1 downto 0);
    B2              : in std_logic_vector(NBIT - 1 downto 0);
    B3              : in std_logic_vector(NBIT - 1 downto 0);
    B4              : in std_logic_vector(NBIT - 1 downto 0);
    B5              : in std_logic_vector(NBIT - 1 downto 0);
    B6              : in std_logic_vector(NBIT - 1 downto 0);
    B7              : in std_logic_vector(NBIT - 1 downto 0);
    B8              : in std_logic_vector(NBIT - 1 downto 0);
    B9              : in std_logic_vector(NBIT - 1 downto 0);
    B10             : in std_logic_vector(NBIT - 1 downto 0);
    DIN             : in std_logic_vector(NBIT - 1 downto 0);
    DOUT            : out std_logic_vector(NBIT - 1 downto 0);
    VOUT            : out std_logic
  );
end myfir;

architecture beh of myfir is

  signal x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10 : signed(NBIT - 1 downto 0);
  signal b_0, b_1, b_2, b_3, b_4, b_5, b_6, b_7, b_8, b_9, b_10 : signed(NBIT - 1 downto 0);																						
  signal v_in                                  : std_logic;
  

begin
	
  process (CLK, RST_n)

    variable temp : signed(NBIT - 2 downto 0);

  begin
    if RST_n = '0' then
      x0         <= (others => '0');
      x1         <= (others => '0');
      x2         <= (others => '0');
      x3         <= (others => '0');
      x4         <= (others => '0');
      x5         <= (others => '0');
      x6         <= (others => '0');
      x7         <= (others => '0');
      x8         <= (others => '0');
      x9         <= (others => '0');
      x10        <= (others => '0');
	  b_0  <= (others => '0');
	  b_1  <= (others => '0');
	  b_2  <= (others => '0');
	  b_3  <= (others => '0');
	  b_4  <= (others => '0');
	  b_5  <= (others => '0');
	  b_6  <= (others => '0');
	  b_7  <= (others => '0');
	  b_8  <= (others => '0');
	  b_9  <= (others => '0');
	  b_10 <= (others => '0');
	  v_in <= '0';
      VOUT <= '0';	
	  DOUT <= (others => '0');
	 
    elsif CLK'event and CLK = '1' then
	  v_in <= VIN;
	  b_0  <= signed(B0);
	  b_1  <= signed(B1);
	  b_2  <= signed(B2);
	  b_3  <= signed(B3);
	  b_4  <= signed(B4);
	  b_5  <= signed(B5);
	  b_6  <= signed(B6);
	  b_7  <= signed(B7);
	  b_8  <= signed(B8);
	  b_9  <= signed(B9);
	  b_10 <= signed(B10);
	  VOUT <= v_in;
      if VIN = '1' then
        x0  <= signed(DIN);
        x1  <= x0;
        x2  <= x1;
        x3  <= x2;
        x4  <= x3;
        x5  <= x4;
        x6  <= x5;
        x7  <= x6;
        x8  <= x7;
        x9  <= x8;
        x10 <= x9;
 
      end if;
	  -- eseguo operazioni troncando moltiplicazione (THD circa -30dB)
	  temp := "*"(x10, b_10)(14 downto 8) +
				"*"(x9 , b_9)(14 downto 8) +
				"*"(x8 , b_8)(14 downto 8) +
				"*"(x7 , b_7)(14 downto 8) +
				"*"(x6 , b_6)(14 downto 8) +
				"*"(x5 , b_5)(14 downto 8) +
				"*"(x4 , b_4)(14 downto 8) +
				"*"(x3 , b_3)(14 downto 8) +
				"*"(x2 , b_2)(14 downto 8) +
				"*"(x1 , b_1)(14 downto 8) +
				"*"(x0 , b_0)(14 downto 8);	
	  DOUT <= std_logic_vector(temp) & '0';
    end if;

  end process;
end beh;