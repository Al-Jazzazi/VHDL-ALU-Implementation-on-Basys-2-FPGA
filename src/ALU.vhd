library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port (
        a : in STD_LOGIC_VECTOR(3 downto 0);
        b : in STD_LOGIC_VECTOR(3 downto 0);
        sel : in STD_LOGIC_VECTOR(2 downto 0);
        result : out STD_LOGIC_VECTOR(3 downto 0);
        overflow : out STD_LOGIC
    );
end ALU;


architecture Behavioral of ALU is

begin

    with sel select result <=
        std_logic_vector(signed(a) + signed(b)) when "000",
        std_logic_vector(signed(a) - signed(b)) when "001",
        std_logic_vector(signed(a) and signed(b)) when "010",
        std_logic_vector(signed(a) or signed(b)) when "011",
        std_logic_vector(rotate_right(unsigned(a), to_integer(unsigned(b(2 downto 0))))) when "100",
        std_logic_vector(shift_left(signed(a), to_integer(unsigned(b(2 downto 0))))) when "101",
        std_logic_vector(shift_right(unsigned(a), to_integer(unsigned(b(2 downto 0))))) when "110",
        std_logic_vector(shift_right(signed(a), to_integer(unsigned(b(2 downto 0))))) when "111",
        (others => 'X') when others;
		  
		  
		      overflow_logic: process(a, b, sel)
    begin
        overflow <= '0'; -- default no overflow
        case sel is
            when "000" =>  -- Addition
                if (signed(a) > 0 and signed(b) > 0 and signed(a) + signed(b) < 0) then
                    overflow <= '1';
                elsif (signed(a) < 0 and signed(b) < 0 and signed(a) + signed(b) >= 0) then
                    overflow <= '1';
                end if;
            when "001" =>  -- Subtraction
                if (signed(a) > 0 and signed(b) < 0 and signed(a) - signed(b) < 0) then
                    overflow <= '1';
                elsif (signed(a) < 0 and signed(b) > 0 and signed(a) - signed(b) > 0) then
                    overflow <= '1';
                end if;
            when others =>
                overflow <= '0';  -- No overflow for other operations
        end case;
    end process;

end Behavioral;
