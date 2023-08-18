library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity InstructionFetch is
	port( clk,rst:in std_logic;
    ins_in: in std_logic_vector(15 downto 0);
    valid_ins_out: out std_logic);
    ins_out: out std_logic_vector(15 downto 0);
end entity;

architecture InstructionFetch_arc of InstructionFetch is
	signal stall,artificial_stall: std_logic;
    signal ins_in_s1,ins_out_s2,ins_inter_s3,ins_returnedfromencoder:std_logic_vector(15 downto 0);
    signal imm6:std_logic_vector(5 downto 0);
    signal ins_artificial_fromencoder:std_logic_vector(15 downto 0);
    signal ins_fromencodervalid:std_logic;
begin
    ins_in_s1 <= ins_in;
    ins_out<=ins_in_s2;

	process (clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '1') then
              
            else
                if((not stall) and (not artificial stall) = '1') then
                    ins_inter_s3<=ins_in_s1;
                    imm6 <= "000000";
                else if(stall = '1') then
                else 
                    imm6 <= imm6 + 1;
                    ins_inter_s3<=ins_returned_fromencoder;
                   
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
                valid_ins_out <= '1';
            else 
                ins_out_s2 <= ins_inter_s3;
                artificial_stall <= '0';
                valid_ins_out <= '0';
            end if;
        else 
            valid_ins_out <= '1';
            artificial_stall <= '0';
            ins_out_s2 <= ins_inter_s3;
        end if;
    end process;

    
end architecture;