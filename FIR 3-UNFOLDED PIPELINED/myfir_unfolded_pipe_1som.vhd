library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity myfir_unfolded_pipe_1som is
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
end myfir_unfolded_pipe_1som;

architecture beh of myfir_unfolded_pipe_1som is

  signal x3k2, x3k1, x3k, x3k_1, x3k_2, x3k_3, x3k_4, x3k_5, x3k_6, x3k_7, x3k_8, x3k_9, x3k_10 : signed(NBIT - 1 downto 0);
  signal b_0, b_1, b_2, b_3, b_4, b_5, b_6, b_7, b_8, b_9, b_10 : signed(NBIT - 1 downto 0);																						
  signal v_in, v_in_pipe1, v_in_pipe2, v_in_pipe3, v_in_pipe4, v_in_pipe5, v_in_pipe6, v_in_pipe7, v_in_pipe8, v_in_pipe9 : std_logic;
  signal reg_pipe1, reg_pipe2, reg_pipe3, reg_pipe4, reg_pipe5, reg_pipe6, reg_pipe7, reg_pipe8, reg_pipe9,
		 reg_pipe1_1, reg_pipe1_2, reg_pipe1_3, reg_pipe1_4, reg_pipe1_5, reg_pipe1_6, reg_pipe1_7, reg_pipe1_8, reg_pipe1_9,
		 reg_pipe2_1, reg_pipe2_2, reg_pipe2_3, reg_pipe2_4, reg_pipe2_5, reg_pipe2_6, reg_pipe2_7, reg_pipe2_8, reg_pipe2_9: signed(NBIT - 1 downto 0);
  signal tmp_pipe1, tmp_pipe2, tmp_pipe3, tmp_pipe4, tmp_pipe5, tmp_pipe6, tmp_pipe7, tmp_pipe8, tmp_pipe9,
		 tmp_pipe1_1, tmp_pipe1_2, tmp_pipe1_3, tmp_pipe1_4, tmp_pipe1_5, tmp_pipe1_6, tmp_pipe1_7, tmp_pipe1_8, tmp_pipe1_9,
		 tmp_pipe2_1, tmp_pipe2_2, tmp_pipe2_3, tmp_pipe2_4, tmp_pipe2_5, tmp_pipe2_6, tmp_pipe2_7, tmp_pipe2_8, tmp_pipe2_9 : signed(NBIT - 2 downto 0);

begin
	
  process (CLK, RST_n)

	variable tmp3k_s1, tmp3k_s2, tmp3k_s3, tmp3k_s4, tmp3k_s5, tmp3k_s6, tmp3k_s7, tmp3k_s8, tmp3k_s9, tmp3k_s10,
			 tmp3k1_s1, tmp3k1_s2, tmp3k1_s3, tmp3k1_s4, tmp3k1_s5, tmp3k1_s6, tmp3k1_s7, tmp3k1_s8, tmp3k1_s9, tmp3k1_s10,
			 tmp3k2_s1, tmp3k2_s2, tmp3k2_s3, tmp3k2_s4, tmp3k2_s5, tmp3k2_s6, tmp3k2_s7, tmp3k2_s8, tmp3k2_s9, tmp3k2_s10 : signed(NBIT - 2 downto 0);

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
	  reg_pipe1 <= (others => '0'); reg_pipe1_1 <= (others => '0'); reg_pipe2_1 <= (others => '0');
	  reg_pipe2 <= (others => '0'); reg_pipe1_2 <= (others => '0'); reg_pipe2_2 <= (others => '0');
	  reg_pipe3 <= (others => '0'); reg_pipe1_3 <= (others => '0'); reg_pipe2_3 <= (others => '0');
	  reg_pipe4 <= (others => '0'); reg_pipe1_4 <= (others => '0'); reg_pipe2_4 <= (others => '0');
	  reg_pipe5 <= (others => '0'); reg_pipe1_5 <= (others => '0'); reg_pipe2_5 <= (others => '0');
	  reg_pipe6 <= (others => '0'); reg_pipe1_6 <= (others => '0'); reg_pipe2_6 <= (others => '0');
	  reg_pipe7 <= (others => '0'); reg_pipe1_7 <= (others => '0'); reg_pipe2_7 <= (others => '0');
	  reg_pipe8 <= (others => '0'); reg_pipe1_8 <= (others => '0'); reg_pipe2_8 <= (others => '0');
	  reg_pipe9 <= (others => '0'); reg_pipe1_9 <= (others => '0'); reg_pipe2_9 <= (others => '0');
	  
	  tmp_pipe1 <= (others => '0'); tmp_pipe1_1 <= (others => '0'); tmp_pipe2_1 <= (others => '0');
	  tmp_pipe2 <= (others => '0'); tmp_pipe1_2 <= (others => '0'); tmp_pipe2_2 <= (others => '0');
	  tmp_pipe3 <= (others => '0'); tmp_pipe1_3 <= (others => '0'); tmp_pipe2_3 <= (others => '0');
	  tmp_pipe4 <= (others => '0'); tmp_pipe1_4 <= (others => '0'); tmp_pipe2_4 <= (others => '0');
	  tmp_pipe5 <= (others => '0'); tmp_pipe1_5 <= (others => '0'); tmp_pipe2_5 <= (others => '0');
	  tmp_pipe6 <= (others => '0'); tmp_pipe1_6 <= (others => '0'); tmp_pipe2_6 <= (others => '0');
	  tmp_pipe7 <= (others => '0'); tmp_pipe1_7 <= (others => '0'); tmp_pipe2_7 <= (others => '0');
	  tmp_pipe8 <= (others => '0'); tmp_pipe1_8 <= (others => '0'); tmp_pipe2_8 <= (others => '0');
	  tmp_pipe9 <= (others => '0'); tmp_pipe1_9 <= (others => '0'); tmp_pipe2_9 <= (others => '0');
	  
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
	  v_in <= '0'; v_in_pipe1 <= '0'; v_in_pipe2 <= '0'; v_in_pipe3 <= '0'; v_in_pipe4 <= '0';
	  v_in_pipe5 <= '0'; v_in_pipe6 <= '0'; v_in_pipe7 <= '0'; v_in_pipe8 <= '0'; v_in_pipe9 <= '0';
      VOUT <= '0';	
	  DOUT3k <= (others => '0');
	  DOUT3k1 <= (others => '0');
	  DOUT3k2 <= (others => '0');
	 
    elsif CLK'event and CLK = '1' then
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
	  v_in_pipe1 <= VIN;
	  v_in_pipe2 <= v_in_pipe1;
	  v_in_pipe3 <= v_in_pipe2;
	  v_in_pipe4 <= v_in_pipe3;
	  v_in_pipe5 <= v_in_pipe4;
	  v_in_pipe6 <= v_in_pipe5;
	  v_in_pipe7 <= v_in_pipe6;
	  v_in_pipe8 <= v_in_pipe7;
	  v_in_pipe9 <= v_in_pipe8;
	  v_in <= v_in_pipe9;
	  VOUT <= v_in;
	  
	  reg_pipe1 <= x3k;
	  reg_pipe1_1 <= x3k1;
	  reg_pipe2_1 <= x3k_1;
	  
	  reg_pipe2 <= reg_pipe1;
	  reg_pipe1_2 <= x3k_2;
	  reg_pipe2_2 <= reg_pipe2_1;
	  
	  reg_pipe3 <= x3k_3;
	  reg_pipe1_3 <= reg_pipe1_2;
	  reg_pipe2_3 <= reg_pipe2_2;
	  
	  reg_pipe4 <= reg_pipe3;
	  reg_pipe1_4 <= reg_pipe1_3;
	  reg_pipe2_4 <= x3k_4;
	  
	  reg_pipe5 <= reg_pipe4;
	  reg_pipe1_5 <= x3k_5;
	  reg_pipe2_5 <= reg_pipe2_4;
	  
	  reg_pipe6 <= x3k_6;
	  reg_pipe1_6 <= reg_pipe1_5;
	  reg_pipe2_6 <= reg_pipe2_5;
	  
	  reg_pipe2_7 <= x3k_7;
	  reg_pipe7 <= reg_pipe6;
	  reg_pipe1_7 <= reg_pipe1_6;
	  
	  reg_pipe8 <= reg_pipe7;
	  reg_pipe1_8 <= x3k_8;
	  reg_pipe2_8 <= reg_pipe2_7;
	  
	  reg_pipe9 <= x3k_9;
	  reg_pipe1_9 <= reg_pipe1_8;
	  reg_pipe2_9 <= reg_pipe2_8;
      if VIN = '1' then
        x3k  <= signed(DIN3k);
		x3k1 <= signed(DIN3k1);
		x3k2 <= signed(DIN3k2);
		
		x3k_1 <= x3k2;
      end if;
	if v_in_pipe1 = '1' then
		x3k_2 <= reg_pipe1_1;
	end if;
	
	if v_in_pipe2 = '1' then
		x3k_3 <= reg_pipe2;
	end if;
	
	if v_in_pipe3 = '1' then 
		x3k_4 <= reg_pipe2_3;
	end if;
	
	if v_in_pipe4 = '1' then
		x3k_5 <= reg_pipe1_4;
	end if;
	
	if v_in_pipe5 = '1' then
		x3k_6 <= reg_pipe5;
	end if;
	
	if v_in_pipe6 = '1' then
		x3k_7 <= reg_pipe2_6;
	end if;
	
	if v_in_pipe7 = '1' then 
		x3k_8 <= reg_pipe1_7;
	end if;
	
	if v_in_pipe8 = '1' then
		x3k_9 <= reg_pipe8;
	end if;
	
	if v_in_pipe9 = '1' then
		x3k_10 <= reg_pipe2_9;
	end if;
		
	  -- eseguo operazioni troncando moltiplicazione (THD circa -30dB)
	  tmp3k_s1 := 	"*"(x3k, b_0)(14 downto 8) + "*"(x3k_1, b_1)(14 downto 8);
	  tmp_pipe1 <= tmp3k_s1;
	  tmp3k_s2 := tmp_pipe1 + "*"(x3k_2, b_2)(14 downto 8);
	  tmp_pipe2 <= tmp3k_s2;
	  tmp3k_s3 := tmp_pipe2 +
	  			"*"(x3k_3, b_3)(14 downto 8);
	  tmp_pipe3 <= tmp3k_s3;
	  tmp3k_s4 := tmp_pipe3 +
	  			"*"(x3k_4, b_4)(14 downto 8);
	  tmp_pipe4 <= tmp3k_s4;
	  tmp3k_s5 := tmp_pipe4 + 		
	  			"*"(x3k_5, b_5)(14 downto 8);
	  tmp_pipe5 <= tmp3k_s5;
	  tmp3k_s6 := tmp_pipe5 +
	  			"*"(x3k_6, b_6)(14 downto 8);
	  tmp_pipe6 <= tmp3k_s6;
	  tmp3k_s7 := tmp_pipe6 +
	  			"*"(x3k_7, b_7)(14 downto 8);
	  tmp_pipe7 <= tmp3k_s7;
	  tmp3k_s8 := tmp_pipe7 +
	  			"*"(x3k_8, b_8)(14 downto 8);
	  tmp_pipe8 <= tmp3k_s8;
	  tmp3k_s9 := tmp_pipe8 +
				"*"(x3k_9, b_9)(14 downto 8);
	  tmp_pipe9 <= tmp3k_s9;
	  tmp3k_s10 := tmp_pipe9 +
	  			"*"(x3k_10, b_10)(14 downto 8);
	  			
				
	  tmp3k1_s1 :="*"(x3k1, b_0)(14 downto 8) + 
	  			"*"(x3k, b_1)(14 downto 8);
	  tmp_pipe1_1 <= tmp3k1_s1;
	  tmp3k1_s2 := tmp_pipe1_1 + 		
	  			"*"(reg_pipe2_1, b_2)(14 downto 8);
	  tmp_pipe1_2 <= tmp3k1_s2;	
	  tmp3k1_s3 := tmp_pipe1_2 + 
	  			"*"(reg_pipe1_2, b_3)(14 downto 8);
	  tmp_pipe1_3 <= tmp3k1_s3;	
	  tmp3k1_s4 := tmp_pipe1_3 +		
	  			"*"(reg_pipe3, b_4)(14 downto 8);
	  tmp_pipe1_4 <= tmp3k1_s4;	
	  tmp3k1_s5 := tmp_pipe1_4 +
	  			"*"(reg_pipe2_4, b_5)(14 downto 8);
	  tmp_pipe1_5 <= tmp3k1_s5;
	  tmp3k1_s6 := tmp_pipe1_5 +
	  			"*"(reg_pipe1_5, b_6)(14 downto 8);
	  tmp_pipe1_6 <= tmp3k1_s6;
	  tmp3k1_s7 := tmp_pipe1_6 +
	  			"*"(reg_pipe6, b_7)(14 downto 8);
	  tmp_pipe1_7 <= tmp3k1_s7;
	  tmp3k1_s8 := tmp_pipe1_7 +
	  			"*"(reg_pipe2_7, b_8)(14 downto 8);
	  tmp_pipe1_8 <= tmp3k1_s8;
	  tmp3k1_s9 := tmp_pipe1_8 +
	  			"*"(reg_pipe1_8, b_9)(14 downto 8);
	  tmp_pipe1_9 <= tmp3k1_s9;
	  tmp3k1_s10 := tmp_pipe1_9 +
	  			"*"(reg_pipe9, b_10)(14 downto 8);
	  			
				
	  tmp3k2_s1 :="*"(x3k2, b_0)(14 downto 8) + 
	  			"*"(x3k1, b_1)(14 downto 8);
	  tmp_pipe2_1 <= tmp3k2_s1;
	  tmp3k2_s2 := tmp_pipe2_1 +		
	  			"*"(reg_pipe1, b_2)(14 downto 8);
	  tmp_pipe2_2 <= tmp3k2_s2;
	  tmp3k2_s3 :=tmp_pipe2_2 +
	  			"*"(reg_pipe2_2, b_3)(14 downto 8);
	  tmp_pipe2_3 <= tmp3k2_s3;
	  tmp3k2_s4 := tmp_pipe2_3 +		
	  			"*"(reg_pipe1_3, b_4)(14 downto 8);
	  tmp_pipe2_4 <= tmp3k2_s4;
	  tmp3k2_s5 := tmp_pipe2_4 +
	  			"*"(reg_pipe4, b_5)(14 downto 8);
	  tmp_pipe2_5 <= tmp3k2_s5;
	  tmp3k2_s6 := tmp_pipe2_5 +		
	  			"*"(reg_pipe2_5, b_6)(14 downto 8);
	  tmp_pipe2_6 <= tmp3k2_s6;
	  tmp3k2_s7 := tmp_pipe2_6 +
	  			"*"(reg_pipe1_6, b_7)(14 downto 8);
	  tmp_pipe2_7 <= tmp3k2_s7;
	  tmp3k2_s8 := tmp_pipe2_7 +
				"*"(reg_pipe7, b_8)(14 downto 8);
	  tmp_pipe2_8 <= tmp3k2_s8;
	  tmp3k2_s9 := tmp_pipe2_8 +
	  			"*"(reg_pipe2_8, b_9)(14 downto 8);
	  tmp_pipe2_9 <= tmp3k2_s9;
	  tmp3k2_s10 := tmp_pipe2_9 +
				"*"(reg_pipe1_9, b_10)(14 downto 8);
	  
	  if v_in = '1' then 
		DOUT3k 	<= std_logic_vector(tmp3k_s10) & '0';
		DOUT3k1 <= std_logic_vector(tmp3k1_s10) & '0';
		DOUT3k2 <= std_logic_vector(tmp3k2_s10) & '0';
	  end if;
	
    end if;
  end process;
end beh;
