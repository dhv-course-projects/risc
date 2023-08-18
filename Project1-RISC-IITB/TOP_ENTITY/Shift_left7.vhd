library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Shift_left7 is
	port(imm9:in std_logic_vector(8 downto 0);
	result: out std_logic_vector(15 downto 0));
end entity;

architecture Shift_left7_arc of Shift_left7 is
begin
	result <= imm9(8 downto 0) & "0000000"; 
	
end architecture;