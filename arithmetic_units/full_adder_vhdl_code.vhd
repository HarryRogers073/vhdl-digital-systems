--------------------------------------------------------------------------------
-- Module Name:   full_adder_vhdl_code.vhd
-- Description:   Structural 1-bit binary full adder
-- Author:        Harry Rogers (University of Brighton)
-- Date:          2022
-- Target Board:  Altera DE2 / Cyclone FPGA
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity full_adder_vhdl_code is port(

		A0,B0,A1,B1	: in std_logic;
		S0,S1,Cout : out std_logic);
		
end full_adder_vhdl_code;

architecture gate_level of full_adder_vhdl_code is

begin

S0 <= (A0 xor B0);
S1 <= ((A0 and B0) xor (A1 xor B1));
Cout <= ((A1 and B1) or ((A1 xor B1) and (A0 and B0)));

end gate_level;


--A0 : in STD_LOGIC;
--B0 : in STD_LOGIC;
--A1: in STD_LOGIC;
--B1 : in STD_LOGIC;
--S0 : out STD_LOGIC;
--S1 : out STD_LOGIC;
--Cout : out STD_LOGIC)