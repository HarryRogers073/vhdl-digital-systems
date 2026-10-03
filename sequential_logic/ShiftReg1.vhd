-- 	VHDL implementation of a simple parallel
--	in, serial out 4-bit shift register.
--	Shift direction – right (lsb first)

-- 	Title:			ShiftReg1.vhd
--	Designer:		Chris Knight
--	Date:			07 March 2012
--	Version No:		1
--	Target			DE2 Board - EP4CE115F29C7 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ShiftReg1 is port (
	bin	: in unsigned(3 downto 0);
	sout	: out std_logic;
	shift, load, clock	: in std_logic );
end ShiftReg1;

architecture reg of ShiftReg1 is
	
begin
	Right:	process (clock, bin, load, shift)
		variable temp : unsigned (3 downto 0);
		begin
			if rising_edge(clock) then
				if load = '1' then temp := bin;
				elsif shift = '1' then temp := temp srl 1;
 			    end if;
			end if;
		sout <= temp(0);
	end process Right;
end reg;











we've left

come find us

gone to IO room

wherever ewe did the last report
