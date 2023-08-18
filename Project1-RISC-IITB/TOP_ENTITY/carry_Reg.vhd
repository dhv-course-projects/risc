library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity carry_Reg is
	port(ALU_carry: in std_logic;
	carry_write: in std_logic;
	result_out: out std_logic);
end entity;

architecture carry_Reg_arc of carry_Reg is
	signal result: std_logic:='0';
begin
	result_out <= result;
	process (carry_write,ALU_carry)
	begin
			if (carry_write = '1') then
					result <= ALU_carry;
			end if;
	end process;
	
end architecture;