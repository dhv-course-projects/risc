library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MemoryAccess is
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

end entity;

architecture MemoryAccess_arc of MemoryAccess is

    signal pc_val_in_s1,pc_val_out_s2:std_logic_vector(15 downto 0);

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


   signal mem_addr2,mem_addr1,mem_data1,mem_val1:std_logic_vector(15 downto 0);
   signal mem_write1:std_logic;

begin
    pc_val_in_s1 <= pc_val_in;
    pc_val_out <= pc_val_out_s2;
    mem_addr1 <= mem_addr_in;
    mem_data <= mem_data1;
    mem_val1 <= mem_val;
    mem_write <= mem_write1;

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
    mem_addr_out <= mem_addr2;

	process (clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '1') then
              
            else
                    pc_val_out_s2 <= pc_val_in_s1;
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
                    mem_addr2 <= mem_addr1;
            end if;
        end if;
    end process;
    
    process(opcode_out_s2,cz_out_s2,mem_val1,mem_write_val_out_s2)
	begin
		case opcode_out_s2 is
			when "0001" => -- ADD,ADC,ADZ,ADL
                mem_addr2 <= "0000000000000000";
                mem_data1 <= "0000000000000000";
                mem_write1 <= '0';


            when "0001" => -- NDU, NDC, NDZ
                mem_addr2 <= "0000000000000000";
                mem_data1 <= "0000000000000000";
                mem_write1 <= '0';
            when "0101" => -- LW
                if(valid_ins_out_s2 = '1') then 
                    reg_write_val_available_out_s2 <= '0'; 
                    z_val_available_out_s2 <= '0';      
                    reg_write_val_out_s2 <= mem_val1;
                    if(mem_val1 = "0000000000000000") then
                        z_val_out_s2 <= '1';
                    else 
                        z_val_out_s2 <= '0';
                    end if;
                    mem_data1 <= "0000000000000000";
                    mem_write1 <= '0';
                else 
                    mem_addr2 <= "0000000000000000";
                    mem_data1 <= "0000000000000000";
                    mem_write1 <= '0';
                end if;
                
            when "0111" => -- SW
                    if(valid_ins_out_s2 = '1') then 
                            mem_data1 <= mem_write_val_out_s2;
                            mem_write1 <= '1';
                    else 
                        mem_addr2 <= "0000000000000000";
                        mem_data1 <= "0000000000000000";
                        mem_write1 <= '0';
                    end if;
                   

            when "1000" => -- BEQ
                    mem_addr2 <= "0000000000000000";
                    mem_data1 <= "0000000000000000";
                    mem_write1 <= '0';

            when "1001" => -- JAL
                    mem_addr2 <= "0000000000000000";
                    mem_data1 <= "0000000000000000";
                    mem_write1 <= '0';

            when "1010" => -- JLR
                    mem_addr2 <= "0000000000000000";
                    mem_data1 <= "0000000000000000";
                    mem_write1 <= '0';

            when "1011" => -- JRI
                    mem_addr2 <= "0000000000000000";
                    mem_data1 <= "0000000000000000";
                    mem_write1 <= '0';
                    
            when "0000" => -- ADI
                    mem_addr2 <= "0000000000000000";
                    mem_data1 <= "0000000000000000";
                    mem_write1 <= '0';

            when "0011" => -- LHI
                    mem_addr2 <= "0000000000000000";
                    mem_data1 <= "0000000000000000";
                    mem_write1 <= '0';
            when "1111" => -- last LM SM
                    mem_addr2 <= "0000000000000000";
                    mem_data1 <= "0000000000000000";
                    mem_write1 <= '0';
		end case;
	end process;
end architecture;