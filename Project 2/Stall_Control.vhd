library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Stall_Control is
	port(clk,rst:in std_logic;
    stall_IF,stall_ID,stall_EX:in std_logic;
    not_valid_all:in std_logic;
    valid_IF,valid_ID:out std_logic;
    forcestall_IF,forcestall_ID:out std_logic
    );
end entity;

architecture Stall_Control_arc of Stall_Control is
begin
	process (not_valid_all,stall_IF,stall_ID,stall_EX)
    begin 
        if(not_valid_all = '1') then
            valid_IF <='0';
            valid_ID <='0';
        else 
            valid_IF <='1';
            valid_ID <='1';
        end if;
    end process;

	process (clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '1') then
              
            else
                valid_IF <= '1';
                valid_ID <= '1';
                
               
                forcestall_ID <= '0';
                forcestall_IF <= '0';
         
            end if;
        end if;
    end process;
	
    process(stall_ID,stall_EX)
    begin
        forcestall_ID <=  stall_EX ;
        forcestall_IF <= stall_EX or stall_ID;
    end process;
end architecture;