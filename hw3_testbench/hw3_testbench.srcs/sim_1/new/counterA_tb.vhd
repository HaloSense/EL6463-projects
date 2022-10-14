----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/10/13 17:58:42
-- Design Name: 
-- Module Name: counterA_tb - Behavioral
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

entity counterA_tb is
end counterA_tb;

architecture Behavioral of counterA_tb is

    constant clk_period : time := 20 ns;
    
    component counterA is
        Port (
            clk: in std_logic;
            rst: in std_logic;
            en: in std_logic;
            cnt: out std_logic_vector(15 downto 0)
        );
    end component;
    
    signal t_clk : std_logic := '0';    -- Always initialize clock!!
    signal t_rst, t_en : std_logic;
    signal t_cnt : std_logic_vector(15 downto 0);
    
    file fp : text;

begin

    DUT : counterA
    port map(
        clk => t_clk,
        rst => t_rst,
        en => t_en,
        cnt => t_cnt
    );
    
    clk_proc: process
    begin
        wait for clk_period/2;
        t_clk <= not t_clk;
    end process;
    
    sim_proc : process
    
        variable f_line : line;
        variable f_rst : std_logic; 
        variable f_en : std_logic;
        variable f_cnt : std_logic_vector (15 downto 0);
        
        variable f_comma : character;
        
    begin
        file_open(fp, "test_cases_counterA.csv", read_mode);
        
        while(not endfile(fp)) loop
            readline(fp, f_line);
            read(f_line, f_rst);
            read(f_line, f_comma);
            read(f_line, f_en);
            read(f_line, f_comma);
            read(f_line, f_cnt);
            
            t_rst <= f_rst;
            t_en <= f_en;
            
            wait until t_clk = '1';
            wait until t_clk = '0';
            
            assert t_cnt = f_cnt 
                report "Counting output is incorrect."
                severity failure;

        end loop;
        
        file_close(fp);
        report "All test cases passed." severity failure;
        
    end process;
    
end Behavioral;
