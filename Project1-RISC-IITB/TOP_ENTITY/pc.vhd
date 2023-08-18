library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
	port(pcin : in std_logic_vector(15 downto 0);
	pc_write: in std_logic;
	result_out: out std_logic_vector(15 downto 0));
end entity;

architecture pc_arc of pc is
	signal result: std_logic_vector(15 downto 0):= "1111111111111010";
begin
	result_out <= result;
	process (pc_write,pcin)
	begin
			if (pc_write = '1') then
					result <= pcin;
			end if;
	end process;
	
end architecture;