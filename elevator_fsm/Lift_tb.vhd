--------------------------------------------------------------------------------
-- Module Name:   Lift_tb.vhd
-- Description:   Behavioral simulation testbench for Lift.vhd
-- Author:        Harry Rogers (University of Brighton)
-- Date:          2022
-- Target Board:  Altera DE2 / Cyclone FPGA
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Lift_tb is
end Lift_tb;

architecture behavior of Lift_tb is
    
    -- Declaring input signals for the test bench
signal clk_in_tb : std_logic := '0';
signal emergency_tb : std_logic := '0';
signal outside_lift_buttons_tb : std_logic_vector(5 downto 0) := (others => '0');
signal inside_lift_buttons_tb : std_logic_vector(3 downto 0) := (others => '0');

-- Declaring output signals for the test bench
signal slow_clk_tb : std_logic := '0'; -- Initialized to '0', can be changed as per your design's need
signal door_leds_tb : std_logic_vector(2 downto 0) := (others => '0'); -- Assuming initial state is '0'
signal lift_leds_tb : std_logic_vector(3 downto 0) := (others => '0'); -- Assuming initial state is '0'

-- Clock period definition for the simulation
    constant clk_period_tb : time := 10 ns;
	 
begin
    -- Instantiate the Unit Under Test (UUT)
    instance1: entity work.Lift 
        port map (
            clk_in => clk_in_tb,
            slow_clk => slow_clk_tb,
            emergency => emergency_tb,
            door_leds => door_leds_tb,
            lift_leds => lift_leds_tb,
            outside_lift_buttons => outside_lift_buttons_tb,
            inside_lift_buttons => inside_lift_buttons_tb
        );

    -- Clock generation process for the simulation
    clk_process : process is
    begin
        clk_in_tb <= '0';
        wait for clk_period_tb/2;
        clk_in_tb <= '1';
        wait for clk_period_tb/2;
    end process;

    -- Testbench process to simulate inputs and check outputs
    stimulus_process: process is
    begin
        -- Initialize Inputs
        emergency_tb <= '0';
        outside_lift_buttons_tb <= ("000000");
        inside_lift_buttons_tb <= ("0000");
        wait for 100 ns;

        -- Add stimulus here for different test scenarios
        inside_lift_buttons_tb <= "0001";
        wait for 100 ns;

        -- Add more test cases as needed

        -- End the simulation
        wait;  -- Wait indefinitely
    end process;
end behavior;
