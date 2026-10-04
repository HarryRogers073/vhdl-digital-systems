--------------------------------------------------------------------------------
-- University of Brighton Coursework Reference Module
-- Designer:      Chris Knight
-- Context:       Digital Systems Design Lab Material
--------------------------------------------------------------------------------
-- VHDL implementation of a synchronous  
--	2-bit binary up-counter with a  
--	synchronous clear input

-- Title:			counter.vhd
--	Designer:		Chris Knight
--	Date:			23 February 2012
--	Version No:		1
--	Target			DE2-115 CycloneIV EP4CE115F29C7 

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
