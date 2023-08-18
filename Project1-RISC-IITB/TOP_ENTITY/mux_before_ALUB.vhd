library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_before_ALUB is
	port(B_Reg:in std_logic_vector(15 downto 0);
	leftshift_result:in std_logic_vector(15 downto 0);
	control_sig:in std_logic_vector(2 downto 0);
	signextend_result: in std_logic_vector(15 downto 0);
	output : out std_logic_vector(15 downto 0));
end entity;

architecture mux_before_ALUB_arc of mux_before_ALUB is
begin
	process (control_sig,B_Reg,leftshift_result,signextend_result)
	begin
			if (control_sig(2) = '1') then
						output <= "0000000000000001";
			elsif (control_sig(1) = '1') then
					output <= leftshift_result;
			elsif (control_sig(0) = '1') then
					output <= signextend_result;
			else
					output <= B_Reg;
			end if;
	end process;
	
end architecture;