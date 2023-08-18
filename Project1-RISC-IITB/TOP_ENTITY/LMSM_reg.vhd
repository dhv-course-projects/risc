library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity LMSM_reg is
	port(
	Mem_ADD_i: in std_logic_vector(15 downto 0);
	control_sig:in std_logic_vector(1 downto 0);
	Reg_ADD: out std_logic_vector(2 downto 0);
	Mem_ADD: out std_logic_vector(15 downto 0));
end entity;

architecture LMSM_reg_arc of LMSM_reg is
	signal Reg: std_logic_vector(2 downto 0):= "000";
	signal Mem: std_logic_vector(15 downto 0):= "0000000000000000";
	signal Reg2: std_logic_vector(2 downto 0):= "000";
	signal Mem2: std_logic_vector(15 downto 0):= "0000000000000000";
begin
	Reg_ADD <= Reg;
	Mem_ADD <= Mem;
	process (control_sig,Mem_ADD_i)
	begin
			if (control_sig = "11") then
					Reg <= "000";
					Mem <= Mem_ADD_i;
			elsif (control_sig = "10") then
					Reg2 <= Reg + 1;
			elsif (control_sig = "01") then
					Mem2 <= Mem + 1;		
			elsif (control_sig = "00") then
					Mem <= Mem2;
					Reg <= Reg2;				
			end if;
	end process;
	
end architecture;