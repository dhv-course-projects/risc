library ieee;
use ieee.std_logic_1164.all;

entity Top_entity is
	port(rst,clk:in std_logic);
end entity;

architecture Top_entity_arc of Top_entity is
begin



end architecture;library ieee;
use ieee.std_logic_1164.all;

entity Top_entity is
	port(rst,clk:in std_logic);
end entity;

architecture Top_entity_arc of Top_entity is

component ALU is
	port( ALU_control: in std_logic_vector(1 downto 0); 
			ALU_A: in std_logic_vector(15 downto 0); 
			ALU_B: in std_logic_vector(15 downto 0);
			ALU_C: out std_logic_vector(15 downto 0);
			z: out std_logic;
			c: out std_logic );
	
end component;

component Memory is
	port(A1: in std_logic_vector(15 downto 0);
	Data: in std_logic_vector(15 downto 0);
	M_out : out std_logic_vector(15 downto 0);
	M_write: in std_logic);
end component;

component pc is
	port(pcin : in std_logic_vector(15 downto 0);
	pc_write: in std_logic;
	result_out: out std_logic_vector(15 downto 0));
end component;

component Register_File is
	port(A1,A2,A3: in std_logic_vector(2 downto 0);
	D3: in std_logic_vector(15 downto 0);
	RF_write: in std_logic;
	pc_val: in std_logic_vector(15 downto 0);
	pc_write: in std_logic;
	D1,D2: out std_logic_vector(15 downto 0));
end component;

component Sign_extend is
	port(ins_8to0:in std_logic_vector(8 downto 0);
	imm6: in std_logic;
	imm_extended: out std_logic_vector(15 downto 0));
end component;

component zero_Reg is
	port(ALU_zero: in std_logic;
	zero_write: in std_logic;
	result_out: out std_logic);
end component;

component carry_Reg is
	port(ALU_carry: in std_logic;
	carry_write: in std_logic;
	result_out: out std_logic);
end component;

component InstructionFetch is
	port( clk,rst:in std_logic;
    ins_in: in std_logic_vector(15 downto 0);
    valid_ins: in std_logic;
    force_stall: in std_logic;
    valid_ins_out: out std_logic;
    ins_addr_in:in std_logic_vector(15 downto 0);
    ins_addr_out:out std_logic_vector(15 downto 0);
    stall_out:out std_logic;
    ins_out: out std_logic_vector(15 downto 0)
    );
end component;

component InstructionExecute is
	port(clk,rst:in std_logic;  

        valid_ins_in,reg_write_in,reg_read_1_in,reg_read_2_in: in std_logic;
        reg_write_add_in,reg_read_add_1_in,reg_read_add_2_in: in std_logic_vector(2 downto 0); 
        read_c_in,read_z_in,z_write_in,c_write_in,pc_change_in,Mem_Write_in: in std_logic;
        reg_write_val_available_in,mem_write_val_available_in: in std_logic;
        z_val_available_in,c_val_available_in: in std_logic;
        reg_write_val_in,mem_write_val_in: in std_logic_vector(15 downto 0);
        z_val_in,c_val_in: in std_logic;
        opcode_in : in std_logic_vector(3 downto 0);
        cz_in:  in std_logic_vector(1 downto 0);
		imm6_extended: in std_logic_vector(15 downto 0);
        imm9_extended: in std_logic_vector(15 downto 0);
        ins_addr_in: in std_logic_vector(15 downto 0);


        valid_ins_out,reg_write_out,reg_read_1_out,reg_read_2_out: out std_logic;
        reg_write_add_out,reg_read_add_1_out,reg_read_add_2_out: out std_logic_vector(2 downto 0); 
        read_c_out,read_z_out,z_write_out,c_write_out,pc_change_out,Mem_Write_out: out std_logic;
        reg_write_val_available_out,mem_write_val_available_out: out std_logic;
        reg_write_val_out,mem_write_val_out: out std_logic_vector(15 downto 0);
        z_val_available_out,c_val_available_out: out std_logic;
        z_val_out,c_val_out: out std_logic;
        opcode_out : out std_logic_vector(3 downto 0);
        cz_out:  out std_logic_vector(1 downto 0);
        pc_out :out std_logic_vector(15 downto 0);
		
        reg_1_val,reg_2_val: in std_logic_vector(15 downto 0);
        mem_addr_out: out std_logic_vector(15 downto 0);
        ins_addr_out: out std_logic_vector(15 downto 0);
        stall_out : out std_logic;

        add_branch:out std_logic;
        branch_from: out std_logic_vector(15 downto 0);
        branch_to:out std_logic_vector(15 downto 0);
        branch_taken:out  std_logic);
			 
end component;

component InstructionDecode is
	port(clk,rst: in std_logic;

    ins_addr_in:in std_logic_vector(15 downto 0);
    ins_addr_out:out std_logic_vector(15 downto 0);

    ins_in: in std_logic_vector(15 downto 0);
    valid_ins_in:in std_logic; --from IF
    valid_ins:in std_logic;     -- from control
    forced_stall: in std_logic;
    cz_out: out std_logic_vector(1 downto 0);
    opcode_out: out std_logic_vector(3 downto 0);
    valid_ins_out:out std_logic;
    reg_write: out std_logic;
    reg_write_add: out std_logic_vector(2 downto 0);
    reg_write_val_available,mem_write_val_available,z_val_available,c_val_available: out std_logic;
    reg_write_val: out std_logic_vector(15 downto 0);
    mem_write_val: out std_logic_vector(15 downto 0);
    reg_read_1: out std_logic;
    reg_addr_1: out std_logic_vector(2 downto 0);
    reg_1_val: out std_logic_vector(15 downto 0);
    reg_read_2: out std_logic;
    reg_addr_2: out std_logic_vector(2 downto 0);
    reg_2_val: out std_logic_vector(15 downto 0);
    read_c: out std_logic;
    read_z: out std_logic;
    z_write: out std_logic;
    c_write: out std_logic;
    z_val: out std_logic;
    c_val: out std_logic;
    pc_change: out std_logic;
    imm6: out std_logic_vector(5 downto 0);
    imm9: out std_logic_vector(8 downto 0);
    Mem_Write: out std_logic);
end component;

component MemoryAccess is
	port(clk,rst:in std_logic;
        valid_ins_in,reg_write_in,reg_read_1_in,reg_read_2_in: in std_logic;
        reg_write_add_in,reg_read_add_1_in,reg_read_add_2_in: in std_logic_vector(2 downto 0); 
        read_c_in,read_z_in,z_write_in,c_write_in,pc_change_in,Mem_Write_in: in std_logic;
        reg_write_val_available_in,mem_write_val_available_in: in std_logic;
        z_val_available_in,c_val_available_in: in std_logic;
        reg_write_val_in,mem_write_val_in: in std_logic_vector(15 downto 0);
        z_val_in,c_val_in: in std_logic;
        opcode_in : in std_logic_vector(3 downto 0);
        cz_in:  in std_logic_vector(1 downto 0);
		mem_addr_in: in std_logic_vector(15 downto 0);  
        pc_val_in: in std_logic_vector(15 downto 0);
        pc_val_out: out std_logic_vector(15 downto 0);

        valid_ins_out,reg_write_out,reg_read_1_out,reg_read_2_out: out std_logic;
        reg_write_add_out,reg_read_add_1_out,reg_read_add_2_out: out std_logic_vector(2 downto 0); 
        read_c_out,read_z_out,z_write_out,c_write_out,pc_change_out,Mem_Write_out: out std_logic;
        reg_write_val_available_out,mem_write_val_available_out: out std_logic;
        reg_write_val_out,mem_write_val_out: out std_logic_vector(15 downto 0);
        z_val_available_out,c_val_available_out: out std_logic;
        z_val_out,c_val_out: out std_logic;
        opcode_out : out std_logic_vector(3 downto 0);
        cz_out:  out std_logic_vector(1 downto 0);
		 
        mem_val:in std_logic_vector(15 downto 0);
        mem_addr_out,mem_data:out std_logic_vector(15 downto 0);
        mem_write:out std_logic);

end component;

component InstructionMemory is
	port(A1: in std_logic_vector(15 downto 0);
	M_out : out std_logic_vector(15 downto 0));
end component;

component WriteBack is
	port(clk,rst:in std_logic;
        valid_ins_in,reg_write_in,reg_read_1_in,reg_read_2_in: in std_logic;
        reg_write_add_in,reg_read_add_1_in,reg_read_add_2_in: in std_logic_vector(2 downto 0); 
        read_c_in,read_z_in,z_write_in,c_write_in,pc_change_in,Mem_Write_in: in std_logic;
        reg_write_val_available_in,mem_write_val_available_in: in std_logic;
        z_val_available_in,c_val_available_in: in std_logic;
        reg_write_val_in,mem_write_val_in: in std_logic_vector(15 downto 0);
        z_val_in,c_val_in: in std_logic;
        opcode_in : in std_logic_vector(3 downto 0);
        cz_in:  in std_logic_vector(1 downto 0);
        pc_val_in: in std_logic_vector(15 downto 0);        --calculated before
		pc_val : in std_logic_vector(15 downto 0);         --from pc

        valid_ins_out,reg_write_out,reg_read_1_out,reg_read_2_out: out std_logic;
        reg_write_add_out,reg_read_add_1_out,reg_read_add_2_out: out std_logic_vector(2 downto 0); 
        read_c_out,read_z_out,z_write_out,c_write_out,pc_change_out,Mem_Write_out: out std_logic;
        reg_write_val_available_out,mem_write_val_available_out: out std_logic;
        reg_write_val_out,mem_write_val_out: out std_logic_vector(15 downto 0);
        z_val_available_out,c_val_available_out: out std_logic;
        z_val_out,c_val_out: out std_logic;
        opcode_out : out std_logic_vector(3 downto 0);
        cz_out:  out std_logic_vector(1 downto 0);
		 
        c_write,z_write,pc_write: out std_logic;
        pc_val_out:out std_logic_vector(15 downto 0);
        rf_write: out std_logic);
end component;

component Next_instruction is
	port(clk,rst:in std_logic;
        change_instruction:in std_logic;
        add_branch:in std_logic;
        branch_from: in std_logic_vector(15 downto 0);
        branch_to:in std_logic_vector(15 downto 0);
        branch_taken:in std_logic;
        insadd_out:out std_logic_vector(15 downto 0);
        not_valid_all:out std_logic);
end component;

component Stall_Control is
	port(clk,rst:in std_logic;
    stall_IF,stall_ID,stall_EX:in std_logic;
    not_valid_all:in std_logic;
    valid_IF,valid_ID:out std_logic;
    forcestall_IF,forcestall_ID:out std_logic);
end component;

signal ALU_Zero,ALU_Carry,Mem_write,pc_write,RF_write,wb_z_val_out,z_write,z_out,wb_c_val_out,c_write,c_out: std_logic;
signal ALU_sel: std_logic_vector(1 downto 0);
signal id_reg_read_addr1,id_reg_read_addr2,wb_reg_write_addr: std_logic_vector(2 downto 0);
signal : std_logic_vector(3 downto 0);
signal id_imm6: std_logic_vector(5 downto 0);
signal id_imm9: std_logic_vector(8 downto 0);
signal imm9_extend,imm6_extend,ALU_A,ALU_B,ALU_C,Mem_addr_out,Mem_data,Mem_val,pc_val_out,pc_val: std_logic_vector(15 downto 0);
signal wb_reg_write_val,id_reg_val1,id_reg_val2,ni_ins_addr_out,M_out,: std_logic_vector(15 downto 0);
signal if_ins_addr_out,if_ins_out: std_logic_vector(15 downto 0);
signal if_valid_ins_out,if_stall_out,sc_valid_id: std_logic;


begin

    ALU1: ALU
        port map ( ALU_control=>ALU_sel,ALU_A=>ALU_A,ALU_B=>ALU_B,ALU_C=>ALU_C,z=>ALU_Zero,c=>ALU_Carry);

    MEM: Memory
            port(A1=>mem_addr_out,Data=>mem_data,M_out=>mem_val,M_write=>mem_write);

    PC1: pc
        port map (pcin=>pc_val_out,pc_write=>pc_write,result_out=>pc_val);
    
    RF: Register_File
        port map (A1=>id_reg_read_addr1,A2=>id_reg_read_addr2,A3=>wb_reg_write_addr,D3=>wb_reg_write_val,RF_write=>rf_write,
                pc_val=>pc_val_out,pc_write=>pc_write,D1=>id_reg_val1,D2=>id_reg_val2);

    SE9: Sign_extend
        port map (ins_8to0 => id_imm9,imm6 => '0',imm_extended=>imm9_extend);

    SE6: Sign_extend
        port map (ins_8to0 => "000" & id_imm6,imm6 => '1',imm_extended=>imm6_extend);

    Z_REG: zero_Reg
        port map (ALU_zero=>wb_z_val_out,zero_write=>z_write,result_out=>z_out);
    
    C_REG: carry_Reg
        port map (ALU_carry=>wb_c_val_out,carry_write=>c_write,result_out=>c_out);

    FETCH: InstructionFetch
        port map ( clk=>clk,rst=>rst,valid_ins=>sc_valid_if,force_stall=>sc_fs_if, 
        ins_in=>M_out,ins_addr_in=>ni_ins_addr_out,valid_ins_out=>if_valid_ins_out,stall_out=>if_stall_out,
        ins_addr_out=>if_ins_addr_out,ins_out=>if_ins_out);

    INS_DECODE: InstructionDecode
        port map (clk=>clk,rst=>rst,
    
        ins_addr_in=>if_ins_addr_out,
        ins_addr_out=>id_ins_addr_out,
    
        ins_in=>if_ins_out,
        valid_ins_in=>if_valid_ins_out, --from IF
        valid_ins=>sc_valid_id,     -- from control
        forced_stall=>sc_forced_stall_id,
        cz_out=>id_cz_out,
        opcode_out=>id_opcode_out,
        valid_ins_out=>id_valid_ins_out,
        reg_write=>id_reg_write_out,
        reg_write_add=>id_reg_write_addr_out,
        reg_write_val_available=>id_reg_write_val_available_out,mem_write_val_available=>id_mem_write_val_available_out,z_val_available=>id_z_val_available_out,c_val_available=>id_c_val_available_out,
        reg_write_val=>id_reg_write_val_out,
        mem_write_val=>id_mem_write_val_out,
        reg_read_1=>id_reg_read_1_out,
        reg_addr_1=>id_reg_addr_1_out,
        reg_1_val=>id_reg_1_val_out,
        reg_read_2=>id_reg_read_2_out,
        reg_addr_2=>id_reg_addr_2_out,
        reg_2_val=>id_reg_2_val_out,
        read_c=>id_read_c_out,
        read_z=>id_read_z_out,
        z_write=>id_z_write_out,
        c_write=>id_c_write_out,
        z_val=>id_z_val_out,
        c_val=>id_c_val_out,
        pc_change=>id_pc_change_out,
        imm6=>id_imm6,
        imm9=>id_imm9,
        Mem_Write=>id_mem_write);

    INS_EXECUTE: InstructionExecute
        port map (clk=>clk,rst=>rst,  
    
            valid_ins_in=>id_valid_ins_out,reg_write_in=>id_reg_write_out,reg_read_1_in=>id_reg_read_1_out,reg_read_2_in=>id_reg_read_2_out,
            reg_write_add_in=>id_reg_write_add_out,reg_read_add_1_in=>id_reg_read_add_1_out,reg_read_add_2_in=>id_reg_read_add_2_out, 
            read_c_in=>id_read_c_out,read_z_in=>id_read_z_out,z_write_in=>id_z_write_out,c_write_in=>id_c_write_out,pc_change_in=>id_pc_change_out,Mem_Write_in=>id_Mem_Write_out,
            reg_write_val_available_in=>id_reg_write_val_available_out,mem_write_val_available_in=>id_mem_write_val_available_out,
            z_val_available_in=>id_z_val_available_out,c_val_available_in=>id_c_val_available_out,
            reg_write_val_in=>id_reg_write_val_out,mem_write_val_in=>id_mem_write_val_out,
            z_val_in=>id_z_val_out,c_val_in=>id_c_val_out,
            opcode_in=>id_opcode_out,
            cz_in=>id_cz_out,
            imm6_extended=>imm6_extend,
            imm9_extended=>imm9_extend,
            ins_addr_in=>id_ins_addr_out,
    
    
            valid_ins_out=>ie_valid_ins_out,reg_write_out=>ie_reg_write_out,reg_read_1_out=>ie_reg_read_1_out,reg_read_2_out=>ie_reg_read_2_out,
            reg_write_add_out=>ie_reg_write_add_out,reg_read_add_1_out=>ie_reg_read_add_1_out,reg_read_add_2_out=>ie_reg_read_add_2_out, 
            read_c_out=>ie_read_c_out,read_z_out=>ie_read_z_out,z_write_out=>ie_z_write_out,c_write_out=>ie_c_write_out,pc_change_out=>ie_pc_change_out,Mem_Write_out=>ie_Mem_Write_out,
            reg_write_val_available_out=>ie_reg_write_val_available_out,mem_write_val_available_out=>ie_mem_write_val_available_out,
            reg_write_val_out=>ie_reg_write_val_out,mem_write_val_out=>ie_mem_write_val_out,
            z_val_available_out=>ie_z_val_available_out,c_val_available_out=>ie_c_val_available_out,
            z_val_out=>ie_z_val_out,c_val_out=>ie_c_val_out,
            opcode_out =>ie_opcode_out ,
            cz_out=>ie_cz_out,
            pc_out=>ie_pc_out,
            
            reg_1_val=>ec_reg1_val,reg_2_val=>ec_reg2_val,
            mem_addr_out=>ie_mem_addr_out,
            ins_addr_out=>ie_ins_addr_out,
            stall_out=>ie_stall_out,
    
            add_branch=>ie_add_branch,
            branch_from=>ie_branch_from,
            branch_to=>ie_branch_to,
            branch_taken=>ie_branch_taken);

    MEM_ACCESS: MemoryAccess
        port map(clk=>clk,rst=>rst,
            valid_ins_in=>ie_valid_ins_out,reg_write_in=>ie_reg_write_out,reg_read_1_in=>ie_reg_read_1_out,reg_read_2_in=>ie_reg_read_2_out,
            reg_write_add_in=>ie_reg_write_add_out,reg_read_add_1_in=>ie_reg_read_add_1_out,reg_read_add_2_in=>ie_reg_read_add_2_out, 
            read_c_in=>ie_read_c_out,read_z_in=>ie_read_z_out,z_write_in=>ie_z_write_out,c_write_in=>ie_c_write_out,pc_change_in=>ie_pc_change_out,Mem_Write_in=>ie_Mem_Write_out,
            reg_write_val_available_in=>ie_reg_write_val_available_out,mem_write_val_available_in=>ie_mem_write_val_available_out,
            z_val_available_in=>ie_z_val_available_out,c_val_available_in=>ie_c_val_available_out,
            reg_write_val_in=>ie_reg_write_val_out,mem_write_val_in=>ie_mem_write_val_out,
            z_val_in=>ie_z_val_out,c_val_in=>ie_c_val_out,
            opcode_in =>ie_opcode_iout,
            cz_in=>ie_cz_out,
            mem_addr_in=>ie_mem_addr_out,  
            pc_val_in=>ie_pc_val_out,
            pc_val_out=>ma_pc_val_out,
    
            valid_ins_out=>ma_valid_ins_out,reg_write_out=>ma_reg_write_out,reg_read_1_out=>ma_reg_read_1_out,reg_read_2_out=>ma_reg_read_2_out,
            reg_write_add_out=>ma_reg_write_add_out,reg_read_add_1_out=>ma_reg_read_add_1_out,reg_read_add_2_out=>ma_reg_read_add_2_out, 
            read_c_out=>ma_read_c_out,read_z_out=>ma_read_z_out,z_write_out=>ma_z_write_out,c_write_out=>ma_c_write_out,pc_change_out=>ma_pc_change_out,Mem_Write_out=>ma_Mem_Write_out,
            reg_write_val_available_out=>ma_reg_write_val_available_out,mem_write_val_available_out=>ma_mem_write_val_available_out,
            reg_write_val_out=>ma_reg_write_val_out,mem_write_val_out=>ma_mem_write_val_out,
            z_val_available_out=>ma_z_val_available_out,c_val_available_out=>ma_c_val_available_out,
            z_val_out=>ma_z_val_out,c_val_out=>ma_c_val_out,
            opcode_out =>ma_opcode_out ,
            cz_out=>ma_cz_out,
                
            mem_val=>mem_val,
            mem_addr_out=>mem_addr_out,mem_data=>mem_data,
            mem_write=>mem_write);

    INS_MEMORY: InstructionMemory
        port map(A1=>ni_ins_addr_out,M_out=>M_out);

    WB: WriteBack
        port map(clk=>clk,rst=>rst,
            valid_ins_in=>ma_valid_ins_out,reg_write_in=>ma_reg_write_out,reg_read_1_in=>ma_reg_read_1_out,reg_read_2_in=>ma_reg_read_2_out,
            reg_write_add_in=>ma_reg_write_add_out,reg_read_add_1_in=>ma_reg_read_add_1_out,reg_read_add_2_in=>ma_reg_read_add_2_out, 
            read_c_in=>ma_read_c_out,read_z_in=>ma_read_z_out,z_write_in=>ma_z_write_out,c_write_in=>ma_c_write_out,pc_change_in=>ma_pc_change_out,Mem_Write_in=>ma_Mem_Write_out,
            reg_write_val_available_in=>ma_reg_write_val_available_out,mem_write_val_available_in=>ma_mem_write_val_available_out,
            z_val_available_in=>ma_z_val_available_out,c_val_available_in=>ma_c_val_available_out,
            reg_write_val_in=>ma_reg_write_val_out,mem_write_val_in=>ma_mem_write_val_out,
            z_val_in=>ma_z_val_out,c_val_in=>ma_c_val_out,
            opcode_in =>ma_opcode_iout,
            cz_in=>ma_cz_out,
            pc_val_in=>ma_pc_val_out,        --calculated before
            pc_val =>pc_val,         --from pc
    
            valid_ins_out=>wb_valid_ins_out,reg_write_out=>wb_reg_write_out,reg_read_1_out=>wb_reg_read_1_out,reg_read_2_out=>wb_reg_read_2_out,
            reg_write_add_out=>wb_reg_write_add_out,reg_read_add_1_out=>wb_reg_read_add_1_out,reg_read_add_2_out=>wb_reg_read_add_2_out, 
            read_c_out=>wb_read_c_out,read_z_out=>wb_read_z_out,z_write_out=>wb_z_write_out,c_write_out=>wb_c_write_out,pc_change_out=>wb_pc_change_out,Mem_Write_out=>wb_Mem_Write_out,
            reg_write_val_available_out=>wb_reg_write_val_available_out,mem_write_val_available_out=>wb_mem_write_val_available_out,
            reg_write_val_out=>wb_reg_write_val_out,mem_write_val_out=>wb_mem_write_val_out,
            z_val_available_out=>wb_z_val_available_out,c_val_available_out=>wb_c_val_available_out,
            z_val_out=>wb_z_val_out,c_val_out=>wb_c_val_out,
            opcode_out =>wb_opcode_out ,
            cz_out=>wb_cz_out,
                
            c_write=>c_write,z_write=>z_write,pc_write=>pc_write,
            pc_val_out=>pc_val_out,
            rf_write=>rf_write);

    -- NEXT_INS: Next_instruction
    --     port map(clk=>clk,rst=>rst,
    --         change_instruction=>,
    --         add_branch=>,
    --         branch_from=>,
    --         branch_to=>,
    --         branch_taken=>,
    --         insadd_out=>,
    --         not_valid_all=>);
            
    -- SC: Stall_Control
    --     port map(clk=>clk,rst=>rst,
    --     stall_IF=>,stall_ID=>,stall_EX=>,
    --     not_valid_all=>,
    --     valid_IF=>,valid_ID=>,
    --     forcestall_IF=>,forcestall_ID=>
    --     );
            
end architecture;