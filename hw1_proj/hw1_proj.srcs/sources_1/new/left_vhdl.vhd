----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/09/14 23:11:26
-- Design Name: 
-- Module Name: left_vhdl - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity left_vhdl is
    Port (I: in std_logic_vector(15 downto 0);
          C: in std_logic_vector(3 downto 0);
          O: out std_logic_vector(15 downto 0));
end left_vhdl;

architecture Behavioral of left_vhdl is

begin
    with C(3 downto 0) select
    O <= I(14 downto 0) & I(15) when "0001",
         I(13 downto 0) & I(15 downto 14) when "0010",
         I(12 downto 0) & I(15 downto 13) when "0011",
         I(11 downto 0) & I(15 downto 12) when "0100",
         I(10 downto 0) & I(15 downto 11) when "0101",
         I(9 downto 0) & I(15 downto 10) when "0110",
         I(8 downto 0) & I(15 downto 9) when "0111",
         I(7 downto 0) & I(15 downto 8) when "1000",
         I(6 downto 0) & I(15 downto 7) when "1001",
         I(5 downto 0) & I(15 downto 6) when "1010",
         I(4 downto 0) & I(15 downto 5) when "1011",
         I(3 downto 0) & I(15 downto 4) when "1100",
         I(2 downto 0) & I(15 downto 3) when "1101",
         I(1 downto 0) & I(15 downto 2) when "1110",
         I(0) & I(15 downto 1) when "1111",
         I when others;

end Behavioral;
