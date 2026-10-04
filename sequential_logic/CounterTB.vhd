--------------------------------------------------------------------------------
-- File:         CounterTB.vhd
-- Written by:   Harry Rogers
-- Date:         November 2022
-- Description:  Behavioral simulation testbench for binary counter
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CounterTB is
end CounterTB;

architecture test of CounterTB is
	signal clrTB,clkTB: std_logic;
	signal boutTB: unsigned(2 downto 0);
	constant clk_period : time := 40ns;
	
begin
	instance1:	entity work.Counter
	port map (clr=>clrTB, clk=>clkTB, bout=>boutTB);

clock_process: process
begin
		clkTB <='0';
		wait for clk_period/4;
		clkTB <='1';
		wait for clk_period/4;
end process;

stimulation: process
begin
		clrTB<='0';
		wait for clk_period*1.75;
		clrTB<='1';
		wait for clk_period*10;
		clrTB<='0';
		wait;
end process;
end;
