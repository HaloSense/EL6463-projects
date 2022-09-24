----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/09/23 20:31:25
-- Design Name: 
-- Module Name: counterB_top - Behavioral
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

entity counterB_top is
      Port (CLK100MHZ: in std_logic;
            sw: in std_logic_vector(15 downto 0);
            LED: out std_logic_vector(15 downto 0));
end counterB_top;

architecture Behavioral of counterB_top is

-- Declare a slower clock signal
signal clk_slow: std_logic;
signal clk_div: std_logic_vector (15 downto 0) := X"0000"; 

begin

    -- Clock divider process 
    process(CLK100MHZ) begin
        if(CLK100MHZ'event and CLK100MHZ = '1') then
            clk_div <= clk_div + 1;
        end if;  
    end process;
    
    -- Assign the divided clock signal
    clk_slow <= clk_div(15);
    
    -- Port assignment
    instanceB : entity work.counterB
        port map(
            clk => clk_slow,
            rst => sw(0),
            en => sw(1),
            cnt => LED
        );


end Behavioral;
