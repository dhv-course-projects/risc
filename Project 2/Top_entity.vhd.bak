library ieee;
use ieee.std_logic_1164.all;

entity Top_entity is
	port(rst,clk:in std_logic);
end entity;

architecture Top_entity_arc of Top_entity is



component A_Reg is
	port(D1: in std_logic_vector(15 downto 0);
	AReg_write: in std_logic;
	result_out: out std_logic_vector(15 downto 0));
end component;

component ALU_control is
	port(ins_2: in std_logic;
	ALU_Op: in std_logic_vector(1 downto 0);
	ALU_sel: out  std_logic_vector(1 downto 0));
end component;

component ALU_Reg is
	port(ALU_C: in std_logic_vector(15 downto 0);
	ALUReg_write: in std_logic;
	result_out: out std_logic_vector(15 downto 0));
end component;

component ALU is
	port( ALU_control: in std_logic_vector(1 downto 0); 
			ALU_A: in std_logic_vector(15 downto 0); 
			ALU_B: in std_logic_vector(15 downto 0);
			ALU_C: out std_logic_vector(15 downto 0);
			z: out std_logic;
			c: out std_logic );
	
end component;

component B_Reg is
	port(D2: in std_logic_vector(15 downto 0);
	BReg_write: in std_logic;
	result_out: out std_logic_vector(15 downto 0));
end component;

component Controller is
	port(state: in std_logic_vector(4 downto 0);
	opcode: in std_logic_vector(3 downto 0);
	c, z: in std_logic;
	cz: in std_logic_vector(1 downto 0);
	ins_7to0:in std_logic_vector(7 downto 0);
	Reg_ADD:in std_logic_vector(2 downto 0);
	
	AReg_write: out std_logic;
	BReg_write: out std_logic;
	IR_write: out std_logic;
	MDR_write: out std_logic;
	M_write: out std_logic;
	ALUReg_write: out std_logic;
	pc_write: out std_logic;
    carry_write: out std_logic;
	zero_write: out std_logic;
	RF_write: out std_logic;

	mux_before_RFD3_cs:out std_logic_vector(3 downto 0);
	mux_before_RFA3_cs:out std_logic_vector(1 downto 0);
	mux_before_RFA1_cs:out std_logic_vector(1 downto 0);
	mux_before_RFA2_cs:out std_logic_vector(1 downto 0);
	mux_before_MEMA1_cs:out std_logic_vector(1 downto 0);
	mux_before_ALUB_cs:out std_logic_vector(2 downto 0);
	mux_before_ALUA_cs:out std_logic_vector(2 downto 0);
	mux_before_pc_cs:out std_logic_vector(1 downto 0);
	LMSM_cs :out std_logic_vector(1 downto 0);
    mux_before_zeroreg_cs:out std_logic;
	
	imm6: out std_logic;
	ALU_Op: out std_logic_vector(1 downto 0);
	nextState: out std_logic_vector(4 downto 0));
end component;

component IR is
	port(M_out: in std_logic_vector(15 downto 0);
	IR_write: in std_logic;
	op_code: out std_logic_vector(3 downto 0);
	cz: out std_logic_vector(1 downto 0);
	ins_8to0: out std_logic_vector(8 downto 0);
	ins_7to0: out std_logic_vector(7 downto 0);
	RA: out std_logic_vector(2 downto 0);
	RB: out std_logic_vector(2 downto 0);
	RC: out std_logic_vector(2 downto 0));
end component;

component left_shift is
	port ( RC: in std_logic_vector(15 downto 0); 
			 B: out std_logic_vector(15 downto 0));
end component;

component LMSM_reg is
	port(
	Mem_ADD_i: in std_logic_vector(15 downto 0);
	control_sig:in std_logic_vector(1 downto 0);
	Reg_ADD: out std_logic_vector(2 downto 0);
	Mem_ADD: out std_logic_vector(15 downto 0));
end component;

component MDR is
	port(M_out: in std_logic_vector(15 downto 0);
	MDR_write: in std_logic;
	result_out: out std_logic_vector(15 downto 0));
end component;

component Memory is
	port(A1: in std_logic_vector(15 downto 0);
	Data: in std_logic_vector(15 downto 0);
	M_out : out std_logic_vector(15 downto 0);
	M_write: in std_logic);
end component;

component mux_before_ALUA is
	port(A_Reg:in std_logic_vector(15 downto 0);
	pc:in std_logic_vector(15 downto 0);
	control_sig:in std_logic_vector(2 downto 0);
	signextend_result: in std_logic_vector(15 downto 0);
	output : out std_logic_vector(15 downto 0));
end component;

component mux_before_ALUB is
	port(B_Reg:in std_logic_vector(15 downto 0);
	leftshift_result:in std_logic_vector(15 downto 0);
	control_sig:in std_logic_vector(2 downto 0);
	signextend_result: in std_logic_vector(15 downto 0);
	output : out std_logic_vector(15 downto 0));
end component;

component mux_before_MEMA1 is
	port(
	pc:in std_logic_vector(15 downto 0);
	ALU_result: in std_logic_vector(15 downto 0);
	LM_memadd: in std_logic_vector(15 downto 0);
	control_sig:in std_logic_vector(1 downto 0);
	output : out std_logic_vector(15 downto 0));
end component;

component mux_before_pc is
	port(ALU_result:in std_logic_vector(15 downto 0);
	ALU_reg:in std_logic_vector(15 downto 0);
	AReg_result:in std_logic_vector(15 downto 0);
	control_sig:in std_logic_vector(1 downto 0);
	output : out std_logic_vector(15 downto 0));
end component;

component mux_before_RFA1 is
	port(RA:in std_logic_vector(2 downto 0);
	RB:in std_logic_vector(2 downto 0);
	SM:in std_logic_vector(2 downto 0);
	control_sig:in std_logic_vector(1 downto 0);
	output : out std_logic_vector(2 downto 0));
end component;

component mux_before_RFA2 is
	port(RA:in std_logic_vector(2 downto 0);
	RC:in std_logic_vector(2 downto 0);
	SM:in std_logic_vector(2 downto 0);
	control_sig:in std_logic_vector(1 downto 0);
	output : out std_logic_vector(2 downto 0));
end component;

component mux_before_RFA3 is
	port(RA:in std_logic_vector(2 downto 0);
	LM:in std_logic_vector(2 downto 0);
	control_sig:in std_logic_vector(1 downto 0);
	output : out std_logic_vector(2 downto 0));
end component;

component mux_before_RFD3 is
	port(ALU_result:in std_logic_vector(15 downto 0);
	Shift_left7_result:in std_logic_vector(15 downto 0);
	MDR_result:in std_logic_vector(15 downto 0);
	pc:in std_logic_vector(15 downto 0);
	AReg_result:in std_logic_vector(15 downto 0);
	control_sig:in std_logic_vector(3 downto 0);
	output : out std_logic_vector(15 downto 0));
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
	D1,D2: out std_logic_vector(15 downto 0));
end component;

component Shift_left7 is
	port(imm9:in std_logic_vector(8 downto 0);
	result: out std_logic_vector(15 downto 0));
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

component mux_before_zeroreg is
	port(
	ALU_z: in std_logic;
	memreg_result: in std_logic_vector(15 downto 0);
	control_sig:in std_logic;
	output : out std_logic);
end component;

signal AReg_output,BReg_output,ALUReg_output,MDR_output,PC_output,M_out,MEM_A1,D1,D2,D3,ALU_A,ALU_B,ALU_C,ls_output,ls7_output,sign_output,LMSMMem_output,pcin:std_logic_vector(15 downto 0);
signal ALU_Op: std_logic_vector(1 downto 0);
signal ALU_sel:  std_logic_vector(1 downto 0);
signal state,nextState:  std_logic_vector(4 downto 0);
signal op_code:  std_logic_vector(3 downto 0);
signal cz:  std_logic_vector(1 downto 0);
signal ins_7to0: std_logic_vector(7 downto 0);
signal ins_8to0: std_logic_vector(8 downto 0);
signal LMSMReg_output,RA,RB,RC,RF_A1,RF_A2,RF_A3: std_logic_vector(2 downto 0);
signal AReg_write,BReg_write,IR_write,MDR_write,M_write,ALUReg_write,pc_write,zero_write,carry_write,RF_write,Zero_in:  std_logic;

signal mux_before_RFD3_cs: std_logic_vector(3 downto 0);
signal mux_before_RFA3_cs,mux_before_RFA1_cs,mux_before_RFA2_cs,mux_before_MEMA1_cs,mux_before_pc_cs,LMSM_cs : std_logic_vector(1 downto 0);
signal c, z,ALU_Zero,ALU_Carry,mux_before_zeroreg_cs:  std_logic;
signal mux_before_ALUA_cs,mux_before_ALUB_cs: std_logic_vector(2 downto 0);

signal imm6:  std_logic;

begin

    CONTROL: Controller
    port map (state=>state, opcode=>op_code, c=>c, z=>z, cz=>cz, ins_7to0=>ins_7to0, Reg_ADD=>LMSMReg_Output,

        AReg_write=>AReg_write, BReg_write=>BReg_write, IR_write=>IR_write, MDR_write=>MDR_write,M_write=>M_write, 
        ALUReg_write=>ALUReg_write, pc_write=>pc_write, RF_write=>RF_write,zero_write=>zero_write,carry_write=>carry_write,
        
        mux_before_RFD3_cs=>mux_before_RFD3_cs, mux_before_RFA3_cs=>mux_before_RFA3_cs,
        mux_before_RFA1_cs=>mux_before_RFA1_cs, mux_before_RFA2_cs=>mux_before_RFA2_cs,
        mux_before_MEMA1_cs=>mux_before_MEMA1_cs, mux_before_ALUB_cs=>mux_before_ALUB_cs,
        mux_before_ALUA_cs=>mux_before_ALUA_cs, mux_before_pc_cs=>mux_before_pc_cs,mux_before_zeroreg_cs=>mux_before_zeroreg_cs,
	
        
        LMSM_cs=>LMSM_cs, imm6=>imm6, ALU_Op=>ALU_Op, nextState=>nextState);

    IR1: IR
        port map (M_out=>M_out,IR_write=>IR_write,op_code=>op_code,cz=>cz,
                ins_8to0=>ins_8to0,ins_7to0=>ins_7to0,RA=>RA,RB=>RB,RC=>RC);

    A_REG1: A_Reg
        port map (D1=>D1,AReg_write=>AReg_write,result_out=>AReg_output);

    B_REG1: B_Reg
        port map (D2=>D2,BReg_write=>BReg_write,result_out=>BReg_output);

    PC_REG: pc
        port map (pcin=>pcin,pc_write=>pc_write,result_out=>PC_output);

    ALU_CTRL: ALU_control 
        port map (ins_2=>op_code(1),ALU_Op=>ALU_Op,ALU_sel=>ALU_sel);

    ALU_REG1: ALU_Reg 
        port map (ALU_C=>ALU_C,ALUReg_write=>ALUReg_write,result_out=>ALUReg_output);

    ALU1: ALU
        port map ( ALU_control=>ALU_sel,ALU_A=>ALU_A,ALU_B=>ALU_B,ALU_C=>ALU_C,z=>ALU_Zero,c=>ALU_Carry);

    LS: left_shift
        port map ( RC=>BReg_output,B=>ls_output);

    LS7: Shift_left7
        port map ( imm9=>ins_8to0,result=>ls7_output);

    SIGN_EXTD: Sign_extend
        port map ( ins_8to0=>ins_8to0,imm6=>imm6,imm_extended=>sign_output);

    LMSM_REG1: LMSM_reg
        port map ( Mem_ADD_i=>BReg_output,control_sig=>LMSM_cs,Reg_ADD=>LMSMReg_output,Mem_ADD=>LMSMMem_output);

    MDR1: MDR
        port map (M_out=>M_out,MDR_write=>MDR_write,result_out=>MDR_output);

    MEMORY1: Memory
        port map (A1=>MEM_A1,Data=>BReg_output,M_out=>M_out,M_write=>M_write);

    RF: Register_File
        port map (A1=>RF_A1,A2=>RF_A2,A3=>RF_A3,D3=>D3,RF_write=>RF_write,D1=>D1,D2=>D2);

    MUX_ALUA: mux_before_ALUA
        port map (A_Reg=>AReg_output,pc=>PC_output,control_sig=>mux_before_ALUA_cs,signextend_result=>sign_output,output=>ALU_A);

    MUX_ALUB: mux_before_ALUB
        port map (B_Reg=>BReg_output,leftshift_result=>ls_output,control_sig=>mux_before_ALUB_cs,signextend_result=>sign_output,output=>ALU_B);

    MUX_MEMA1: mux_before_MEMA1
        port map (pc=>PC_output,ALU_result=>ALUReg_output,LM_memadd=>LMSMMem_output,control_sig=>mux_before_MEMA1_cs,output=>MEM_A1);

    MUX_PC: mux_before_pc
        port map (ALU_result=>ALU_C,ALU_reg=>ALUReg_output,AReg_result=>AReg_output,control_sig=>mux_before_pc_cs,output=>pcin);

    MUX_RFA1: mux_before_RFA1
        port map (RA=>RA,RB=>RB,SM=>LMSMReg_output,control_sig=>mux_before_RFA1_cs,output=>RF_A1);

    MUX_RFA2: mux_before_RFA2
        port map (RA=>RA,RC=>RC,SM=>LMSMReg_output,control_sig=>mux_before_RFA2_cs,output=>RF_A2);

    MUX_RFA3: mux_before_RFA3
        port map (RA=>RA,LM=>LMSMReg_output,control_sig=>mux_before_RFA3_cs,output=>RF_A3);

    MUX_RFD3: mux_before_RFD3 
        port map (ALU_result=>ALU_C,Shift_left7_result=>ls7_output,MDR_result=>MDR_output,pc=>PC_output,AReg_result=>ALUReg_output,control_sig=>mux_before_RFD3_cs,output=>D3);

    ZERO: zero_Reg
        port map (ALU_zero=>Zero_in,zero_write=>zero_write,result_out=>z);

    CARRY: carry_Reg
        port map (ALU_carry=>ALU_Carry,carry_write=>carry_write,result_out=>c);

    MUX_ZERO: mux_before_zeroreg
        port map (ALU_z=>ALU_Zero,memreg_result=>MDR_output,control_sig=>mux_before_zeroreg_cs,output=>Zero_in);

    process (clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '1') then
                state <= "11111";
            else
                state <= nextState;
            end if;
        end if;
    end process;

end architecture;