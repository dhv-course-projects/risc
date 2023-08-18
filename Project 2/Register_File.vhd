library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Register_File is
	port(A1,A2,A3: in std_logic_vector(2 downto 0);
	D3: in std_logic_vector(15 downto 0);
	RF_write: in std_logic;
	pc_val: in std_logic_vector(15 downto 0);
	pc_write: in std_logic;
	D1,D2: out std_logic_vector(15 downto 0));
end entity;

architecture Register_File_arc of Register_File is
	type regist is array(7 downto 0) of std_logic_vector(15 downto 0);
	signal registers: regist:= (others => x"0000");
begin
	D1 <= registers(to_integer(unsigned(A1)));
	D2 <= registers(to_integer(unsigned(A2)));
	
	process (RF_write,D3,A3)
	begin
			if (RF_write = '1') then
					registers(to_integer(unsigned(A3))) <= D3;
			end if;
	end process;
	process (pc_write,pc_val)
	begin
			if (pc_write = '1') then
					registers(7) <= pc_val;
			end if;
	end process;
	
end architecture;