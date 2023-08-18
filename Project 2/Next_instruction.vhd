library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Next_instruction is
	port(clk,rst:in std_logic;
        change_instruction:in std_logic;
        add_branch:in std_logic;
        branch_from: in std_logic_vector(15 downto 0);
        branch_to:in std_logic_vector(15 downto 0);
        branch_taken:in std_logic;
        insadd_out:out std_logic_vector(15 downto 0);
        not_valid_all:out std_logic);
end entity;

architecture Next_instruction_arc of Next_instruction is
    type addr is array(3000 downto 0) of std_logic_vector(15 downto 0);
	signal b_from: addr:= (x"0000",others => x"0000");
    signal b_to: addr:= (x"0000",others => x"0000");
    signal prev_state :std_logic_vector(3000 downto 0);
    signal total_count,change: integer := 0;
    signal curr_ins_add:std_logic_vector(15 downto 0);
    signal curr_ins_presentinstorage:std_logic;
    signal curr_ins_branchto:std_logic_vector(15 downto 0);
    signal curr_ins_prev_state:std_logic;
    signal present: std_logic;
    signal force_next:std_logic;
    signal force_next_add: std_logic_vector(15 downto 0);
begin
    insadd_out <= curr_ins_add;
    process (clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '1') then
              
            else
                if(change_instruction = '1') then
                        if(force_next <= '1') then 
                            curr_ins_add <= force_next_add;
                            force_next <='0';
                            curr_ins_presentinstorage <= '0';
                        else
                            curr_ins_presentinstorage <= '0';
                            if(curr_ins_presentinstorage = '1') then
                                if(curr_ins_prev_state = '1') then
                                    curr_ins_add <= curr_ins_branchto;
                                else 
                                    curr_ins_add <= curr_ins_add +1;
                                end if;
                            else 
                                    curr_ins_add <= curr_ins_add +1;
                            end if;
                        end if;
				end if;
			end if;
		end if;
    end process;

	process(curr_ins_add,b_from,b_to,prev_state)
    begin
        search:
        for i in 0 to total_count-1 loop
		    if(b_from(i)= curr_ins_add) then
                curr_ins_presentinstorage <= '1';
                curr_ins_branchto <= b_to(i);
                curr_ins_prev_state <= prev_state(i);
            end if;   
	    end loop;
    end process;

    process(add_branch)
    begin
        if( add_branch = '1') then 
            search_to_add:
            for i in 0 to total_count-1 loop
                if(b_from(i)= branch_from) then
                    present <= '1';
                    if(branch_taken= '1') then 
                        b_to(i) <= branch_to;
                    end if;
                    if((prev_state(i)='0' and  branch_taken ='0') or ( prev_state(i)='1' and  branch_taken ='1' and b_to(i) = branch_to)) then
                        present <= '1';
                    else 
                        if(branch_taken = '1') then
                            not_valid_all <= '1';
                            present <= '1';
                            force_next <= '1';
                            force_next_add <= b_to(i);
                        else
                            not_valid_all <= '1';
                            present <= '1';
                            force_next <= '1';
                            force_next_add <= b_from(i)+1;
                        end if;
							end if;
                end if;   
            end loop;

            if(change = 20) then 
                change <= 1;
            else 
                change <= change +1;
            end if;
        end if;

       

    end process;

    process(change)
    begin
        if(present = '0') then
                b_from(total_count) <= branch_from;
                b_to(total_count) <= branch_to;
                prev_state(total_count) <= branch_taken;
                total_count <= total_count + 1;
        else 
            present <= '0';
        end if;
    end process;
end architecture;