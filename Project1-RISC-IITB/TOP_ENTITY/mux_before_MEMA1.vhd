library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_before_MEMA1 is
	port(
	pc:in std_logic_vector(15 downto 0);
	ALU_result: in std_logic_vector(15 downto 0);
	LM_memadd: in std_logic_vector(15 downto 0);
	control_sig:in std_logic_vector(1 downto 0);
	output : out std_logic_vector(15 downto 0));
end entity;

architecture mux_before_MEMA1_arc of mux_before_MEMA1 is
begin
	process (control_sig,pc,ALU_result)
	begin
			if (control_sig = "10") then
					output <= ALU_result;
			elsif (control_sig = "01") then
					output <= LM_memadd;
			else
					output <= pc;
			end if;
	end process;
	
end architecture;