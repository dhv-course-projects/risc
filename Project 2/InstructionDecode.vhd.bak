library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionDecode is
	port(
    ins_in: in std_logic_vector(15 downto 0);
    valid_ins_in:in std_logic;
    ins_out: out std_logic_vector(15 downto 0);
    valid_ins_out:out std_logic;
    reg_write: out std_logic;
    reg_write_add: out std_logic_vector(2 downto 0);
    reg_write_val_available: out std_logic;
    reg_write_val: out std_logic_vector(15 downto 0);
    reg_read_1: out std_logic;
    reg_addr_1: out std_logic_vector(2 downto 0);
    reg_read_2: out std_logic;
    reg_addr_2: out std_logic_vector(2 downto 0);
    read_c: out std_logic;
    read_z: out std_logic;
    z_write: out std_logic;
    c_write: out std_logic;
    pc_change: out std_logic;
    Mem_Write: out std_logic);
end entity;

architecture InstructionDecode_arc of InstructionDecode is
    signal stall:std_logic;
    
    signal op1_addr,op2_addr: std_logic_vector(2 downto 0);
    signal op1_val,op2_val: std_logic_vector(15 downto 0);
    signal imm6: std_logic_vector(5 downto 0);
    signal imm9: std_logic_vector(8 downto 0);
    signal imm6_ext: std_logic_vector(15 downto 0);
    signal imm9_ext: std_logic_vector(15 downto 0);
begin

	
    process (stall,valid_in)
    begin
        valid_out <= valid_in and (not stall);
    end process;

end architecture;