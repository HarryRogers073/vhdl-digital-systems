--------------------------------------------------------------------------------
-- File:         Counter.vhd
-- Written by:   Chris Knight (University Coursework Reference, Verified by Harry Rogers)
-- Date:         23 February 2012
-- Description:  2-bit synchronous binary up-counter reference implementation
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is port (
	bout	: inout unsigned(2 downto 0);
	clk, clr	: in std_logic );
end counter;

architecture bin_up of counter is
begin
count:	
	process (clk,clr)
		begin
			if rising_edge(clk) then
				bout <= bout + "001";
			end if;
			if clr = '0' then
				bout <= "000";
			end if;
		end process count;
end bin_up;
