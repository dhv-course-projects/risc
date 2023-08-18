library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity IITB_RISC is
	port(clk, rst,read_instruction: in std_logic;
	starting_pc: in std_logic_vector(15 downto 0);
	instruction: in std_logic_vector(15 downto 0));
	
end entity;

architecture IITB_RISC_arc of IITB_RISC is
	 
	type memor is array(65535 downto 0) of std_logic_vector(15 downto 0);
	type regist is array(7 downto 0) of std_logic_vector(15 downto 0);
	signal memory: memor;
	signal registers: regist;
	signal ins :std_logic_vector(15 downto 0);
	signal opcode :std_logic_vector(3 downto 0);
	signal carry,zero :std_logic;
	signal STATE,pc,ra_index,rb_index,rc_index,imm_itr,ins_pc : integer := 0;	
	signal add_result : std_logic_vector(17 downto 0);
	signal ra_value, rb_value: std_logic_vector(15 downto 0);
	signal imm6:std_logic_vector(5 downto 0);
	signal imm9:std_logic_vector(8 downto 0);
	signal PHASE : integer := 1;
begin
	process (clk)
	begin
		if(rising_edge(clk)) then
			if(rst = '1') then
				pc <= to_integer(unsigned(starting_pc));
				ins_pc <= to_integer(unsigned(starting_pc));
				registers(7) <= starting_pc;
			end if;
		end if;
	end process;
	
	process (clk)
	begin
		if(rising_edge(clk)) then
			if(rst = '0') then
				if(read_instruction = '1') then
						memory(ins_pc) <= instruction;
						ins_pc <= ins_pc +1;
				else
						if(STATE =0) then
								ins <= memory(pc);
								STATE <= STATE+1;
						elsif(STATE =1) then
								opcode <= ins(15 downto 12);
						elsif(STATE =2) then
								if (PHASE = 1) then
									 ra_value <= registers(to_integer(unsigned(ins(11 downto 9))));
									 rb_value <= registers(to_integer(unsigned(ins(8 downto 6))));
									 rc_index <= to_integer(unsigned(ins(5 downto 3)));
									 PHASE <= PHASE + 1;
								elsif(PHASE = 2) then
									 add_result <= ("00" & ra_value) + ("00" & rb_value);
									 PHASE <= PHASE + 1;
								elsif(PHASE = 3) then
									 registers(rc_index) <= add_result(15 downto 0);
									 carry <= add_result(16);
									 opcode <="1111";
									 pc <= pc +1;
									 registers(7) <= registers(7) + 1;
									 if(add_result(15 downto 0)="0000000000000000") then 
											zero <='1';
									 end if;
									 PHASE <= 1;
								end if;
						elsif(STATE =3) then
								if (PHASE = 1) then
									 ra_value <= registers(to_integer(unsigned(ins(11 downto 9))));
									 rb_value <= registers(to_integer(unsigned(ins(8 downto 6))));
									 rc_index <= to_integer(unsigned(ins(5 downto 3)));
									 PHASE <= PHASE + 1;
								elsif(PHASE = 2) then
									 add_result <= ("00" & ra_value) + ("0" & rb_value & "0");
									 PHASE <= PHASE + 1;
								elsif(PHASE = 3) then
									 registers(rc_index) <= add_result(15 downto 0);
									 carry <= add_result(16) OR add_result(17);
									 opcode <="1111";
									 pc <= pc +1;
									 registers(7) <= registers(7) + 1;
									 if(add_result(15 downto 0)="0000000000000000") then 
											zero <='1';
									 end if;
									 PHASE <= 1;
								end if;
						elsif(STATE =4) then
								if (PHASE = 1) then
									 ra_value <= registers(to_integer(unsigned(ins(11 downto 9))));
									 rb_index <= to_integer(unsigned(ins(8 downto 6)));
									 imm6 <= ins(5 downto 0);
									 PHASE <= PHASE + 1;
								elsif(PHASE = 2) then
									 add_result <= ("00" & ra_value) + ("000000000000" & imm6);
									 PHASE <= PHASE + 1;
								elsif(PHASE = 3) then
									 registers(rb_index) <= add_result(15 downto 0);
									 carry <= add_result(16);
									 opcode <="1111";
									 if(add_result(15 downto 0)="0000000000000000") then 
											zero <='1';
									 end if;
									 PHASE <= 1;
									 pc <= pc+1;
									 registers(7) <= registers(7)+1;
								end if;
								
						elsif(STATE =5) then
								if (PHASE = 1) then
									 ra_value <= registers(to_integer(unsigned(ins(11 downto 9))));
									 rb_value <= registers(to_integer(unsigned(ins(8 downto 6))));
									 rc_index <= to_integer(unsigned(ins(5 downto 3)));
									 PHASE <= PHASE + 1;
								elsif(PHASE = 2) then
									 registers(rc_index) <= ra_value NAND rb_value;
									 opcode <="1111";
									 if((ra_value NAND rb_value)="0000000000000000") then 
											zero <='1';
									 end if;
									 PHASE <= 1;
									 pc <= pc+1;
									 registers(7) <= registers(7)+1;
								end if;
						elsif(STATE =6) then
								if(PHASE =1) then
									imm9 <= ins(8 downto 0);
									ra_index <= to_integer(unsigned(ins(11 downto 9)));
									PHASE <= PHASE + 1;
								elsif(PHASE =2) then
									registers(ra_index) <= imm9 & "0000000";
									PHASE <= 1;
									pc <= pc +1;
									registers(7) <= registers(7) + 1;
								end if;
						elsif(STATE =7) then
								if(PHASE =1) then
									ra_index <= to_integer(unsigned(ins(11 downto 9)));
									rb_value <= registers(to_integer(unsigned(ins(8 downto 6))));
									imm6 <= ins(5 downto 0);
									PHASE <= PHASE + 1;
								elsif(PHASE =2) then
									add_result <= ("00" & rb_value) + ("000000000000" & imm6);
									PHASE <= PHASE + 1;
								elsif(PHASE =3) then
									registers(ra_index) <= memory(to_integer(unsigned(add_result)));
									if(memory(to_integer(unsigned(add_result))) = "0000000000000000") then
										zero <= '0';
									else
										zero <= '1';
									end if;
									PHASE <= 1;
									pc <= pc +1;
									registers(7) <= registers(7) + 1;
								end if;
						elsif(STATE =8) then
								if(PHASE =1) then
									ra_index <= to_integer(unsigned(ins(11 downto 9)));
									rb_value <= registers(to_integer(unsigned(ins(8 downto 6))));
									imm6 <= ins(5 downto 0);
									PHASE <= PHASE + 1;
								elsif(PHASE =2) then
									add_result <= ("00" & rb_value) + ("000000000000" & imm6);
									PHASE <= PHASE + 1;
								elsif(PHASE =3) then
									memory(to_integer(unsigned(add_result))) <= registers(ra_index);
									PHASE <= 1;
									pc <= pc +1;
									registers(7) <= registers(7) + 1;
								end if;
						elsif(STATE =9) then
								if(PHASE =1) then
									ra_value <= registers(to_integer(unsigned(ins(11 downto 9))));
									imm9 <= ins(8 downto 0);
									imm_itr <= 0;
									PHASE <= PHASE + 1;
								elsif(PHASE =2) then
									if(imm_itr =8) then
										PHASE <= 1;
										pc <= pc +1;
										registers(7) <= registers(7) + 1;
									else
										PHASE <= 3;
										if(imm9(7-imm_itr) = '1') then
											registers(imm_itr) <= memory(to_integer(unsigned(ra_value)));
											PHASE <= 4;
										end if;
									end if;
								elsif(PHASE =3) then
									imm_itr <= imm_itr + 1;
									PHASE <= 2;
								elsif(PHASE =4) then
									ra_value <= ra_value + "0000000000000001";
									PHASE <= 3;
								end if;
						elsif(STATE =10) then
								if(PHASE =1) then
									ra_value <= registers(to_integer(unsigned(ins(11 downto 9))));
									imm9 <= ins(8 downto 0);
									imm_itr <= 0;
									PHASE <= PHASE + 1;
								elsif(PHASE =2) then
									if(imm_itr =8) then
										PHASE <= 1;
										pc <= pc +1;
										registers(7) <= registers(7) + 1;
									else
										PHASE <= 3;
										if(imm9(7-imm_itr) = '1') then
											memory(to_integer(unsigned(ra_value))) <= registers(imm_itr);
											PHASE <= 4;
										end if;
									end if;
								elsif(PHASE =3) then
									imm_itr <= imm_itr + 1;
									PHASE <= 2;
								elsif(PHASE =4) then
									ra_value <= ra_value + "0000000000000001";
									PHASE <= 3;
								end if;
						elsif(STATE=11) then
									 if (PHASE = 1) then
									 ra_value <= registers(to_integer(unsigned(ins(11 downto 9))));
									 rb_value <= registers(to_integer(unsigned(ins(8 downto 6))));
									 imm6 <= ins(5 downto 0);
									 elsif(PHASE = 2) then
											if(ra_value = rb_value)	then 
													 registers(7) <=registers(7)+imm6;
													 pc <= to_integer(unsigned(registers(7)+imm6));
											else
													 pc <= pc +1;
													 registers(7) <= registers(7) + 1;
											end if;
									 opcode <="1111";
									 end if;	
						elsif(STATE=12) then
									 if (PHASE = 1) then
									 imm9 <= ins(8 downto 0);
									 ra_index <= to_integer(unsigned(ins(11 downto 9)));
									 elsif(PHASE = 2) then
									 registers(ra_index) <= registers(7)+1;
									 registers(7) <=registers(7)+imm9;
									 pc <= to_integer(unsigned(registers(7)+imm9));
									 opcode <="1111";
									 end if;	
						elsif(STATE=13) then
									 if (PHASE = 1) then
									 rb_value <= registers(to_integer(unsigned(ins(8 downto 6))));
									 ra_index <= to_integer(unsigned(ins(11 downto 9)));
									 elsif(PHASE = 2) then
									 registers(ra_index) <= registers(7)+1;
									 registers(7) <=rb_value;
									 pc <= to_integer(unsigned(rb_value));
									 opcode <="1111";
									 end if;	 
						elsif(STATE=14) then
									 if (PHASE = 1) then
									 ra_value <= registers(to_integer(unsigned(ins(11 downto 9))));
									 imm9 <= ins(8 downto 0);
									 elsif(PHASE = 2) then
									 add_result <=ra_value + ("000000000" & imm9);
									 PHASE <= PHASE + 1;
									 elsif(PHASE = 3) then 
									 registers(7) <= add_result(15 downto 0);
									 pc <= to_integer(unsigned(add_result(15 downto 0)));
									 opcode <="1111";
									 end if;	 
						end if;
				end if;
			end if;
		end if;
		
	end process;
	
	process (opcode)
	begin
		if(opcode = "0001") then 
					if(ins(1) = '0')	then 
							if(ins(0)='0') then
								STATE <= 2;
							elsif(ins(0)='1') then
								if(zero='1') then
									STATE <=2;
								else
									pc	<= pc+1;
									STATE <=0;
								end if;		
							end if;
					elsif(ins(1) = '1')	then 
							if(ins(0)='0') then
								if(carry='1') then
									STATE <=2;
								else
									pc	<= pc+1;
									STATE <=0;
								end if;		
							elsif(ins(0)='1') then
								STATE <=3;
							end if;
					end if;
		elsif(opcode ="0000") then
					STATE <= 4;
		elsif(opcode = "0010") then 
					if(ins(1) = '0')	then 
							if(ins(0)='0') then
								STATE <= 5;
							elsif(ins(0)='1') then
								if(zero='1') then
									STATE <=5;
								else
									pc	<= pc+1;
									STATE <=0;
								end if;		
							end if;
					elsif(ins(1) = '1')	then 
							if(ins(0)='0') then
								if(carry='1') then
									STATE <=5;
								else
									pc	<= pc+1;
									STATE <=0;
								end if;		
							end if;
					end if;
				
		elsif(opcode = "0011") then
					STATE <=	6;
		elsif(opcode = "0101") then
					STATE <=	7;
		elsif(opcode = "0111") then
					STATE <=	8;	
		elsif(opcode = "1101") then
					STATE <=	9;	
		elsif(opcode = "1100") then
					STATE <=	10;	
		elsif(opcode = "1000") then
					STATE <=	11;
		elsif(opcode = "1001") then
					STATE <=	12;	
		elsif(opcode = "1010") then
					STATE <=	13;	
		elsif(opcode = "1011") then
					STATE <=	14;	
		elsif(opcode = "1111") then
					STATE <=0;
		end if;
	end process;



	
end architecture;