library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity myfir_unfolded is
  generic
  (
    NBIT : integer := 8
  );
  port
  (
    VIN, RST_n, CLK 				: in std_logic;
    B0              				: in std_logic_vector(NBIT - 1 downto 0);
    B1              				: in std_logic_vector(NBIT - 1 downto 0);
    B2              				: in std_logic_vector(NBIT - 1 downto 0);
    B3              				: in std_logic_vector(NBIT - 1 downto 0);
    B4              				: in std_logic_vector(NBIT - 1 downto 0);
    B5              				: in std_logic_vector(NBIT - 1 downto 0);
    B6              				: in std_logic_vector(NBIT - 1 downto 0);
    B7              				: in std_logic_vector(NBIT - 1 downto 0);
    B8              				: in std_logic_vector(NBIT - 1 downto 0);
    B9              				: in std_logic_vector(NBIT - 1 downto 0);
    B10             				: in std_logic_vector(NBIT - 1 downto 0);
    DIN3k,DIN3k1,DIN3k2             : in std_logic_vector(NBIT - 1 downto 0);
    DOUT3k, DOUT3k1,DOUT3k2         : out std_logic_vector(NBIT - 1 downto 0);
    VOUT            				: out std_logic
  );
end myfir_unfolded;

architecture beh of myfir_unfolded is

  signal x3k2, x3k1, x3k, x3k_1, x3k_2, x3k_3, x3k_4, x3k_5, x3k_6, x3k_7, x3k_8, x3k_9, x3k_10 : signed(NBIT - 1 downto 0);
  signal b_0, b_1, b_2, b_3, b_4, b_5, b_6, b_7, b_8, b_9, b_10 : signed(NBIT - 1 downto 0);																						
  signal v_in : std_logic;
  

begin
	
  process (CLK, RST_n)

    variable temp : signed(NBIT - 2 downto 0);
	variable tmp3k, tmp3k1, tmp3k2 : signed(NBIT - 2 downto 0);

  begin
    if RST_n = '0' then
	  x3k2         	<= (others => '0');
	  x3k1         	<= (others => '0');
      x3k         	<= (others => '0');
      x3k_1         <= (others => '0');
      x3k_2         <= (others => '0');
      x3k_3         <= (others => '0');
      x3k_4         <= (others => '0');
      x3k_5         <= (others => '0');
      x3k_6         <= (others => '0');
      x3k_7         <= (others => '0');
      x3k_8         <= (others => '0');
	  x3k_9         <= (others => '0');
	  x3k_10        <= (others => '0');
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
	  DOUT3k <= (others => '0');
	  DOUT3k1 <= (others => '0');
	  DOUT3k2 <= (others => '0');
	 
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
        x3k  <= signed(DIN3k);
		x3k1 <= signed(DIN3k1);
		x3k2 <= signed(DIN3k2);
		x3k_3 <= x3k;
		x3k_6 <= x3k_3;
		x3k_9 <= x3k_6;
		x3k_2 <= x3k1;
		x3k_5 <= x3k_2;
		x3k_8 <= x3k_5;
		x3k_1 <= x3k2;
		x3k_4 <= x3k_1;
		x3k_7 <= x3k_4;
		x3k_10 <= x3k_7;
 
      end if;
	  -- eseguo operazioni troncando moltiplicazione (THD circa -30dB)
	  tmp3k := 	"*"(x3k, b_0)(14 downto 8) + 
				"*"(x3k_1, b_1)(14 downto 8) +
				"*"(x3k_2, b_2)(14 downto 8) +
				"*"(x3k_3, b_3)(14 downto 8) +
				"*"(x3k_4, b_4)(14 downto 8) +
				"*"(x3k_5, b_5)(14 downto 8) +
				"*"(x3k_6, b_6)(14 downto 8) +
				"*"(x3k_7, b_7)(14 downto 8) +
				"*"(x3k_8, b_8)(14 downto 8) +
				"*"(x3k_9, b_9)(14 downto 8) +
				"*"(x3k_10, b_10)(14 downto 8);
				
	tmp3k1 := 	"*"(x3k1, b_0)(14 downto 8) + 
				"*"(x3k, b_1)(14 downto 8) +
				"*"(x3k_1, b_2)(14 downto 8) +
				"*"(x3k_2, b_3)(14 downto 8) +
				"*"(x3k_3, b_4)(14 downto 8) +
				"*"(x3k_4, b_5)(14 downto 8) +
				"*"(x3k_5, b_6)(14 downto 8) +
				"*"(x3k_6, b_7)(14 downto 8) +
				"*"(x3k_7, b_8)(14 downto 8) +
				"*"(x3k_8, b_9)(14 downto 8) +
				"*"(x3k_9, b_10)(14 downto 8);
				
	tmp3k2 := 	"*"(x3k2, b_0)(14 downto 8) + 
				"*"(x3k1, b_1)(14 downto 8) +
				"*"(x3k, b_2)(14 downto 8) +
				"*"(x3k_1, b_3)(14 downto 8) +
				"*"(x3k_2, b_4)(14 downto 8) +
				"*"(x3k_3, b_5)(14 downto 8) +
				"*"(x3k_4, b_6)(14 downto 8) +
				"*"(x3k_5, b_7)(14 downto 8) +
				"*"(x3k_6, b_8)(14 downto 8) +
				"*"(x3k_7, b_9)(14 downto 8) +
				"*"(x3k_8, b_10)(14 downto 8);
	if v_in = '1' then
		DOUT3k 	<= std_logic_vector(tmp3k) & '0';
		DOUT3k1 <= std_logic_vector(tmp3k1) & '0';
		DOUT3k2 <= std_logic_vector(tmp3k2) & '0';
	end if;
    end if;

  end process;
end beh;
