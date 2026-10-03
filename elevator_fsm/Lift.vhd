library ieee;  -- Include the IEEE library for standard logic definitions
use ieee.std_logic_1164.all;  -- Use the standard logic package for logic types
use ieee.numeric_std.all;  -- Use the numeric standard package for numeric types

-- Entity declaration for Lift
entity Lift is
    generic (
        clock_divider: integer := 50000000  -- Generic parameter for clock division ratio
    );
    port (
        clk_in                : in std_logic;  -- Input clock
        slow_clk              : inout std_logic;  -- Slow clock output
        emergency             : in std_logic;  -- Emergency Button
        door_leds             : inout STD_LOGIC_VECTOR(2 downto 0);  -- LED outputs for door state
        lift_leds             : inout STD_LOGIC_VECTOR(3 downto 0);  -- LED outputs for lift position
        outside_lift_buttons  : inout STD_LOGIC_VECTOR(5 downto 0);  -- Buttons for outside the lift
        inside_lift_buttons   : inout STD_LOGIC_VECTOR(3 downto 0)   -- Buttons for inside the lift
    );
end entity Lift;

-- Architecture declaration for Door_LEDs
architecture Door_LEDs of Lift is
    -- Signal declarations
    signal current_door_state     : integer range 0 to 3 := 0;  -- Current state of door (0-3)
    signal door_movement_direction : integer range 0 to 1 := 0;  -- Direction of door movement
    signal current_lift_floor     : integer range 0 to 3 := 0;  -- Current lift floor (0-3)
    signal lift_movement_direction : integer range 0 to 1 := 0;  -- Direction of lift movement
    signal target_lift_floor      : integer range 0 to 3 := 0;  -- Target floor for the lift (0-3)
    signal emergency_stop         : std_logic := '0';  -- Emergency Stop Variable

begin
    -- Clock division process for generating slow_clk
    process (clk_in)
        variable count : integer range 0 to clock_divider;  -- Counter variable for clock division
    begin
        if rising_edge(clk_in) then
            count := count + 1;
            if count < clock_divider / 2 then
                slow_clk <= '0';  -- Set slow_clk to '0' for the first half of the clock cycle
            elsif count < clock_divider then
                slow_clk <= '1';  -- Set slow_clk to '1' for the second half of the clock cycle
            else
                count := 0;  -- Reset count when it reaches clock_divider
            end if;
        end if;
    end process;

    -- Main lift control process
    process(slow_clk)
    begin
        -- Reading inside lift buttons to set the target floor
if inside_lift_buttons = "0001" or outside_lift_buttons = "000001" then
    target_lift_floor <= 0;  -- Button 1 is pressed or first condition met, set the target floor to 1
elsif inside_lift_buttons = "0010" or (outside_lift_buttons = "000010" or outside_lift_buttons = "000100") then
    target_lift_floor <= 1;  -- Button 2 is pressed or second or third condition met, set the target floor to 0
elsif inside_lift_buttons = "0100" or (outside_lift_buttons = "001000" or outside_lift_buttons = "010000") then
    target_lift_floor <= 3;  -- Button 3 is pressed or fourth or fifth condition met, set the target floor to 3
elsif inside_lift_buttons = "1000" or outside_lift_buttons = "100000" then
    target_lift_floor <= 2;  -- Button 4 is pressed or sixth condition met, set the target floor to 2
else
    target_lift_floor <= current_lift_floor;  -- Default value if no button is pressed
end if;




        -- Lift movement logic based on the current and target floors
        if rising_edge(slow_clk) then
				 -- Check if the emergency button is pressed
				 if emergency = '1' then
					  emergency_stop <= '1';  -- Set emergency stop signal to activate emergency stop
				 end if;

				 -- If emergency stop is active
				 if emergency_stop = '0' then
					  current_door_state <= 2;  -- Set the door state to 'open' during emergency stop
				 else
                if lift_movement_direction = 0 then  -- Lift moving downwards
                    if current_lift_floor < target_lift_floor then
                        lift_movement_direction <= 1;  -- Change direction upwards
                    elsif current_lift_floor > target_lift_floor then
                        current_lift_floor <= current_lift_floor - 1;  -- Move the lift down
                    else
                        -- Door movement logic
                        if door_movement_direction = 0 then
                            if current_door_state = 2 then
                                door_movement_direction <= 1;  -- Reverse door direction
                            else
                                current_door_state <= current_door_state + 1;  -- Move the door state
                            end if;
                        else
                            if current_door_state = 0 then
                                door_movement_direction <= 0;  -- Reverse door direction
                            else
                                current_door_state <= current_door_state - 1;  -- Move the door state
                            end if;
                        end if;
                    end if;
                else  -- Lift moving upwards
                    if current_lift_floor < target_lift_floor then
                        current_lift_floor <= current_lift_floor + 1;  -- Move the lift up
                    elsif current_lift_floor > target_lift_floor then
                        lift_movement_direction <= 0;  -- Change direction downwards
                    else
                        -- Door movement logic
                        if door_movement_direction = 0 then
                            if current_door_state = 2 then
                                door_movement_direction <= 1;  -- Reverse door direction
                            else
                                current_door_state <= current_door_state + 1;  -- Move the door state
                            end if;
                        else
                            if current_door_state = 0 then
                                door_movement_direction <= 0;  -- Reverse door direction
                            else
                                current_door_state <= current_door_state - 1;  -- Move the door state
                            end if;
                        end if;
                    end if;
                end if;
            end if;
        end if;

        -- Update LEDs based on the current lift floor
        if rising_edge(slow_clk) then
            case current_lift_floor is
                when 0 =>
                    lift_leds <= "0001";  -- Indicate the first floor
                when 1 =>
                    lift_leds <= "0010";  -- Indicate the second floor
                when 2 =>
                    lift_leds <= "0100";  -- Indicate the third floor
                when 3 =>
                    lift_leds <= "1000";  -- Indicate the fourth floor
                when others =>
                    lift_leds <= "0000";  -- Default case
            end case;

            if current_lift_floor /= target_lift_floor then
                current_door_state <= 0;  -- Reset the door state when the lift is moving
                case current_door_state is
                    when 0 =>
                        door_leds <= "100";  -- Indicate the door is closed
                    when 1 =>
                        door_leds <= "010";  -- Indicate the door is opening
                    when 2 =>
                        door_leds <= "001";  -- Indicate the door is open
                    when others =>
                        door_leds <= "000";  -- Default for other cases
                end case;
            else
                case current_door_state is
                    when 0 =>
                        door_leds <= "100";  -- Indicate the door is closed
                    when 1 =>
                        door_leds <= "010";  -- Indicate the door is opening
                    when 2 =>
                        door_leds <= "001";  -- Indicate the door is open
                    when others =>
                        door_leds <= "000";  -- Default for other cases
                end case;
            end if;
        end if;
    end process;

end architecture Door_LEDs;
