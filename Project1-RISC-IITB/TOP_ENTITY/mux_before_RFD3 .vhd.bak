library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_before_RFD3 is
	port(ALU_result:in std_logic_vector(15 downto 0);
	Shift_left7_result:in std_logic_vector(15 downto 0);
	MDR_result:in std_logic_vector(15 downto 0);
	pc:in std_logic_vector(15 downto 0);
	AReg_result:in std_logic_vector(15 downto 0);
	control_sig:in std_logic_vector(3 downto 0);
	output : out std_logic_vector(15 downto 0));
end entity;

architecture mux_before_RFD3_arc of mux_before_RFD3 is
begin
	process (control_sig,ALU_result,Shift_left7_result,MDR_result,AReg_result)
	begin
			if (control_sig(3) = '1') then
						output <= pc;
			elsif (control_sig(2) = '1') then
						output <= ALU_result;
			elsif (control_sig(1) = '1') then
						output <= Shift_left7_result;
			elsif (control_sig(0) = '1') then
						output <= MDR_result;
			else 
						output <= AReg_result;
			end if;
	end process;
	
end architecture;