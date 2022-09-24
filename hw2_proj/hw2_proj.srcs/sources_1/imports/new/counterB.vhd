----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/09/21 21:27:09
-- Design Name: 
-- Module Name: counterB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- No Copilot used.

entity counterB is
    Port (clk: in std_logic;
          rst: in std_logic;
          en: in std_logic;
          cnt: out std_logic_vector(15 downto 0));
end counterB;

architecture Behavioral of counterB is

-- Declare a intermediate signal to transfer counter value
signal cnt_val: std_logic_vector (15 downto 0) := X"0003";

begin
    
    -- Counter process
    process(clk, rst) begin
        if(rst = '1') then      -- Asynchronous reset to 3
            cnt_val <= X"0003";
        elsif(clk'event and clk = '1') then
            if(en = '1') then   -- Synchronous enable
                cnt_val <= cnt_val - 1;
            else
                cnt_val <= cnt_val; -- No enable or reset
            end if; 
        else
            -- For other cases, value doesn't change,
            -- in case of unexpected conditions
            cnt_val <= cnt_val;
        end if;
    end process;
    
    -- Send the internal counter value to output port
    cnt <= cnt_val;
    
end Behavioral;
