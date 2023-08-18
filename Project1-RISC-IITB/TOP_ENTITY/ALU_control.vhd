library ieee;
use ieee.std_logic_1164.all;

entity ALU_control is
	port(ins_2: in std_logic;
	ALU_Op: in std_logic_vector(1 downto 0);
	ALU_sel: out  std_logic_vector(1 downto 0));
end entity;

architecture ALU_control_arc of ALU_control is
begin
	ALU_sel(1)  <= ins_2 and ALU_Op(1);
	ALU_sel (0) <= ALU_Op(0);
	
end architecture;