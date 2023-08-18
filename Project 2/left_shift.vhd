library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity left_shift is
	port ( RC: in std_logic_vector(15 downto 0); 
			 B: out std_logic_vector(15 downto 0));
end entity;


architecture shift of left_shift is

begin

	B(0) <= '0';

	shift_element:
	for i in 1 to 15 generate
		B(i) <= RC(i-1);
	end generate;

	
end shift;