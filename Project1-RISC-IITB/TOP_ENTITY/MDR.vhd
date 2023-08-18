library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MDR is
	port(M_out: in std_logic_vector(15 downto 0);
	MDR_write: in std_logic;
	result_out: out std_logic_vector(15 downto 0));
end entity;

architecture MDR_arc of MDR is
	signal result: std_logic_vector(15 downto 0):= "0000000000000000";
begin
	result_out <= result;
	process (MDR_write,M_out)
	begin
			if (MDR_write = '1') then
					result <= M_out;
			end if;
	end process;
	
end architecture;