library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_before_RFA3 is
	port(RA:in std_logic_vector(2 downto 0);
	LM:in std_logic_vector(2 downto 0);
	control_sig:in std_logic_vector(1 downto 0);
	output : out std_logic_vector(2 downto 0));
end entity;

architecture mux_before_RFA3_arc of mux_before_RFA3 is
begin
	process (control_sig,RA,LM)
	begin
			if (control_sig(1) = '1') then
						output <= "111";
			elsif (control_sig(0) = '1') then
						output <= LM;
			else
						output <= RA;
			end if;
	end process;
	
end architecture;