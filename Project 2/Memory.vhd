library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Memory is
	port(A1: in std_logic_vector(15 downto 0);
	Data: in std_logic_vector(15 downto 0);
	M_out : out std_logic_vector(15 downto 0);
	M_write: in std_logic);
end entity;

architecture Memory_arc of Memory is
		type memor is array(65535 downto 0) of std_logic_vector(15 downto 0);
		signal memory: memor:= (x"91ff",x"91ff",x"91ff",x"0050",x"3255",x"3051", others => x"0000");
begin
	M_out <= memory(to_integer(unsigned(A1)));
	process (M_write,Data,A1)
	begin
			if (M_write = '1') then
					memory(to_integer(unsigned(A1))) <= Data;
			end if;
	end process;
	
end architecture;