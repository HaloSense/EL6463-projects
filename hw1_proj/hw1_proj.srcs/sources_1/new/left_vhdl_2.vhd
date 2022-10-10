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
use IEEE.numeric_std.ALL

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
    process(I, C)
    begin
        integer j := to_integer(unsigned(C));
        O <= I(15-j downto 0) & I(15 downto 16-j);
    end
         
end Behavioral;
