library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_before_ALUA is
	port(A_Reg:in std_logic_vector(15 downto 0);
	pc:in std_logic_vector(15 downto 0);
	control_sig:in std_logic_vector(2 downto 0);
	signextend_result: in std_logic_vector(15 downto 0);
	output : out std_logic_vector(15 downto 0));
end entity;

architecture mux_before_ALUA_arc of mux_before_ALUA is
begin
	process (control_sig,pc,A_Reg,signextend_result)
	begin

			if (control_sig="100") then
				output <= pc;
			elsif (control_sig="010") then
				output <= signextend_result;
			elsif (control_sig="000") then
				output <= A_Reg;
			end if;
	end process;
	
end architecture;