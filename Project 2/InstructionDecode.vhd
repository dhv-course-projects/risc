library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionDecode is
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
end entity;

architecture InstructionDecode_arc of InstructionDecode is
    signal stall:std_logic;
    signal ins_s1,ins_s2:std_logic_vector(15 downto 0);
	signal valid_ins_s1,valid_ins_s2:std_logic;
    signal op1_addr,op2_addr: std_logic_vector(2 downto 0);
    signal op1_val,op2_val: std_logic_vector(15 downto 0);
    signal ins_addr_in_s1,ins_addr_out_s2:std_logic_vector(15 downto 0);
begin
    ins_addr_in_s1 <= ins_addr_in;
    ins_addr_out <= ins_addr_out_s2;
    ins_s1 <= ins_in;
    ins_out <= ins_s2;
    valid_ins_s1 <= valid_ins_in;
    valid_ins_out <= valid_ins_s2 and valid_ins;
    mem_write_val_available <= '0';
    z_val_available <= '0';
    c_val_available <= '0';
    mem_write_val <= "0000000000000000";
    z_val <= '0';
    z_val <= '0';
    stall <= forced_stall;
	process (clk)
    begin
        if(rising_edge(clk)) then

            if(rst = '1') then
              
            else
            
                if(stall = '0') then
                    ins_addr_in_s1 <= ins_addr_in;
                    ins_addr_out <= ins_addr_out_s2;
                    ins_s2 <= ins_s1;
                    valid_ins_s2 <= valid_ins_s1;
                else 
                    
                end if;
            end if;
        end if;
    end process;

    process (stall,valid_ins_s2)
    begin
        valid_ins_s2 <= valid_ins_s2 and (not stall);
    end process;

    process(ins_s2)
	begin
        imm6 <= ins_s2(5 downto 0);
        imm9 <= ins_s2(8 downto 0);
        cz_out <= ins_s2(1 downto 0);
        opcode_out <= ins_s2(15 downto 12);
		case ins_s2(15 downto 12) is
           
			when "0001" => -- ADD,ADC,ADZ,ADL
					if(ins_s2(1 downto 0) = "00") then --ADD
                        reg_write <= '1';
                        reg_write_add <= ins_s2(11 downto 9);           --RA
                        reg_write_val_available <= '0';
                        reg_write_val <= "0000000000000000";
                        reg_read_1 <= '1';
                        reg_addr_1 <= ins_s2(8 downto 6);                --RB
                        -- reg_1_val: out std_logic_vector(15 downto 0);
                        reg_read_2 <= '1';
                        reg_addr_2 <= ins_s2(5 downto 3);                 --RC
                        -- reg_2_val: out std_logic_vector(15 downto 0);
                        read_c <= '0';
                        read_z <= '0';
                        z_write <= '1';
                        c_write <= '1';
                        pc_change <= '0';
                        Mem_Write <= '0';
                    elsif (ins_s2(1 downto 0) = "01") then --ADZ
                        reg_write <= '1';
                        reg_write_add <= ins_s2(11 downto 9);           --RA
                        reg_write_val_available <= '0';
                        reg_write_val <= "0000000000000000";
                        reg_read_1 <= '1';
                        reg_addr_1 <= ins_s2(8 downto 6);                --RB
                        -- reg_1_val: out std_logic_vector(15 downto 0);
                        reg_read_2 <= '1';
                        reg_addr_2 <= ins_s2(5 downto 3);                 --RC
                        -- reg_2_val: out std_logic_vector(15 downto 0);
                        read_c <= '1';
                        read_z <= '0';
                        z_write <= '1';
                        c_write <= '1';
                        pc_change <= '0';
                        Mem_Write <= '0';
                    elsif (ins_s2(1 downto 0) = "10") then --ADC
                        reg_write <= '1';
                        reg_write_add <= ins_s2(11 downto 9);           --RA
                        reg_write_val_available <= '0';
                        reg_write_val <= "0000000000000000";
                        reg_read_1 <= '1';
                        reg_addr_1 <= ins_s2(8 downto 6);                --RB
                        -- reg_1_val: out std_logic_vector(15 downto 0);
                        reg_read_2 <= '1';
                        reg_addr_2 <= ins_s2(5 downto 3);                 --RC
                        -- reg_2_val: out std_logic_vector(15 downto 0);
                        read_c <= '0';
                        read_z <= '1';
                        z_write <= '1';
                        c_write <= '1';
                        pc_change <= '0';
                        Mem_Write <= '0';
                    else   --ADL
                        reg_write <= '1';
                        reg_write_add <= ins_s2(11 downto 9);           --RA
                        reg_write_val_available <= '0';
                        reg_write_val <= "0000000000000000";
                        reg_read_1 <= '1';
                        reg_addr_1 <= ins_s2(8 downto 6);                --RB
                        -- reg_1_val: out std_logic_vector(15 downto 0);
                        reg_read_2 <= '1';
                        reg_addr_2 <= ins_s2(5 downto 3);                 --RC
                        -- reg_2_val: out std_logic_vector(15 downto 0);
                        read_c <= '0';
                        read_z <= '0';
                        z_write <= '1';
                        c_write <= '1';
                        pc_change <= '0';
                        Mem_Write <= '0';
                    end if;


            when "0001" => -- NDU, NDC, NDZ
                    if(ins_s2(1 downto 0) = "00") then --NDU
                        reg_write <= '1';
                        reg_write_add <= ins_s2(11 downto 9);           --RA
                        reg_write_val_available <= '0';
                        reg_write_val <= "0000000000000000";
                        reg_read_1 <= '1';
                        reg_addr_1 <= ins_s2(8 downto 6);                --RB
                        -- reg_1_val: out std_logic_vector(15 downto 0);
                        reg_read_2 <= '1';
                        reg_addr_2 <= ins_s2(5 downto 3);                 --RC
                        -- reg_2_val: out std_logic_vector(15 downto 0);
                        read_c <= '0';
                        read_z <= '0';
                        z_write <= '1';
                        c_write <= '0';
                        pc_change <= '0';
                        Mem_Write <= '0';
                    elsif (ins_s2(1 downto 0) = "01") then --NDZ
                        reg_write <= '1';
                        reg_write_add <= ins_s2(11 downto 9);           --RA
                        reg_write_val_available <= '0';
                        reg_write_val <= "0000000000000000";
                        reg_read_1 <= '1';
                        reg_addr_1 <= ins_s2(8 downto 6);                --RB
                        -- reg_1_val: out std_logic_vector(15 downto 0);
                        reg_read_2 <= '1';
                        reg_addr_2 <= ins_s2(5 downto 3);                 --RC
                        -- reg_2_val: out std_logic_vector(15 downto 0);
                        read_c <= '0';
                        read_z <= '1';
                        z_write <= '1';
                        c_write <= '0';
                        pc_change <= '0';
                        Mem_Write <= '0';
                    elsif (ins_s2(1 downto 0) = "10") then --NDC
                        reg_write <= '1';
                        reg_write_add <= ins_s2(11 downto 9);           --RA
                        reg_write_val_available <= '0';
                        reg_write_val <= "0000000000000000";
                        reg_read_1 <= '1';
                        reg_addr_1 <= ins_s2(8 downto 6);                --RB
                        -- reg_1_val: out std_logic_vector(15 downto 0);
                        reg_read_2 <= '1';
                        reg_addr_2 <= ins_s2(5 downto 3);                 --RC
                        -- reg_2_val: out std_logic_vector(15 downto 0);
                        read_c <= '1';
                        read_z <= '0';
                        z_write <= '1';
                        c_write <= '0';
                        pc_change <= '0';
                        Mem_Write <= '0';
                    end if;

            when "0101" => -- LW
                    reg_write <= '1';
                    reg_write_add <= ins_s2(11 downto 9);           --RA
                    reg_write_val_available <= '0';
                    reg_write_val <= "0000000000000000";
                    reg_read_1 <= '1';
                    reg_addr_1 <= ins_s2(8 downto 6);                --RB
                    -- reg_1_val: out std_logic_vector(15 downto 0);
                    reg_read_2 <= '0';
                    -- reg_addr_2 <= ins_s2(5 downto 3);                 --RC
                    -- reg_2_val: out std_logic_vector(15 downto 0);
                    read_c <= '0';
                    read_z <= '0';
                    z_write <= '1';
                    c_write <= '0';
                    pc_change <= '0';
                    Mem_Write <= '0';

            when "0111" => -- SW
                    reg_write <= '0';
                    reg_write_add <= ins_s2(11 downto 9);           --RA
                    reg_write_val_available <= '0';
                    reg_write_val <= "0000000000000000";
                    reg_read_1 <= '1';
                    reg_addr_1 <= ins_s2(11 downto 9);                --RA
                    -- reg_1_val: out std_logic_vector(15 downto 0);
                    reg_read_2 <= '1';
                    reg_addr_2 <= ins_s2(8 downto 6);                 --RB
                    -- reg_2_val: out std_logic_vector(15 downto 0);
                    read_c <= '0';
                    read_z <= '0';
                    z_write <= '0';
                    c_write <= '0';
                    pc_change <= '0';
                    Mem_Write <= '1';

            when "1000" => -- BEQ
                    reg_write <= '0';
                    reg_write_add <= ins_s2(11 downto 9);           --RA
                    reg_write_val_available <= '0';
                    reg_write_val <= "0000000000000000";
                    reg_read_1 <= '1';
                    reg_addr_1 <= ins_s2(11 downto 9);                --RA
                    -- reg_1_val: out std_logic_vector(15 downto 0);
                    reg_read_2 <= '0';
                    reg_addr_2 <= ins_s2(8 downto 6);                 --RB
                    -- reg_2_val: out std_logic_vector(15 downto 0);
                    read_c <= '0';
                    read_z <= '0';
                    z_write <= '0';
                    c_write <= '0';
                    pc_change <= '1';
                    Mem_Write <= '0';

            when "1001" => -- JAL
                    reg_write <= '1';
                    reg_write_add <= ins_s2(11 downto 9);           --RA
                    reg_write_val_available <= '0';
                    reg_write_val <= "0000000000000000";
                    reg_read_1 <= '0';
                    -- reg_addr_1 <= ins_s2(8 downto 6);                --RB
                    -- reg_1_val: out std_logic_vector(15 downto 0);
                    reg_read_2 <= '0';
                    -- reg_addr_2 <= ins_s2(5 downto 3);                 --RC
                    -- reg_2_val: out std_logic_vector(15 downto 0);
                    read_c <= '0';
                    read_z <= '0';
                    z_write <= '0';
                    c_write <= '0';
                    pc_change <= '1';
                    Mem_Write <= '0';

            when "1010" => -- JLR
                    reg_write <= '1';
                    reg_write_add <= ins_s2(11 downto 9);           --RA
                    reg_write_val_available <= '0';
                    reg_write_val <= "0000000000000000";
                    reg_read_1 <= '1';
                    reg_addr_1 <= ins_s2(8 downto 6);                --RB
                    -- reg_1_val: out std_logic_vector(15 downto 0);
                    reg_read_2 <= '0';
                    -- reg_addr_2 <= ins_s2(5 downto 3);                 --RC
                    -- reg_2_val: out std_logic_vector(15 downto 0);
                    read_c <= '0';
                    read_z <= '0';
                    z_write <= '0';
                    c_write <= '0';
                    pc_change <= '1';
                    Mem_Write <= '0';

            when "1011" => -- JRI
                    reg_write <= '0';
                    reg_write_add <= ins_s2(11 downto 9);           --RA
                    reg_write_val_available <= '0';
                    reg_write_val <= "0000000000000000";
                    reg_read_1 <= '1';
                    reg_addr_1 <= ins_s2(11 downto 9);                --RA
                    -- reg_1_val: out std_logic_vector(15 downto 0);
                    reg_read_2 <= '0';
                    -- reg_addr_2 <= ins_s2(5 downto 3);                 --RC
                    -- reg_2_val: out std_logic_vector(15 downto 0);
                    read_c <= '0';
                    read_z <= '0';
                    z_write <= '0';
                    c_write <= '0';
                    pc_change <= '1';
                    Mem_Write <= '0';
                    
            when "0000" => -- ADI
                    reg_write <= '1';
                    reg_write_add <= ins_s2(11 downto 9);           --RA
                    reg_write_val_available <= '0';
                    reg_write_val <= "0000000000000000";
                    reg_read_1 <= '1';
                    reg_addr_1 <= ins_s2(8 downto 6);                --RB
                    -- reg_1_val: out std_logic_vector(15 downto 0);
                    reg_read_2 <= '0';
                    -- reg_addr_2 <= ins_s2(5 downto 3);                 --RC
                    -- reg_2_val: out std_logic_vector(15 downto 0);
                    read_c <= '0';
                    read_z <= '0';
                    z_write <= '1';
                    c_write <= '1';
                    pc_change <= '0';
                    Mem_Write <= '0';

            when "0011" => -- LHI
                    reg_write <= '1';
                    reg_write_add <= ins_s2(11 downto 9);           --RA
                    reg_write_val_available <= '0';
                    reg_write_val <= "0000000000000000";
                    reg_read_1 <= '0';
                    -- reg_addr_1 <= ins_s2(8 downto 6);                --RB
                    -- reg_1_val: out std_logic_vector(15 downto 0);
                    reg_read_2 <= '0';
                    -- reg_addr_2 <= ins_s2(5 downto 3);                 --RC
                    -- reg_2_val: out std_logic_vector(15 downto 0);
                    read_c <= '0';
                    read_z <= '0';
                    z_write <= '0';
                    c_write <= '0';
                    pc_change <= '0';
                    Mem_Write <= '0';
            when "1111" => -- last LM SM
                    reg_write <= '0';
                    reg_write_add <= ins_s2(11 downto 9);           --RA
                    reg_write_val_available <= '0';
                    reg_write_val <= "0000000000000000";
                    reg_read_1 <= '0';
                    -- reg_addr_1 <= ins_s2(8 downto 6);                --RB
                    -- reg_1_val: out std_logic_vector(15 downto 0);
                    reg_read_2 <= '0';
                    -- reg_addr_2 <= ins_s2(5 downto 3);                 --RC
                    -- reg_2_val: out std_logic_vector(15 downto 0);
                    read_c <= '0';
                    read_z <= '0';
                    z_write <= '0';
                    c_write <= '0';
                    pc_change <= '0';
                    Mem_Write <= '0';
            
		end case;
	end process;
end architecture;