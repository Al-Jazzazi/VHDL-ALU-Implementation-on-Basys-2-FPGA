library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity single_number is
    Port (
        number : in STD_LOGIC_VECTOR(3 downto 0);  -- This must be 'number'
        seg : out STD_LOGIC_VECTOR(0 to 7);
        overflow : in STD_LOGIC  -- Input to indicate overflow
    );
end single_number;

architecture Behavioral of single_number is

begin

    -- Process to control the 'seg' output based on 'number' input and 'overflow' status
    seg_logic: process(number, overflow)
    begin
        if overflow = '1' then
            case number is
                when "0000" => seg <= "00000011"; -- 0
                when "0001" => seg <= "10011111"; -- 1 
                when "0010" => seg <= "00100101"; -- 2
                when "0011" => seg <= "00001101"; -- 3
                when "0100" => seg <= "10011001"; -- 4
                when "0101" => seg <= "01001001"; -- 5
                when "0110" => seg <= "01000001"; -- 6
                when "0111" => seg <= "00011111"; -- 7
                when "1000" => seg <= "00000000"; -- -8
                when "1001" => seg <= "00011110"; -- -7
                when "1010" => seg <= "01000000"; -- -6 (A displayed for decimal 10)
                when "1011" => seg <= "01001000"; -- -5 (b displayed for decimal 11)
                when "1100" => seg <= "10011000"; -- -4 (C displayed for decimal 12)
                when "1101" => seg <= "00001100"; -- -3 (d displayed for decimal 13)
                when "1110" => seg <= "00100100"; -- -2 interpreted as 14 (E displayed for decimal 14)
                when "1111" => seg <= "00011101"; -- -1 interpreted as 15
                when others => seg <= "11111111"; -- all off, used as default for undefined inputs
            end case;
        else
            -- When there is no overflow, display the number based on the input
            case number is
                when "0000" => seg <= "00000011"; -- 0
                when "0001" => seg <= "10011111"; -- 1 
                when "0010" => seg <= "00100101"; -- 2
                when "0011" => seg <= "00001101"; -- 3
                when "0100" => seg <= "10011001"; -- 4
                when "0101" => seg <= "01001001"; -- 5
                when "0110" => seg <= "01000001"; -- 6
                when "0111" => seg <= "00011111"; -- 7
                when "1000" => seg <= "00000000"; -- -8
                when "1001" => seg <= "00011110"; -- -7
                when "1010" => seg <= "01000000"; -- -6 (A displayed for decimal 10)
                when "1011" => seg <= "01001000"; -- -5 (b displayed for decimal 11)
                when "1100" => seg <= "10011000"; -- -4 (C displayed for decimal 12)
                when "1101" => seg <= "00001100"; -- -3 (d displayed for decimal 13)
                when "1110" => seg <= "00100100"; -- -2 interpreted as 14 (E displayed for decimal 14)
                when "1111" => seg <= "10011110"; -- -1 interpreted as 15
                when others => seg <= "11111111"; -- all off, used as default for undefined inputs
            end case;
        end if;
    end process;

end Behavioral;
