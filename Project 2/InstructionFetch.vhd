library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity InstructionFetch is
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
end entity;

architecture InstructionFetch_arc of InstructionFetch is
	signal stall,artificial_stall: std_logic;
    signal ins_in_s1,ins_out_s2,ins_inter_s3,ins_returnedfromencoder:std_logic_vector(15 downto 0);
    signal imm6:std_logic_vector(5 downto 0);
    signal ins_artificial_fromencoder:std_logic_vector(15 downto 0);
    signal ins_fromencodervalid:std_logic;
    signal ins_addr_in_s1,ins_addr_out_s2:std_logic_vector(15 downto 0);
begin
    ins_addr_in_s1 <= ins_addr_in;
    ins_addr_out <= ins_addr_out_s2;
    ins_in_s1 <= ins_in;
    ins_out<=ins_out_s2;
    stall <=force_stall;
    stall_out <= stall or artificial_stall;
    valid_ins_out <= valid_ins;
	process (clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '1') then
              
            else
               
                if(((stall = '0') and (artificial_stall = '0'))) then
                    ins_addr_in_s1 <= ins_addr_in;
                    ins_addr_out <= ins_addr_out_s2;
                    ins_inter_s3<=ins_in_s1;
                    imm6 <= "000000";
                elsif(stall = '1') then
                else 
                    artificial_stall <= '0';
                    imm6 <= imm6 + 1;
                    ins_inter_s3<=ins_returnedfromencoder;
                   
                end if;
            end if;
        end if;
    end process;
	
    process(ins_inter_s3,ins_fromencodervalid,ins_artificial_fromencoder)
    begin
        if(ins_inter_s3(15 downto 12) = "1101" or ins_inter_s3(15 downto 12) = "1100") then
            if(ins_fromencodervalid = '1') then
                ins_out_s2 <= ins_artificial_fromencoder;
                artificial_stall <= '1';
               
            else 
                ins_out_s2 <= ins_artificial_fromencoder;
                artificial_stall <= '0';
               
            end if;
        else 
           
            artificial_stall <= '0';
            ins_out_s2 <= ins_inter_s3;
        end if;
    end process;

    
end architecture;