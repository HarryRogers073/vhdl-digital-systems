--------------------------------------------------------------------------------
-- Module Name:   bitMultip.vhd
-- Description:   2-bit combinational binary multiplier
-- Author:        Harry Rogers (University of Brighton)
-- Date:          2022
-- Target Board:  Altera DE2 / Cyclone FPGA
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity bitMultip is port(

		A0,B0,A1,B1	: in std_logic;
		C1,C2,C3,C0 : out std_logic);
		
end bitMultip;

architecture gate_level of bitMultip is

begin

C0 <= (A0 and B0);
C1 <= ((A1 and B0) xor (A0 and B1));
C2 <= ((B1 and A1) xor ((A1 and B0) and (A0 and B1)));
C3 <= ((B1 and A1) and ((A1 and B0) and (A0 and B1)));

end gate_level;