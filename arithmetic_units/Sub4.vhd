--------------------------------------------------------------------------------
-- Module Name:   Sub4.vhd
-- Description:   4-bit binary subtractor
-- Author:        Harry Rogers (University of Brighton)
-- Date:          2022
-- Target Board:  Altera DE2 / Cyclone FPGA
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Sub4 is port (
		a,b: in integer range 0 to 15;
		r: out integer range -15 to 15;
		t	: buffer std_logic);
end Sub4;

architecture Subtract of Sub4 is
begin
		r<=a - b;
	
		--t <= '1' when (r == 0)
		--else '0';
		
	
end Subtract;