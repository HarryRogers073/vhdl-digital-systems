library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity doors_but_better is
    Port (
        clk : in STD_LOGIC;        -- Clock input
        rst : in STD_LOGIC;        -- Reset input
        switch : in STD_LOGIC_VECTOR(7 downto 0); -- Input to manually select LEDs
        LEDs : out STD_LOGIC_VECTOR(7 downto 0) -- Output for LEDs
    );
end doors_but_better;

architecture Behavioral of doors_but_better is
    signal counter : integer range 0 to 99999999 := 0; -- 1-second counter
    signal LED_state : STD_LOGIC_VECTOR(7 downto 0) := "00000001"; -- Initial LED state
begin
    LED_Process: process(clk, rst)
    begin
        if rst = '1' then
            counter <= 0;
            LED_state <= "00000001"; -- Reset to initial LED state
        elsif rising_edge(clk) then
            if counter = 50000000 then -- Change LEDs every 1 second
                counter <= 0;
                LED_state <= switch; -- Change LEDs to the manually selected configuration
            else
                counter <= counter + 1;
            end if;
        end if;
    end process LED_Process;

    LEDs <= LED_state; -- Assign the current LED state to the output
end Behavioral;

