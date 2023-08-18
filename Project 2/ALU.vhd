library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity ALU is
	port( ALU_control: in std_logic_vector(1 downto 0); 
			ALU_A: in std_logic_vector(15 downto 0); 
			ALU_B: in std_logic_vector(15 downto 0);
			ALU_C: out std_logic_vector(15 downto 0);
			z: out std_logic;
			c: out std_logic );
	
end entity;

architecture ALU_arct of ALU is
	signal D: std_logic_vector(15 downto 0);
	signal add_result: std_logic_vector(15 downto 0);
	signal output: std_logic_vector(15 downto 0);
	signal Cout: std_logic;
	
	component ADD is
		port( A, B: in std_logic_vector(15 downto 0);
				S: out std_logic_vector(15 downto 0);
				cin: in std_logic;
				Cout: out std_logic );
	end component;
	
begin

	xor_element:
	for i in 0 to 15 generate
		D(i) <= ALU_B(i) xor ALU_control(0);
	end generate;
	
	ADD_SUB1: ADD
		port map ( A => ALU_A, B => D, S => add_result, cin => ALU_control(0), Cout => Cout);
	
	process(ALU_A,ALU_B,ALU_control,add_result)
	begin
		if(ALU_control(1) = '1') then
			output <= ALU_A nand ALU_B;
			c <= '0';
		else
			output <= add_result;
			c <= Cout;
		end if;
	end process;
	
	process(output)
	begin
		if(to_integer(unsigned(output)) = 0) then
			z <= '1';
		else 
			z <= '0';
		end if;
		
		ALU_C <= output;
	end process;

end ALU_arct;