library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock_div1 is
	generic (divide_ratio:integer:=50000000);
	port (
	clkin: std_logic;
	slowclk: inout std_logic;
	bout: buffer integer range 0 to 255;
	seven_seg: buffer std_logic_vector(6 downto 0);
	seven_seg2: buffer std_logic_vector(6 downto 0);
	seven_seg3: buffer std_logic_vector(6 downto 0));
end clock_div1;


--https://stackoverflow.com/questions/14493625/vhdl-incrementing-register-value-on-push-button-event

architecture divider of clock_div1 is
begin
	process (clkin)
		variable count : integer range 0 to divide_ratio;
		
	begin

		if rising_edge(clkin)then	
			count := count + 1;
			if count < divide_ratio/2 then
				slowclk <= '0';
			elsif count < divide_ratio then	
				slowclk <= '1';
			else count := 0;
			end if;		
		end if;
end process;

	process(slowclk)
		variable binary: integer range 0 to 255:= 0;	
		
	begin 
		
		if rising_edge(slowclk) then
			binary :=binary + 1;
		end if;
		
	bout <= binary;

end process;

process(bout)
    variable bout_upper : std_logic_vector(3 downto 0);
    variable digit_count : integer := 0;
begin
    case bout_upper is
        when "0000" =>
            seven_seg <= "0000001";
        when "0001" =>
            seven_seg <= "1001111";
        when "0010" =>
            seven_seg <= "0010010";
        when "0011" =>
            seven_seg <= "0000110";
        when "0100" =>
            seven_seg <= "1001100";
        when "0101" =>
            seven_seg <= "0100100";
        when "0110" =>
            seven_seg <= "0100000";
        when "0111" =>
            seven_seg <= "0001111";
        when "1000" =>
            seven_seg <= "0000000";
        when "1001" =>
            seven_seg <= "0000100";
        when others =>
            seven_seg <= "1110111"; -- Default value for other cases
    end case;

    -- Increment the digit_count for the next digit
    digit_count := (digit_count + 1) mod 10;

    case digit_count is
        when 0 =>
            seven_seg2 <= "0000001";
        when 1 =>
            seven_seg2 <= "1001111";
        when 2 =>
            seven_seg2 <= "0010010";
        when 3 =>
            seven_seg2 <= "0000110";
        when 4 =>
            seven_seg2 <= "1001100";
        when 5 =>
            seven_seg2 <= "0100100";
        when 6 =>
            seven_seg2 <= "0100000";
        when 7 =>
            seven_seg2 <= "0001111";
        when 8 =>
            seven_seg2 <= "0000000";
        when 9 =>
            seven_seg2 <= "0000100";
        when others =>
            seven_seg2 <= "1110111"; -- Default value for other cases
    end case;

    -- Reset digit_count after reaching 9
    if digit_count = 9 then
        digit_count := 0;
    end if;

    -- Similar logic for the third digit
    case digit_count is
        when 0 =>
            seven_seg3 <= "0000001";
        when 1 =>
            seven_seg3 <= "1001111";
        when 2 =>
            seven_seg3 <= "0010010";
        when 3 =>
            seven_seg3 <= "0000110";
        when 4 =>
            seven_seg3 <= "1001100";
        when 5 =>
            seven_seg3 <= "0100100";
        when 6 =>
            seven_seg3 <= "0100000";
        when 7 =>
            seven_seg3 <= "0001111";
        when 8 =>
            seven_seg3 <= "0000000";
        when 9 =>
            seven_seg3 <= "0000100";
        when others =>
            seven_seg3 <= "1110111"; -- Default value for other cases
    end case;

end process;








end divider;
