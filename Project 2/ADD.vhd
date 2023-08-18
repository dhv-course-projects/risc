library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ADD is
	port(
        A: in std_logic_vector(15 downto 0);
        B: in std_logic_vector(15 downto 0);
        S: out std_logic_vector(15 downto 0);
        cin: in std_logic; 
        cout: out std_logic
    );
end entity;

architecture ADD_arc of ADD is
    signal c: std_logic_vector(15 downto 0);

    component ADD_4bit is
        port(
            a: in std_logic_vector(3 downto 0);
            b: in std_logic_vector(3 downto 0);
            s: out std_logic_vector(3 downto 0);
            cin: in std_logic; 
            cout: out std_logic
        );
    end component;    

begin
	
	ADD_4bit0: ADD_4bit
        port map(
            a => a(3 downto 0),
            b => b(3 downto 0),
            s => s(3 downto 0),
            cin => cin,
            cout => c(0)
        );

    ADD_4bit1: ADD_4bit
        port map(
            a => a(7 downto 4),
            b => b(7 downto 4),
            s => s(7 downto 4),
            cin => c(0),
            cout => c(1)
        );

    ADD_4bit2: ADD_4bit
        port map(
            a => a(11 downto 8),
            b => b(11 downto 8),
            s => s(11 downto 8),
            cin => c(1),
            cout => c(2)
        );

    ADD_4bit3: ADD_4bit
        port map(
            a => a(15 downto 12),
            b => b(15 downto 12),
            s => s(15 downto 12),
            cin => c(2),
            cout => cout
        );

end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder is
	port(
        a: in std_logic;
        b: in std_logic;
        s: out std_logic;
        cin: in std_logic; 
        cout: out std_logic
    );
end entity;

architecture full_adder_arc of full_adder is

begin
	
	s <= a xor b xor cin;
    cout <= (a and b) or (a and cin) or (b and cin);

end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ADD_4bit is
	port(
        a: in std_logic_vector(3 downto 0);
        b: in std_logic_vector(3 downto 0);
        s: out std_logic_vector(3 downto 0);
        cin: in std_logic; 
        cout: out std_logic
    );
end entity;

architecture ADD_4bit_arc of ADD_4bit is
    signal c: std_logic_vector(2 downto 0);

    component full_adder is
		port(
            a: in std_logic;
            b: in std_logic;
            s: out std_logic;
            cin: in std_logic; 
            cout: out std_logic
        );
	end component;

begin
	
	full_adder0: full_adder
        port map(
            a => a(0),
            b => b(0),
            s => s(0),
            cin => cin,
            cout => c(0)
        );

    full_adder1: full_adder
        port map(
            a => a(1),
            b => b(1),
            s => s(1),
            cin => c(0),
            cout => c(1)
        );

    full_adder2: full_adder
        port map(
            a => a(2),
            b => b(2),
            s => s(2),
            cin => c(1),
            cout => c(2)
        );

    full_adder3: full_adder
        port map(
            a => a(3),
            b => b(3),
            s => s(3),
            cin => c(2),
            cout => cout
        );

end architecture;