library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_before_pc is
	port(ALU_result:in std_logic_vector(15 downto 0);
	ALU_reg:in std_logic_vector(15 downto 0);
	AReg_result:in std_logic_vector(15 downto 0);
	control_sig:in std_logic_vector(1 downto 0);
	output : out std_logic_vector(15 downto 0));
end entity;

architecture mux_before_pc_arc of mux_before_pc is
begin
	process (control_sig,ALU_result,AReg_result)
	begin
			if (control_sig(1) = '1') then
						output <= ALU_reg;
			elsif (control_sig(0) = '1') then
						output <= ALU_result;
			else
						output <= AReg_result;
			end if;
	end process;
	
end architecture;