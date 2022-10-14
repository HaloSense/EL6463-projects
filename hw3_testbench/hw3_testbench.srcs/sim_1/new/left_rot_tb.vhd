----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/10/13 14:38:15
-- Design Name: 
-- Module Name: left_rot_tb - Behavioral
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
use ieee.std_logic_textio.all;
use std.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- No copilot used.

entity left_rot_tb is
end left_rot_tb;

architecture Behavioral of left_rot_tb is

    constant clk_period : time := 20 ns;
    
    component left_vhdl is
        Port (
            I: in std_logic_vector(15 downto 0);
            C: in std_logic_vector(3 downto 0);
            O: out std_logic_vector(15 downto 0)
            );
    end component;
    
    signal t_i : std_logic_vector(15 downto 0);
    signal t_c : std_logic_vector(3 downto 0);
    signal t_o : std_logic_vector(15 downto 0);
    
    file fp : text;
    
begin

    DUT : left_vhdl
    port map(
        I => t_i,
        C => t_c,
        O => t_o
    );

    stim_proc : process
        variable f_line : line;
        variable f_i : std_logic_vector(15 downto 0);
        variable f_c : std_logic_vector(3 downto 0);
        variable f_o : std_logic_vector(15 downto 0);
        
        variable f_comma : character;
        
        begin
            file_open(fp, "test_cases_left_rot.csv", read_mode);
            
            while not endfile(fp) loop
                readline(fp, f_line);   -- Read new line
                read(f_line, f_i);      -- Read input
                read(f_line, f_comma);  -- read comma
                read(f_line, f_c);      -- read control
                read(f_line, f_comma);  -- read comma
                read(f_line, f_o);      -- read output
                
                t_i <= f_i;
                t_c <= f_c;
                
                wait for clk_period;    -- process one line every "clk period"
                
                assert t_o = f_o report "Output is incorrect!" severity failure;
                
            end loop;
            file_close(fp);
            
            report "All test cases passed." severity failure;
    
    end process;
    
end Behavioral;
