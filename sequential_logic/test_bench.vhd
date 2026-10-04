--------------------------------------------------------------------------------
-- File:         test_bench.vhd
-- Written by:   Harry Rogers
-- Date:         November 2022
-- Description:  Behavioral simulation testbench for shift register
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_bench is
end test_bench;

architecture test of test_bench is
	signal clk,sh,ld,serialout: std_logic;
	signal parallelin: unsigned(3 downto 0);
	
	constant clk_period : time := 50ns;
	
begin
	instance1:	entity work.ShiftReg1
	port map (clock=>clk, shift=>sh, load=>ld, 
	sout=>serialout, bin=>parallelin);

clock_process: process
begin
		clk <='0';
		wait for clk_period/2;
		clk <='1';
		wait for clk_period/2;
end process;

stimulation: process
begin
		ld<='0';
		sh<='0';
		parallelin<="0000";
		wait for clk_period*2;
		parallelin<="1011";
		ld<='1';
		wait for clk_period*2;
		ld<='0';
		wait for clk_period*1;
		sh<='1';
		wait for clk_period*5;
		wait;
end process;
end;
	`