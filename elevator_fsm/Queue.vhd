library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Queue is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           button : in STD_LOGIC_VECTOR(3 downto 0);
           enqueue_signal : out STD_LOGIC
         );
end Queue;

architecture Behavioral of Queue is
    type QueueType is array (0 to 3) of INTEGER; -- Array used to simulate a simple queue
    signal button_queue : QueueType;
    signal queue_index : INTEGER := 0;

begin
    process(clk, reset)
    begin
        if reset = '1' then
            -- Reset the queue and index
            button_queue <= (others => 0);
            queue_index <= 0;
        elsif rising_edge(clk) then
            -- Check each button and enqueue corresponding integer
            if button(0) = '1' then
                button_queue(queue_index) <= 0;
                enqueue_signal <= '1';
            elsif button(1) = '1' then
                button_queue(queue_index) <= 1;
                enqueue_signal <= '1';
            elsif button(2) = '1' then
                button_queue(queue_index) <= 2;
                enqueue_signal <= '1';
            elsif button(3) = '1' then
                button_queue(queue_index) <= 3;
                enqueue_signal <= '1';
            else
                -- No button pressed, no enqueue signal
                enqueue_signal <= '0';
            end if;

            -- Increment queue index, wrap around if necessary
            queue_index <= (queue_index + 1) mod 4;
        end if;
    end process;

end Behavioral;
