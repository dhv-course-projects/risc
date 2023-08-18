library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity A_Reg is
	port(D1: in std_logic_vector(15 downto 0);
	AReg_write: in std_logic;
	result_out: out std_logic_vector(15 downto 0));
end entity;

architecture A_Reg_arc of A_Reg is
	signal result: std_logic_vector(15 downto 0):= "0000000000000000";
begin
	result_out <= result;
	process (AReg_write,D1)
	begin
			if (AReg_write = '1') then
					result <= D1;
			end if;
	end process;
	
end architecture;