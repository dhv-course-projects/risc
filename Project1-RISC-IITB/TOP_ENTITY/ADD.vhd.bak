library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package adder is
	component full_adder is
		port( a, b, cin: in std_logic;
				s, p, g: out std_logic);
	end component;
	
	component carry_generate is
		port( P, G: in std_logic_vector(3 downto 0);
				cin: in std_logic;
				Cout: out std_logic );
	end component;
	
	component ADD is
		port( A, B: in std_logic_vector(15 downto 0);
				S: out std_logic_vector(15 downto 0);
				cin: in std_logic;
				Cout: out std_logic );
	end component;

end package;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder is
	port(
		a, b, cin: in std_logic;
		s, p, g: out std_logic);
end entity;

architecture basic of full_adder is
begin
	
	g <= a and b;
	p <= a or b;
	s <= a xor b xor cin;
	
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity carry_generate is
	port(
		P, G: in std_logic_vector(3 downto 0);
		cin: in std_logic;
		Cout: out std_logic );
end entity;

architecture basic of carry_generate is
	signal C: std_logic_vector(4 downto 0);
begin
	
	C(0) <= cin;
	logic:
	for i in 1 to 4 generate
		C(i) <= G(i-1) or (P(i-1) and C(i-1)); 
	end generate;

	Cout <= C(4);
end architecture;


library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

library work;
use work.adder.all;

entity ADD is
	port(
		A, B: in std_logic_vector(15 downto 0);
		S: out std_logic_vector(15 downto 0);
		cin: in std_logic;
		Cout: out std_logic );
end entity;

architecture look_ahead of ADD is
	signal C: std_logic_vector(4 downto 0);
	signal P, G: std_logic_vector(15 downto 0);
	
begin

	C(0) <= cin;
	
	adder_element:
	for i in 0 to 15 generate
		ADDX: full_adder
			port map(a => A(i), b => B(i), cin => C(i),
				s => S(i), p => P(i), g => G(i));
	end generate;
	
	carry_element:
	for i in 0 to 3 generate
		CARRYX: carry_generate
			port map(P => P((i+1)*3 downto i*4),
				G => G((i+1)*3 downto i*4),
				cin => C(i), Cout => C(i+1));
	end generate;
	
	Cout <= C(4);
	
end architecture;
