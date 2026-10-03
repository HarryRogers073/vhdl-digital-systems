library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Comp4 is port (
		a,b	: in std_logic_vector(3 downto 0);	
		x,y	: buffer std_logic);
		
end Comp4;

architecture Comp of Comp4 is
begin
		
		x<= '1' when a > b
		else '0';
		
		y <= not x;
		
end Comp;
