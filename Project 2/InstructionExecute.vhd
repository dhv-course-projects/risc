library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity InstructionExecute is
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
			 
end entity;

architecture InstructionExecute_arc of InstructionExecute is
    signal stall:std_logic;
    signal valid_ins_in_s1,reg_write_in_s1,reg_read_1_in_s1,reg_read_2_in_s1:std_logic;
    signal reg_write_add_in_s1,reg_read_add_1_in_s1,reg_read_add_2_in_s1:std_logic_vector(2 downto 0); 
    signal read_c_in_s1,read_z_in_s1,z_write_in_s1,c_write_in_s1,pc_change_in_s1,Mem_Write_in_s1:std_logic;
    signal reg_write_val_available_in_s1,mem_write_val_available_in_s1: std_logic;
    signal reg_write_val_in_s1,mem_write_val_in_s1: std_logic_vector(15 downto 0);
    signal z_val_available_in_s1,c_val_available_in_s1: std_logic;
    signal z_val_in_s1,c_val_in_s1: std_logic;
    signAL opcode_in_s1 :std_logic_vector(3 downto 0);
    signal cz_in_s1: std_logic_vector(1 downto 0);

    signal valid_ins_out_s2,reg_write_out_s2,reg_read_1_out_s2,reg_read_2_out_s2:std_logic;
    signal reg_write_add_out_s2,reg_read_add_1_out_s2,reg_read_add_2_out_s2:std_logic_vector(2 downto 0); 
    signal read_c_out_s2,read_z_out_s2,z_write_out_s2,c_write_out_s2,pc_change_out_s2,Mem_Write_out_s2:std_logic;
    signal reg_write_val_available_out_s2,mem_write_val_available_out_s2: std_logic;
    signal reg_write_val_out_s2,mem_write_val_out_s2: std_logic_vector(15 downto 0);
    signal z_val_available_out_s2,c_val_available_out_s2: std_logic;
    signal z_val_out_s2,c_val_out_s2: std_logic;
    signal opcode_out_s2 : std_logic_vector(3 downto 0);
    signal cz_out_s2: std_logic_vector(1 downto 0);

	 signal reg_1_val_s1,reg_2_val_s1,reg_1_val_s2,reg_2_val_s2:std_logic_vector(15 downto 0);
	 signal ins_addr_in_s1,ins_addr_out_s2:std_logic_vector(15 downto 0);
    component ALU is
        port( ALU_control: in std_logic_vector(1 downto 0); 
                ALU_A: in std_logic_vector(15 downto 0); 
                ALU_B: in std_logic_vector(15 downto 0);
                ALU_C: out std_logic_vector(15 downto 0);
                z: out std_logic;
                c: out std_logic );
        
    end component;

    signal ALU_control:std_logic_vector(1 downto 0); 
    signal ALU_A,ALU_B:std_logic_vector(15 downto 0);
    signal ALU_C:std_logic_vector(15 downto 0);
    signal ALU_zero,ALU_carry: std_logic;
    signal op1_val_control,op2_val_control:std_logic_vector(15 downto 0);
    signal data_stall_control: std_logic;
    signal c_stall,z_stall,c_valid,z_valid: std_logic;
begin

    ALU1: ALU
    port map ( ALU_control=>ALU_control,ALU_A=>ALU_A,ALU_B=>ALU_B,ALU_C=>ALU_C,z=>ALU_zero,c=>ALU_carry);

    stall_out <= stall;

    ins_addr_in_s1 <= ins_addr_in;
    ins_addr_out <= ins_addr_out_s2;

	valid_ins_in_s1 <= valid_ins_in;
    reg_write_in_s1 <= reg_write_in;
    reg_write_add_in_s1 <= reg_write_add_in;
    reg_read_1_in_s1 <= reg_read_1_in;
    reg_read_add_1_in_s1 <= reg_read_add_1_in;
    reg_read_2_in_s1 <= reg_read_2_in;
    reg_read_add_2_in_s1 <= reg_read_add_2_in;
    read_c_in_s1 <= read_c_in;
    read_z_in_s1 <= read_z_in;
    z_write_in_s1 <= z_write_in;
    c_write_in_s1 <= c_write_in;
    pc_change_in_s1 <= pc_change_in;
    Mem_Write_in_s1 <= Mem_Write_in;
    reg_write_val_available_in_s1 <= reg_write_val_available_in;
    mem_write_val_available_in_s1 <=  mem_write_val_available_in;
    reg_write_val_in_s1 <= reg_write_val_in;
    mem_write_val_in_s1 <=  mem_write_val_in;
    z_val_available_in_s1 <= z_val_available_in;
    c_val_available_in_s1 <=  c_val_available_in;
    z_val_in_s1 <= z_val_in;
    c_val_in_s1 <=  c_val_in;
    opcode_in_s1 <=  opcode_in;
    cz_in_s1 <= cz_in;
	 reg_1_val_s1 <= reg_1_val;
	 reg_2_val_s1 <= reg_2_val;

    valid_ins_out <= valid_ins_out_s2;
    valid_ins_out <= valid_ins_out_s2;
    reg_write_out <= reg_write_out_s2;
    reg_write_add_out <= reg_write_add_out_s2;
    reg_read_1_out <= reg_read_1_out_s2;
    reg_read_add_1_out <= reg_read_add_1_out_s2;
    reg_read_2_out <= reg_read_2_out_s2;
    reg_read_add_2_out <= reg_read_add_2_out_s2;
    read_c_out <= read_c_out_s2;
    read_z_out <= read_z_out_s2;
    z_write_out <= z_write_out_s2;
    c_write_out <= c_write_out_s2;
    pc_change_out <= pc_change_out_s2;
    Mem_Write_out <= Mem_Write_out_s2;
    reg_write_val_available_out <= reg_write_val_available_out_s2;
    mem_write_val_available_out <=  mem_write_val_available_out_s2;
    reg_write_val_out <= reg_write_val_out_s2;
    mem_write_val_out <=  mem_write_val_out_s2;
    z_val_available_out <= z_val_available_out_s2;
    c_val_available_out <=  c_val_available_out_s2;
    z_val_out <= z_val_out_s2;
    c_val_out <=  c_val_out_s2;
    opcode_out <=  opcode_out_s2;
    cz_out <= cz_out_s2;
	 	

	process (clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '1') then
              
            else
                if(stall = '0') then
                    ins_addr_in_s1 <= ins_addr_in;
                    ins_addr_out <= ins_addr_out_s2;
                    valid_ins_out_s2 <= valid_ins_in_s1;
                    valid_ins_out_s2 <= valid_ins_in_s1;
                    reg_write_out_s2 <= reg_write_in_s1;
                    reg_write_add_out_s2 <= reg_write_add_in_s1;
                    reg_read_1_out_s2 <= reg_read_1_in_s1;
                    reg_read_add_1_out_s2 <= reg_read_add_1_in_s1;
                    reg_read_2_out_s2 <= reg_read_2_in_s1;
                    reg_read_add_2_out_s2 <= reg_read_add_2_in_s1;
                    read_c_out_s2 <= read_c_in_s1;
                    read_z_out_s2 <= read_z_in_s1;
                    z_write_out_s2 <= z_write_in_s1;
                    c_write_out_s2 <= c_write_in_s1;
                    pc_change_out_s2 <= pc_change_in_s1;
                    Mem_Write_out_s2 <= Mem_Write_in_s1;
                    reg_write_val_available_out_s2 <= reg_write_val_available_in_s1;
                    mem_write_val_available_out_s2 <=  mem_write_val_available_in_s1;
                    reg_write_val_out_s2 <= reg_write_val_in_s1;
                    mem_write_val_out_s2 <=  mem_write_val_in_s1;
                    z_val_available_out_s2 <= z_val_available_in_s1;
                    c_val_available_out_s2 <=  c_val_available_in_s1;
                    z_val_out_s2 <= z_val_available_in_s1;
                    c_val_out_s2 <=  c_val_available_in_s1;
                    opcode_out_s2 <=  opcode_in_s1;
                    cz_out_s2 <= cz_in_s1;
						  reg_1_val_s2 <= reg_1_val_s1;
						  reg_2_val_s2 <= reg_2_val_s1;
                else 
                    stall  <= '0';
                end if;
            end if;
        end if;
    end process;

    process(c_stall,z_stall,data_stall_control)
    begin
        if((opcode_out_s2 = "0001" and cz_out_s2 = "10" )or (opcode_out_s2 = "0010" and cz_out_s2 = "10" )) then
            stall <= data_stall_control and c_stall;
        elsif((opcode_out_s2 = "0001" and cz_out_s2 = "01" )or (opcode_out_s2 = "0010" and cz_out_s2 = "01" )) then
            stall <= data_stall_control and z_stall;
        else
            stall <= data_stall_control;
			end if;
    end process;

    process (stall,c_valid,z_valid)
    begin
        if((opcode_out_s2 = "0001" and cz_out_s2 = "10" )or (opcode_out_s2 = "0010" and cz_out_s2 = "10" )) then
            valid_ins_out_s2 <= valid_ins_out_s2 and (not stall) and c_valid;
        elsif((opcode_out_s2 = "0001" and cz_out_s2 = "01" )or (opcode_out_s2 = "0010" and cz_out_s2 = "01" )) then
				valid_ins_out_s2 <= valid_ins_out_s2 and (not stall) and z_valid;
        else
				valid_ins_out_s2 <= valid_ins_out_s2 and (not stall);
		  end if;
    end process;
    
    process(opcode_out_s2,cz_out_s2,stall,op1_val_control,op2_val_control,imm6_extended,imm9_extended)
	begin
        if(valid_ins_out_s2 = '1') then
            case opcode_out_s2 is
                when "0001" => -- ADD,ADC,ADZ,ADL
                        if(cz_out_s2 = "00") then --ADD
                            ALU_control <= "00";
                            ALU_A <= op1_val_control;
                            ALU_B <= op2_val_control;
                            mem_addr_out <= "0000000000000000";
                            ins_addr_out_s2 <= "0000000000000000";
                            if (stall = '0') then 
                                reg_write_val_available_out_s2 <= '1';
                                z_val_available_out_s2 <= '1';
                                c_val_available_out_s2 <= '1';
                                reg_write_val_out_s2 <= ALU_C;
                                z_val_out_s2 <= ALU_zero;
                                c_val_out_s2 <= ALU_carry;
                            else 
                                reg_write_val_available_out_s2 <= '0';
                                z_val_available_out_s2 <= '0';
                                c_val_available_out_s2 <= '0';
                            end if;
                            
                        elsif (cz_out_s2 = "01") then --ADZ
                            ALU_control <= "00";
                            ALU_A <= op1_val_control;
                            ALU_B <= op2_val_control;
                            mem_addr_out <= "0000000000000000";
                            ins_addr_out_s2 <= "0000000000000000";
                            if (stall = '0') then 
                                reg_write_val_available_out_s2 <= '1';
                                z_val_available_out_s2 <= '1';
                                c_val_available_out_s2 <= '1';
                                reg_write_val_out_s2 <= ALU_C;
                                z_val_out_s2 <= ALU_zero;
                                c_val_out_s2 <= ALU_carry;
                            else 
                                reg_write_val_available_out_s2 <= '0';
                                z_val_available_out_s2 <= '0';
                                c_val_available_out_s2 <= '0';
                            end if;

                        elsif (cz_out_s2 = "10") then --ADC
                            ALU_control <= "00";
                            ALU_A <= op1_val_control;
                            ALU_B <= op2_val_control;
                            mem_addr_out <= "0000000000000000";
                            ins_addr_out_s2 <= "0000000000000000";
                            if (stall = '0') then 
                                reg_write_val_available_out_s2 <= '1';
                                z_val_available_out_s2 <= '1';
                                c_val_available_out_s2 <= '1';
                                reg_write_val_out_s2 <= ALU_C;
                                z_val_out_s2 <= ALU_zero;
                                c_val_out_s2 <= ALU_carry;
                            else 
                                reg_write_val_available_out_s2 <= '0';
                                z_val_available_out_s2 <= '0';
                                c_val_available_out_s2 <= '0';
                            end if;

                        else   --ADL
                            ALU_control <= "00";
                            ALU_A <= op1_val_control;
                            ALU_B <= op2_val_control(14 downto 0) & "0";
                            mem_addr_out <= "0000000000000000";
                            ins_addr_out_s2 <= "0000000000000000";
                            if (stall = '0') then 
                                reg_write_val_available_out_s2 <= '1';
                                z_val_available_out_s2 <= '1';
                                c_val_available_out_s2 <= '1';
                                reg_write_val_out_s2 <= ALU_C;
                                z_val_out_s2 <= ALU_zero;
                                c_val_out_s2 <= ALU_carry;
                            else 
                                reg_write_val_available_out_s2 <= '0';
                                z_val_available_out_s2 <= '0';
                                c_val_available_out_s2 <= '0';
                            end if;

                        end if;

                when "0010" => -- NDU, NDC, NDZ
                        if(cz_out_s2 = "00") then --NDU
                            ALU_control <= "10";
                            ALU_A <= op1_val_control;
                            ALU_B <= op2_val_control;
                            mem_addr_out <= "0000000000000000";
                            ins_addr_out_s2 <= "0000000000000000";
                            if (stall = '0') then 
                                reg_write_val_available_out_s2 <= '1';
                                z_val_available_out_s2 <= '1';
                                c_val_available_out_s2 <= '0';
                                reg_write_val_out_s2 <= ALU_C;
                                z_val_out_s2 <= ALU_zero;
                                -- c_val_out_s2 <= ALU_carry;
                            else 
                                reg_write_val_available_out_s2 <= '0';
                                z_val_available_out_s2 <= '0';
                                c_val_available_out_s2 <= '0';
                            end if;
                            
                        elsif (cz_out_s2 = "01") then --NDZ
                            ALU_control <= "10";
                            ALU_A <= op1_val_control;
                            ALU_B <= op2_val_control;
                            mem_addr_out <= "0000000000000000";
                            ins_addr_out_s2 <= "0000000000000000";
                            if (stall = '0') then 
                                reg_write_val_available_out_s2 <= '1';
                                z_val_available_out_s2 <= '1';
                                c_val_available_out_s2 <= '0';
                                reg_write_val_out_s2 <= ALU_C;
                                z_val_out_s2 <= ALU_zero;
                                -- c_val_out_s2 <= ALU_carry;
                            else 
                                reg_write_val_available_out_s2 <= '0';
                                z_val_available_out_s2 <= '0';
                                c_val_available_out_s2 <= '0';
                            end if;

                        elsif (cz_out_s2 = "10") then --NDC
                            ALU_control <= "10";
                            ALU_A <= op1_val_control;
                            ALU_B <= op2_val_control;
                            mem_addr_out <= "0000000000000000";
                            ins_addr_out_s2 <= "0000000000000000";
                            if (stall = '0') then 
                                reg_write_val_available_out_s2 <= '1';
                                z_val_available_out_s2 <= '1';
                                c_val_available_out_s2 <= '0';
                                reg_write_val_out_s2 <= ALU_C;
                                z_val_out_s2 <= ALU_zero;
                                c_val_out_s2 <= ALU_carry;
                            else 
                                reg_write_val_available_out_s2 <= '0';
                                z_val_available_out_s2 <= '0';
                                -- c_val_available_out_s2 <= '0';
                            end if;
                        end if;

                when "0000" => -- ADI
                        ALU_control <= "00";
                        ALU_A <= op1_val_control;
                        ALU_B <= imm6_extended;
                        mem_addr_out <= "0000000000000000";
                        ins_addr_out_s2 <= "0000000000000000";
                        if (stall = '0') then 
                            reg_write_val_available_out_s2 <= '1';
                            z_val_available_out_s2 <= '1';
                            c_val_available_out_s2 <= '1';
                            reg_write_val_out_s2 <= ALU_C;
                            z_val_out_s2 <= ALU_zero;
                            c_val_out_s2 <= ALU_carry;
                        else 
                            reg_write_val_available_out_s2 <= '0';
                            z_val_available_out_s2 <= '0';
                            c_val_available_out_s2 <= '0';
                        end if;

                when "0011" => --LHI
                        mem_addr_out <= "0000000000000000";
                        ins_addr_out_s2 <= "0000000000000000";
                        if (stall = '0') then 
                            reg_write_val_available_out_s2 <= '1';
                            z_val_available_out_s2 <= '0';
                            c_val_available_out_s2 <= '0';
                            reg_write_val_out_s2 <= imm9_extended(8 downto 0) & "0000000";
                        else 
                            reg_write_val_available_out_s2 <= '0';
                            z_val_available_out_s2 <= '0';
                            c_val_available_out_s2 <= '0';
                        end if;

                when "0101" => --LW
                        ins_addr_out_s2 <= "0000000000000000";
                        ALU_control <= "00";
                        ALU_A <= op1_val_control;
                        ALU_B <= imm6_extended;
                        reg_write_val_available_out_s2 <= '0';
                        z_val_available_out_s2 <= '0';
                        c_val_available_out_s2 <= '0';
                        if (stall = '0') then 
                            mem_addr_out <= ALU_C;
                        else 
                            mem_addr_out <= "0000000000000000";
                        end if;

                when "0111" => --SW
                        ALU_control <= "00";
                        ALU_A <= op1_val_control;
                        ALU_B <= imm6_extended;
                        reg_write_val_available_out_s2 <= '0';
                        z_val_available_out_s2 <= '0';
                        c_val_available_out_s2 <= '0';
                        ins_addr_out_s2 <= "0000000000000000";
                        if (stall = '0') then 
                            mem_addr_out <= ALU_C;
                        else 
                            mem_addr_out <= "0000000000000000";
                        end if;

                when "1000" => --BEQ
                        ALU_control <= "00";
                        ALU_A <= ins_addr_out_s2;
                        ALU_B <= imm6_extended;
                        reg_write_val_available_out_s2 <= '0';
                        z_val_available_out_s2 <= '0';
                        c_val_available_out_s2 <= '0';
                        mem_addr_out <= "0000000000000000";
                        if(stall = '0') then
                            add_branch <= '1';
                        else
                            add_branch <= '0';
                        end if;
                        
                        branch_from <= ins_addr_out_s2;
                        branch_to <= ALU_C;
                        
                        if(op1_val_control = op2_val_control) then
                            pc_out <= ALU_C;
                            branch_taken <='1';
                        else
                            pc_out <= ins_addr_out_s2 +1;
                            branch_taken <='0';
                        end if;

                when "1001" => --JAL
                        z_val_available_out_s2 <= '0';
                        c_val_available_out_s2 <= '0';
                        ALU_control <= "00";
                        ALU_A <= ins_addr_in_s1;
                        ALU_B <= imm9_extended;
                        branch_from <= ins_addr_out_s2;
                        branch_taken <='1';
                        branch_to <= ALU_C;
                        if(stall = '0') then
                            add_branch <= '1';
                            reg_write_val_available_out_s2 <= '1';
                            reg_write_val_out_s2 <= ins_addr_in_s1 + "0000000000000001";
                        else
                            add_branch <= '0';
                            reg_write_val_available_out_s2 <= '0';
                        end if;
                        mem_addr_out <= "0000000000000000";
                        pc_out <= ALU_C;
                        

                when "1010" => -- JLR
                        z_val_available_out_s2 <= '0';
                        c_val_available_out_s2 <= '0';
                        branch_from <= ins_addr_out_s2;
                        branch_taken <='1';
                        branch_to <=op1_val_control;
                        if(stall = '0') then
                            add_branch <= '1';
                            reg_write_val_available_out_s2 <= '1';
                            reg_write_val_out_s2 <= ins_addr_in_s1 + "0000000000000001";
                        else
                            add_branch <= '0';
                            reg_write_val_available_out_s2 <= '0';
                        end if;
                        mem_addr_out <= "0000000000000000";
                        pc_out <= op1_val_control;

                when "1011" => -- JRI
                        reg_write_val_available_out_s2 <= '0';
                        z_val_available_out_s2 <= '0';
                        c_val_available_out_s2 <= '0';
                        ALU_control <= "00";
                        branch_from <= ins_addr_out_s2;
                        branch_taken <='1';
                        branch_to <=ALU_C;
                        if(stall = '0') then
                            add_branch <= '1';  
                        else
                            add_branch <= '0';
                        end if;
                        ALU_A <= op1_val_control;
                        ALU_B <= imm9_extended;
                        mem_addr_out <= "0000000000000000";
                        pc_out <= ALU_C;
                    
            end case;
        else
            add_branch <= '0';
        end if;
	end process;

end architecture;