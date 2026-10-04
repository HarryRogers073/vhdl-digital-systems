--------------------------------------------------------------------------------
-- File:         Adder_Sub.vhd
-- Written by:   Chris Knight (University Coursework Reference, Verified by Harry Rogers)
-- Date:         30 November 2011
-- Description:  VHDL ripple-carry adder-subtractor component implementation
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------ TOP LEVEL ENTITY----------------------
entity C1 is port (
	ina, inb: 	in integer range 0 to 15;
	add_sub : 	in std_logic;
	finalres : 	out integer range 0 to 15);
end C1;
 
 architecture module of C1 is
	component adder
		port 	(a,b: in integer range 0 to 15;
				add_result: out integer range 0 to 15);
	end component;
	
	component subtractor
		port 	(a,b: in integer range 0 to 15;
				sub_result: out integer range 0 to 15);
	end component;	
	
	component mux 
		port 	(muxina,muxinb: in integer range 0 to 15;
				channel : in std_logic;	
				muxout: out integer range 0 to 15);
	end component;	
	
---------------SIGNALS DEFINITIONS-----------	
signal sig1,sig2: 	integer range 0 to 15;
 

---------------INSTANTIATIONS--------------------	
begin
	instance1: adder port map (a=>ina ,b=>inb, add_result=>sig1);
	instance2: subtractor port map (a=>ina, b=>inb, sub_result=>sig2);
instance3: mux port map (muxina=>sig1, muxinb=>sig2, channel=>add_sub, muxout=>finalres);
end module;
