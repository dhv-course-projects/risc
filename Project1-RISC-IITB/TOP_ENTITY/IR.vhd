library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IR is
	port(M_out: in std_logic_vector(15 downto 0);
	IR_write: in std_logic;
	op_code: out std_logic_vector(3 downto 0);
	cz: out std_logic_vector(1 downto 0);
	ins_8to0: out std_logic_vector(8 downto 0);
	ins_7to0: out std_logic_vector(7 downto 0);
	RA: out std_logic_vector(2 downto 0);
	RB: out std_logic_vector(2 downto 0);
	RC: out std_logic_vector(2 downto 0));
end entity;

architecture IR_arc of IR is
	signal ins: std_logic_vector(15 downto 0):= "0000000000000000";
begin
	op_code <= ins(15 downto 12);
	cz <= ins(1 downto 0);
	ins_8to0 <= ins(8 downto 0);
	ins_7to0 <= ins(7 downto 0);
	RA <= ins(11 downto 9);
	RB <= ins(8 downto 6);
	RC <= ins(5 downto 3);
	process (IR_write,M_out)
	begin
			if (IR_write = '1') then
					ins <= M_out;
			end if;
	end process;
	
end architecture;