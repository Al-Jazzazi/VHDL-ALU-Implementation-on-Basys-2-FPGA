library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_display is
    Port (
        clk : in STD_LOGIC;
        PI_a : in STD_LOGIC_VECTOR (3 downto 0);
        PI_b : in STD_LOGIC_VECTOR (3 downto 0);
        PI_sel : in STD_LOGIC_VECTOR (2 downto 0);
        PO_seg : out STD_LOGIC_VECTOR (0 to 7);  -- Ensure 8-bit output
        PO_an : out STD_LOGIC_VECTOR (3 downto 0)
    );
end ALU_display;

architecture Behavioral of ALU_display is

    component ALU is
        port (
            a : in STD_LOGIC_VECTOR(3 downto 0);
            b : in STD_LOGIC_VECTOR(3 downto 0);
            sel : in STD_LOGIC_VECTOR(2 downto 0);
            result : out STD_LOGIC_VECTOR(3 downto 0);
            overflow : out STD_LOGIC
        );
    end component;

component single_number is
    port (
        number : in STD_LOGIC_VECTOR(3 downto 0);  -- Ensure this is 'number', not 'num'
        seg : out STD_LOGIC_VECTOR(0 to 7);
		  overflow : in STD_LOGIC

    );
end component;


    signal ALU_result : STD_LOGIC_VECTOR(3 downto 0);
	 signal number: STD_LOGIC_VECTOR(3 downto 0);
    signal ALU_overflow : STD_LOGIC;
    signal seg : STD_LOGIC_VECTOR(0 to 7);  -- 8-bit vector for segment data
    constant cnt_max : integer := 1e5;
    signal clk_cnt : integer range 0 to cnt_max;
    signal seg_mode, seg_mode_new : integer range 0 to 3;

begin

    ALU_inst : ALU
        port map (
            a => PI_a,
            b => PI_b,
            sel => PI_sel,
            result => ALU_result,
            overflow => ALU_overflow
        );

single_number_inst : single_number
    port map (
        number => number,  -- This should match the 'number' port in the entity
        seg => seg,
		  overflow => ALU_overflow
		  
    );


    seg_mode_switch : process (clk)
    begin
        if rising_edge(clk) then
            if (clk_cnt = cnt_max) then
                seg_mode <= seg_mode_new;
                clk_cnt <= 0;
            else
                clk_cnt <= clk_cnt + 1;
            end if;
        end if;
    end process;

    display : process (seg_mode, seg, PI_a, PI_b, ALU_result, ALU_overflow)  -- MODIFICATION: Include ALU_overflow in the sensitivity list
    begin
        case seg_mode is
            when 0 => 
                number <= PI_a;
                PO_an <= "0111";
                PO_seg <= seg;
                seg_mode_new <= 1;
            when 1 => 
                number <= PI_b;
                PO_an <= "1011";
                PO_seg <= seg;
                seg_mode_new <= 2;  -- MODIFICATION: Change from 3 to 2 to insert overflow step
            when 2 =>  -- MODIFICATION: New case for displaying overflow
                if ALU_overflow = '1' then
                    number <= "1111"; -- Overflow indicator, you can decide how you want to represent overflow
						
                else
                    number <= (others => '0'); -- No overflow
                end if;
                PO_an <= "1101"; -- MODIFICATION: Activate the second-from-right display
                PO_seg <= seg;
                seg_mode_new <= 3;
            when 3 => 
                number <= ALU_result;
                PO_an <= "1110";
                PO_seg <= seg;
                seg_mode_new <= 0;
            when others => 
                number <= (others => '0'); -- Safe state
                PO_an <= "1111"; -- Turn off all anodes
                PO_seg <= seg;
        end case;
    end process;

end Behavioral;
