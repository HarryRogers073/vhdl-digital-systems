library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bin2hex is port (
		a : in std_logic_vector (3 downto 0);
		-- s  : buffer integer range 0 to ?; -- NB the pin planner may ask for pins, this can be left blank unless we physically need access to the buffer signals.
		p : out std_logic_vector (6 downto 0)
		);
end bin2hex;

architecture display of bin2hex is
begin
	process(a)
	begin
    case a is
		 when "0000" => p <= "0000001"; -- "0"     
		 when "0001" => p <= "1001111"; -- "1" 
		 when "0010" => p <= "0010010"; -- "2" 
		 when "0011" => p <= "0000110"; -- "3" 
		 when "0100" => p <= "1001100"; -- "4" 
		 when "0101" => p <= "0100100"; -- "5" 
		 when "0110" => p <= "0100000"; -- "6" 
		 when "0111" => p <= "0001111"; -- "7" 
		 when "1000" => p <= "0000000"; -- "8"     
		 when "1001" => p <= "0000100"; -- "9" 
		 when "1010" => p <= "0000010"; -- a
		 when "1011" => p <= "1100000"; -- b
		 when "1100" => p <= "0110001"; -- C
		 when "1101" => p <= "1000010"; -- d
		 when "1110" => p <= "0110000"; -- E
		 when "1111" => p <= "0111000"; -- F
	end case;
end process;
end display;