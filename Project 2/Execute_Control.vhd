library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Execute_Control is
	port(reg_read_1,reg_read_2: in std_logic;
    reg_read_add_1,reg_read_add_2: in std_logic_vector(2 downto 0); 
    reg_1_val_in,reg_2_val_in: in std_logic_vector(15 downto 0);

    MA_reg_write_out:in std_logic;
    MA_reg_write_add:in std_logic_vector(2 downto 0);
    MA_reg_write_val_available_out: in std_logic;
    MA_reg_write_val_out: in std_logic_vector(15 downto 0);
    MA_ins_valid_out: in std_logic;
	pc_val: in std_logic_vector(15 downto 0);

    WB_reg_write_out:in std_logic;
    WB_reg_write_add:in std_logic_vector(2 downto 0);
    WB_reg_write_val_available_out: in std_logic;
    WB_reg_write_val_out: in std_logic_vector(15 downto 0);
    WB_ins_valid_out: in std_logic;

    reg_1_val,reg_2_val: out std_logic_vector(15 downto 0);
    data_stall: out std_logic
       );
end entity;

architecture Execute_Control_arc of Execute_Control is
    signal data_stall1,data_stall2:std_logic;
begin
	process (reg_read_1,reg_read_2,reg_read_add_1,reg_read_add_2,MA_ins_valid_out,MA_reg_write_out,MA_reg_write_add,MA_reg_write_val_out,MA_reg_write_val_available_out
	,WB_ins_valid_out,WB_reg_write_out,WB_reg_write_add,WB_reg_write_val_out,WB_reg_write_val_available_out,reg_1_val_in,reg_2_val_in,pc_val)
	begin
			if (reg_read_1 = '1'and reg_read_2 = '1') then
					if(reg_read_add_1 = "111" and reg_read_add_2 = "111") then
							if(WB_ins_valid_out = '0' and MA_ins_valid_out = '0') then 
								data_stall1 <= '0';
								data_stall2 <= '0';
								reg_1_val <= pc_val;
								reg_2_val <= pc_val;
							else 
								  reg_1_val <= "0000000000000000";
								  reg_2_val <= "0000000000000000";
								  data_stall1 <= '1';
								  data_stall2 <= '1';
							 end if;
					elsif(reg_read_add_1 = "111") then
							if(WB_ins_valid_out = '0' and MA_ins_valid_out = '0') then 
								data_stall1 <= '0';
								reg_1_val <= pc_val;
								if(MA_ins_valid_out = '1' and MA_reg_write_out = '1' and MA_reg_write_add=reg_read_add_2) then
									if(MA_reg_write_val_available_out = '1') then
										 reg_2_val <= MA_reg_write_val_out;
										 data_stall2 <= '0';
									else 
										 reg_2_val <= "000000000000000";
										 data_stall2 <= '1';
									end if;
							    elsif(WB_ins_valid_out = '1' and WB_reg_write_out = '1' and WB_reg_write_add=reg_read_add_2) then
									if(WB_reg_write_val_available_out = '1') then
										 reg_2_val <= WB_reg_write_val_out;
										 data_stall2 <= '0';
									else 
										 reg_2_val <= "000000000000000";
										 data_stall2 <= '1';
									end if;
							    else
									reg_2_val <= reg_2_val_in;
									data_stall2 <= '0';
							    end if;
							else 
								  reg_1_val <= "0000000000000000";
								  reg_2_val <= "0000000000000000";
								  data_stall1 <= '1';
								  data_stall2 <= '1';
							end if;
					 elsif(reg_read_add_2 = "111") then
							if(WB_ins_valid_out = '0' and MA_ins_valid_out = '0') then 
								data_stall2 <= '0';
								reg_2_val <= pc_val;
								if(MA_ins_valid_out = '1' and MA_reg_write_out = '1' and MA_reg_write_add=reg_read_add_1) then
										if(MA_reg_write_val_available_out = '1') then
											 reg_1_val <= MA_reg_write_val_out;
											 data_stall1 <= '0';
										else 
											 reg_1_val <= "000000000000000";
											 data_stall1 <= '1';
										end if;
								  elsif(WB_ins_valid_out = '1' and WB_reg_write_out = '1' and WB_reg_write_add=reg_read_add_1) then
										if(WB_reg_write_val_available_out = '1') then
											 reg_1_val <= WB_reg_write_val_out;
											 data_stall1 <= '0';
										else 
											 reg_1_val <= "000000000000000";
											 data_stall1 <= '1';
										end if;
								  else
										reg_1_val <= reg_1_val_in;
										data_stall1 <= '0';
								  end if;
							else 
								  reg_1_val <= "0000000000000000";
								  reg_2_val <= "0000000000000000";
								  data_stall1 <= '1';
								  data_stall2 <= '1';
							 end if;
                else 
                    if(MA_ins_valid_out = '1' and MA_reg_write_out = '1' and MA_reg_write_add=reg_read_add_1) then
                        if(MA_reg_write_val_available_out = '1') then
                            reg_1_val <= MA_reg_write_val_out;
                            data_stall1 <= '0';
                        else 
                            reg_1_val <= "000000000000000";
                            data_stall1 <= '1';
                        end if;
                    elsif(WB_ins_valid_out = '1' and WB_reg_write_out = '1' and WB_reg_write_add=reg_read_add_1) then
                        if(WB_reg_write_val_available_out = '1') then
                            reg_1_val <= WB_reg_write_val_out;
                            data_stall1 <= '0';
                        else 
                            reg_1_val <= "000000000000000";
                            data_stall1 <= '1';
                        end if;
                    else
                        reg_1_val <= reg_1_val_in;
                        data_stall1 <= '0';
                    end if;

                    if(MA_ins_valid_out = '1' and MA_reg_write_out = '1' and MA_reg_write_add=reg_read_add_2) then
                        if(MA_reg_write_val_available_out = '1') then
                            reg_2_val <= MA_reg_write_val_out;
                            data_stall2 <= '0';
                        else 
                            reg_2_val <= "000000000000000";
                            data_stall2 <= '1';
                        end if;
                    elsif(WB_ins_valid_out = '1' and WB_reg_write_out = '1' and WB_reg_write_add=reg_read_add_2) then
                        if(WB_reg_write_val_available_out = '1') then
                            reg_2_val <= WB_reg_write_val_out;
                            data_stall2 <= '0';
                        else 
                            reg_2_val <= "000000000000000";
                            data_stall2 <= '1';
                        end if;
                    else
                        reg_2_val <= reg_2_val_in;
                        data_stall2 <= '0';
                    end if;

                end if;
            elsif (reg_read_1 = '1') then
                if(reg_read_add_1 = "111") then
                    reg_1_val <= "0000000000000000";
                    data_stall1 <= '1';
                else 
                    if(MA_ins_valid_out = '1' and MA_reg_write_out = '1' and MA_reg_write_add=reg_read_add_1) then
                        if(MA_reg_write_val_available_out = '1') then
                            reg_1_val <= MA_reg_write_val_out;
                            data_stall1 <= '0';
                        else 
                            reg_1_val <= "000000000000000";
                            data_stall1 <= '1';
                        end if;
                    elsif(WB_ins_valid_out = '1' and WB_reg_write_out = '1' and WB_reg_write_add=reg_read_add_1) then
                        if(WB_reg_write_val_available_out = '1') then
                            reg_1_val <= WB_reg_write_val_out;
                            data_stall1 <= '0';
                        else 
                            reg_1_val <= "000000000000000";
                            data_stall1 <= '1';
                        end if;
                    else
                        reg_1_val <= reg_1_val_in;
                        data_stall1 <= '0';
                    end if;
                end if;
                reg_2_val <="0000000000000000";
                data_stall2 <= '0';
            else 
                reg_2_val <="0000000000000000";
                data_stall2 <= '0';
                reg_1_val <="0000000000000000";
                data_stall1 <= '0';
            end if;
	end process;

    process (data_stall1,data_stall2)
	begin
		data_stall <= data_stall1 and data_stall2;
	end process;
	
end architecture;