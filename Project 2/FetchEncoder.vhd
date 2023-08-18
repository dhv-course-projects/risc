library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Fetch_Encoder is
port(
    ins_inter_s3: in std_logic_vector(15 downto 0);
    imm6: in std_logic_vector(5 downto 0);
    ins_fromencodervalid:out std_logic;
    ins_artificial_fromencoder: out std_logic_vector(15 downto 0);
    ins_returnedfromencoder: out std_logic_vector(15 downto 0)
   );
end entity;

architecture Fetch_Encoder_arc of Fetch_Encoder is
		begin
			process (ins_inter_s3,imm6)
			begin
				case ins_inter_s3(15 downto 11) is
					when "1101" =>
							if (ins_inter_s3(7) = '1') then
								ins_fromencodervalid <= '1';
                                ins_artificial_fromencoder <= "0101" &  "000" & ins_inter_s3(11 downto 9) & imm6;
                                ins_returnedfromencoder <=   ins_inter_s3(15 downto 8) & '0' & ins_inter_s3(6 downto 0);
							elsif (ins_inter_s3(6) = '1') then
								ins_fromencodervalid <= '1';
                                ins_artificial_fromencoder <= "0101" &  "001" & ins_inter_s3(11 downto 9) & imm6;
                                ins_returnedfromencoder <=   ins_inter_s3(15 downto 7) & '0' & ins_inter_s3(5 downto 0);
                            elsif (ins_inter_s3(5) = '1') then
                                    ins_fromencodervalid <= '1';
                                    ins_artificial_fromencoder <= "0101" &  "010" & ins_inter_s3(11 downto 9) & imm6;
                                    ins_returnedfromencoder <=   ins_inter_s3(15 downto 6) & '0' & ins_inter_s3(4 downto 0);
                            elsif (ins_inter_s3(4) = '1') then
                                    ins_fromencodervalid <= '1';
                                    ins_artificial_fromencoder <= "0101" &  "011" & ins_inter_s3(11 downto 9) & imm6;
                                    ins_returnedfromencoder <=   ins_inter_s3(15 downto 5) & '0' & ins_inter_s3(3 downto 0);
                            elsif (ins_inter_s3(3) = '1') then
                                    ins_fromencodervalid <= '1';
                                    ins_artificial_fromencoder <= "0101" &  "100" & ins_inter_s3(11 downto 9) & imm6;
                                    ins_returnedfromencoder <=   ins_inter_s3(15 downto 4) & '0' & ins_inter_s3(2 downto 0);
                            elsif (ins_inter_s3(2) = '1') then
                                    ins_fromencodervalid <= '1';
                                    ins_artificial_fromencoder <= "0101" &  "101" & ins_inter_s3(11 downto 9) & imm6;
                                    ins_returnedfromencoder <=   ins_inter_s3(15 downto 3) & '0' & ins_inter_s3(1 downto 0);
                            elsif (ins_inter_s3(1) = '1') then
                                ins_fromencodervalid <= '1';
                                ins_artificial_fromencoder <= "0101" &  "110" & ins_inter_s3(11 downto 9) & imm6;
                                ins_returnedfromencoder <=   ins_inter_s3(15 downto 2) & '0' & ins_inter_s3(0);
                            elsif (ins_inter_s3(0) = '1') then
                                ins_fromencodervalid <= '1';
                                ins_artificial_fromencoder <= "0101" &  "111" & ins_inter_s3(11 downto 9) & imm6;
                                ins_returnedfromencoder <=   ins_inter_s3(15 downto 1) & '0';
							else
                                ins_fromencodervalid <= '0';
                                ins_artificial_fromencoder <= "1111" &  "111" & ins_inter_s3(11 downto 9) & imm6;
                                ins_returnedfromencoder <=   ins_inter_s3(15 downto 0);
							end if;
                    when "1100" =>
							if (ins_inter_s3(7) = '1') then
								ins_fromencodervalid <= '1';
                                ins_artificial_fromencoder <= "0111" &  "000" & ins_inter_s3(11 downto 9) & imm6;
                                ins_returnedfromencoder <=   ins_inter_s3(15 downto 8) & '0' & ins_inter_s3(6 downto 0);
							elsif (ins_inter_s3(6) = '1') then
								ins_fromencodervalid <= '1';
                                ins_artificial_fromencoder <= "0111" &  "001" & ins_inter_s3(11 downto 9) & imm6;
                                ins_returnedfromencoder <=   ins_inter_s3(15 downto 7) & '0' & ins_inter_s3(5 downto 0);
                            elsif (ins_inter_s3(5) = '1') then
                                    ins_fromencodervalid <= '1';
                                    ins_artificial_fromencoder <= "0111" &  "010" & ins_inter_s3(11 downto 9) & imm6;
                                    ins_returnedfromencoder <=   ins_inter_s3(15 downto 6) & '0' & ins_inter_s3(4 downto 0);
                            elsif (ins_inter_s3(4) = '1') then
                                    ins_fromencodervalid <= '1';
                                    ins_artificial_fromencoder <= "0111" &  "011" & ins_inter_s3(11 downto 9) & imm6;
                                    ins_returnedfromencoder <=   ins_inter_s3(15 downto 5) & '0' & ins_inter_s3(3 downto 0);
                            elsif (ins_inter_s3(3) = '1') then
                                    ins_fromencodervalid <= '1';
                                    ins_artificial_fromencoder <= "0111" &  "100" & ins_inter_s3(11 downto 9) & imm6;
                                    ins_returnedfromencoder <=   ins_inter_s3(15 downto 4) & '0' & ins_inter_s3(2 downto 0);
                            elsif (ins_inter_s3(2) = '1') then
                                    ins_fromencodervalid <= '1';
                                    ins_artificial_fromencoder <= "0111" &  "101" & ins_inter_s3(11 downto 9) & imm6;
                                    ins_returnedfromencoder <=   ins_inter_s3(15 downto 3) & '0' & ins_inter_s3(1 downto 0);
                            elsif (ins_inter_s3(1) = '1') then
                                ins_fromencodervalid <= '1';
                                ins_artificial_fromencoder <= "0111" &  "110" & ins_inter_s3(11 downto 9) & imm6;
                                ins_returnedfromencoder <=   ins_inter_s3(15 downto 2) & '0' & ins_inter_s3(0);
                            elsif (ins_inter_s3(0) = '1') then
                                ins_fromencodervalid <= '1';
                                ins_artificial_fromencoder <= "0111" &  "111" & ins_inter_s3(11 downto 9) & imm6;
                                ins_returnedfromencoder <=   ins_inter_s3(15 downto 1) & '0';
							else
                                ins_fromencodervalid <= '0';
                                ins_artificial_fromencoder <= "1111" &  "111" & ins_inter_s3(11 downto 9) & imm6;
                                ins_returnedfromencoder <=   ins_inter_s3(15 downto 0);
							end if;

					when others =>
                        ins_fromencodervalid <= '0';
                        ins_artificial_fromencoder <= ins_inter_s3(15 downto 0);
                        ins_returnedfromencoder <=   ins_inter_s3(15 downto 0);
	      end case;
			end process;
end architecture;