library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_before_zeroreg is
	port(
	ALU_z: in std_logic;
	memreg_result: in std_logic_vector(15 downto 0);
	control_sig:in std_logic;
	output : out std_logic);
end entity;

architecture mux_before_zeroreg_arc of mux_before_zeroreg is
begin
	process (control_sig,memreg_result,ALU_z)
	begin
			if (control_sig = '1') then
					if (memreg_result = "0000000000000000") then
						output <= '1';
					else
						output <= '0';
					end if;
					
			else
					output <= ALU_z;
			end if;
	end process;
	
end architecture;