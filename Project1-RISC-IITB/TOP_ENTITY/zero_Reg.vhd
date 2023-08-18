library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity zero_Reg is
	port(ALU_zero: in std_logic;
	zero_write: in std_logic;
	result_out: out std_logic);
end entity;

architecture zero_Reg_arc of zero_Reg is
	signal result: std_logic:= '0';
begin
	result_out <= result;
	process (zero_write,ALU_zero)
	begin
			if (zero_write = '1') then
					result <= ALU_zero;
			end if;
	end process;
	
end architecture;