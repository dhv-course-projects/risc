library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_Reg is
	port(ALU_C: in std_logic_vector(15 downto 0);
	ALUReg_write: in std_logic;
	result_out: out std_logic_vector(15 downto 0));
end entity;

architecture ALU_Reg_arc of ALU_Reg is
	signal result: std_logic_vector(15 downto 0):= "0000000000000000";
begin
	result_out <= result;
	process (ALUReg_write,ALU_C)
	begin
			if (ALUReg_write = '1') then
					result <= ALU_C;
			end if;
	end process;
	
end architecture;