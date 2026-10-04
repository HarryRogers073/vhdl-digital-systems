--------------------------------------------------------------------------------
-- File:         ShiftReg1.vhd
-- Written by:   Chris Knight (University Coursework Reference, Verified by Harry Rogers)
-- Date:         07 March 2012
-- Description:  4-bit parallel-in serial-out shift register reference implementation
--------------------------------------------------------------------------------

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
