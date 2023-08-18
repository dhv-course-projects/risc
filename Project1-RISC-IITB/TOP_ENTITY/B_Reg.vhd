library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity B_Reg is
	port(D2: in std_logic_vector(15 downto 0);
	BReg_write: in std_logic;
	result_out: out std_logic_vector(15 downto 0));
end entity;

architecture B_Reg_arc of B_Reg is
	signal result: std_logic_vector(15 downto 0):= "0000000000000000";
begin
	result_out <= result;
	process (BReg_write,D2)
	begin
			if (BReg_write = '1') then
					result <= D2;
			end if;
	end process;
	
end architecture;