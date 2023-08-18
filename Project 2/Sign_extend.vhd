library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Sign_extend is
	port(ins_8to0:in std_logic_vector(8 downto 0);
	imm6: in std_logic;
	imm_extended: out std_logic_vector(15 downto 0));
end entity;

architecture Sign_extend_arc of Sign_extend is
begin
	process (imm6,ins_8to0)
	begin
			if (imm6 = '1') then
					if(ins_8to0(5) = '1') then
							imm_extended <= "1111111111" & ins_8to0(5 downto 0); 
					else
							imm_extended <= "0000000000" & ins_8to0(5 downto 0); 
					end if;
			else
					if(ins_8to0(8) = '1') then
							imm_extended <= "1111111" & ins_8to0(8 downto 0); 
					else
							imm_extended <= "0000000" & ins_8to0(8 downto 0); 
					end if;
			end if;
	end process;
	
end architecture;