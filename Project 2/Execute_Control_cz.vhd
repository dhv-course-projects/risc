library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Execute_Control_cz is
	port(
    MA_z_write_out:in std_logic;
    MA_z_write_val_available_out: in std_logic;
    MA_z_write_val_out: in std_logic;
    MA_c_write_out:in std_logic;
    MA_c_write_val_available_out: in std_logic;
    MA_c_write_val_out: in std_logic;
    MA_ins_valid_out: in std_logic;

    WB_z_write_out:in std_logic;
    WB_z_write_val_available_out: in std_logic;
    WB_z_write_val_out: in std_logic;
    WB_c_write_out:in std_logic;
    WB_c_write_val_available_out: in std_logic;
    WB_c_write_val_out: in std_logic;
    WB_ins_valid_out: in std_logic;

    c_val: in std_logic;
    z_val: in std_logic;

    c_stall: out std_logic;
    c_valid: out std_logic;
    z_stall: out std_logic;
    z_valid: out std_logic
       );
end entity;

architecture Execute_Control_cz_arc of Execute_Control_cz is
begin
	process (MA_z_write_out,MA_z_write_val_available_out,MA_z_write_val_out,MA_c_write_out,MA_c_write_val_available_out,MA_c_write_val_out,MA_ins_valid_out
    ,WB_z_write_out,WB_z_write_val_available_out,WB_z_write_val_out,WB_c_write_out,WB_c_write_val_available_out,WB_c_write_val_out,WB_ins_valid_out,c_val,z_val)
	begin
			if (MA_ins_valid_out='1' and MA_c_write_out = '1') then
					if(MA_c_write_val_available_out='1') then
                        if( MA_c_write_val_out = '1') then
                            c_stall<= '0';
                            c_valid <= '1';
                        else
                            c_stall<= '0';
                            c_valid <= '0';
                        end if;
                    else 
                        c_stall<= '1';
                        c_valid <= '1';
                    end if;
            elsif (WB_ins_valid_out='1' and WB_c_write_out = '1') then
                if(WB_c_write_val_available_out='1') then
                    if( WB_c_write_val_out = '1') then
                        c_stall<= '0';
                        c_valid <= '1';
                    else
                        c_stall<= '0';
                        c_valid <= '0';
                    end if;
                else 
                    c_stall<= '1';
                    c_valid <= '1';
                end if;
            else 
                if(c_val = '1') then
                    c_stall<= '0';
                    c_valid <= '1';
                else
                    c_stall<= '0';
                    c_valid <= '0';
                end if;
            end if;

            if (MA_ins_valid_out='1' and MA_z_write_out = '1') then
                if(MA_z_write_val_available_out='1') then
                    if( MA_z_write_val_out = '1') then
                        z_stall<= '0';
                        z_valid <= '1';
                    else
                        z_stall<= '0';
                        z_valid <= '0';
                    end if;
                else 
                    z_stall<= '1';
                    z_valid <= '1';
                end if;
            elsif (WB_ins_valid_out='1' and WB_z_write_out = '1') then
                if(WB_z_write_val_available_out='1') then
                    if( WB_z_write_val_out = '1') then
                        z_stall<= '0';
                        z_valid <= '1';
                    else
                        z_stall<= '0';
                        z_valid <= '0';
                    end if;
                else 
                    z_stall<= '1';
                    z_valid <= '1';
                end if;
            else 
                if(z_val = '1') then
                    z_stall<= '0';
                    z_valid <= '1';
                else
                    z_stall<= '0';
                    z_valid <= '0';
                end if;
            end if;
	end process;

	
end architecture;