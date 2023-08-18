library std;
use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;

entity Testbench is
end entity;
architecture Behave of Testbench is
  ----------------------------------------------------------------
  --  edit the following lines to set the number of i/o's of your
  --  DUT.
  ----------------------------------------------------------------
  constant number_of_inputs  : integer := 0;  -- # input bits to your design.
  constant number_of_outputs : integer := 0;  -- # output bits from your design.
  ----------------------------------------------------------------
  ----------------------------------------------------------------
  -- Note that you will have to wrap your design into the DUT
  -- as indicated in class.
  
component Top_entity is
	port(reset,clock:in std_logic);
end component;
  constant NO_CLOCK_CYCLES : integer := 200;
  signal clk, rst: std_logic;
  signal input_vector  : std_logic_vector(number_of_inputs-1 downto 0);
--  signal output_vector : std_logic_vector(number_of_outputs-1 downto 0);
  -- bit-vector to std-logic-vector and vice-versa
  function to_std_logic_vector(x: bit_vector) return std_logic_vector is
     alias lx: bit_vector(1 to x'length) is x;
     variable ret_val: std_logic_vector(1 to x'length);
  begin
     for I in 1 to x'length loop
        if(lx(I) = '1') then
          ret_val(I) := '1';
        else
          ret_val(I) := '0';
        end if;
     end loop; 
     return ret_val;
  end to_std_logic_vector;
  function to_bit_vector(x: std_logic_vector) return bit_vector is
     alias lx: std_logic_vector(1 to x'length) is x;
     variable ret_val: bit_vector(1 to x'length);
  begin
     for I in 1 to x'length loop
        if(lx(I) = '1') then
          ret_val(I) := '1';
        else
          ret_val(I) := '0';
        end if;
     end loop; 
     return ret_val;
  end to_bit_vector;

begin
	
	dut_Instance: Top_entity
		port map (rst,clk);
	
	clk_process :process
		 variable CURRENT_CLOCK_CYCLE: integer := 0;
	begin
		while CURRENT_CLOCK_CYCLE < NO_CLOCK_CYCLES loop
			clk <= '0';
			wait for 0.5 sec;
			clk <= '1';
			wait for 0.5 sec;
			CURRENT_CLOCK_CYCLE := CURRENT_CLOCK_CYCLE + 1;
		end loop;
		wait;
	end process;
	
	rst_process :process
	begin
		rst <= '1';
		wait for 1 sec;
		rst <= '0';
		wait;
	end process;

	

  
end Behave;