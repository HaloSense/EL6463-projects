----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/11/10 18:40:23
-- Design Name: 
-- Module Name: rc5_dec - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rc5_dec is
  Port (
        clk:        in std_logic;
        rst:        in std_logic;
        din:        in std_logic_vector(63 downto 0);
        out_vld:    out std_logic;
        dout:       out std_logic_vector(63 downto 0));
end rc5_dec;

architecture Behavioral of rc5_dec is

    --round counter 
    SIGNAL i_cnt: STD_LOGIC_VECTOR(3 DOWNTO 0); 
    
    -- a_reg
    SIGNAL a_sub: STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL a_rot: STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL a: STD_LOGIC_VECTOR(31 DOWNTO 0);
    --register to store value A
    SIGNAL a_reg: STD_LOGIC_VECTOR(31 DOWNTO 0); 

    -- b_reg
    SIGNAL b_sub: STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL b_rot: STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL b: STD_LOGIC_VECTOR(31 DOWNTO 0);
    --register to store value B
    SIGNAL b_reg: STD_LOGIC_VECTOR(31 DOWNTO 0); 

    -- rom skey
    TYPE rom IS ARRAY (2 TO 25) OF STD_LOGIC_VECTOR(31 DOWNTO 0);

    CONSTANT skey: rom:=rom'(X"46F8E8C5",X"460C6085",X"70F83B8A", X"284B8303", X"513E1454", X"F621ED22", X"3125065D",X"11A83A5D",X"D427686B", X"713AD82D", X"4B792F99", X"2799A4DD", X"A7901C49", X"DEDE871A", X"36C03196", X"A7EFC249", X"61A78BB8", X"3B0A1D2B", X"4DBFCA76", X"AE162167", X"30D76B0A", X"43192304", X"F6CC1431", X"65046380"); 

begin

    -- B = ((B - S[2×i +1]) >>> A) xor A
    -- B - S[2*1 + 1]
    b_sub <= b_reg - skey(CONV_INTEGER(i_cnt & '0') + 1);

    -- B >>> A
    with a_reg(4 downto 0) select
        b_rot <= b_sub(0) & b_sub(31 downto 1) when "00001",
                 b_sub(1 downto 0) & b_sub(31 downto 2) when "00010",
                 b_sub(2 downto 0) & b_sub(31 downto 3) when "00011",
                 b_sub(3 downto 0) & b_sub(31 downto 4) when "00100",
                 b_sub(4 downto 0) & b_sub(31 downto 5) when "00101",
                 b_sub(5 downto 0) & b_sub(31 downto 6) when "00110",
                 b_sub(6 downto 0) & b_sub(31 downto 7) when "00111",
                 b_sub(7 downto 0) & b_sub(31 downto 8) when "01000",
                 b_sub(8 downto 0) & b_sub(31 downto 9) when "01001",
                 b_sub(9 downto 0) & b_sub(31 downto 10) when "01010",
                 b_sub(10 downto 0) & b_sub(31 downto 11) when "01011",
                 b_sub(11 downto 0) & b_sub(31 downto 12) when "01100",
                 b_sub(12 downto 0) & b_sub(31 downto 13) when "01101",
                 b_sub(13 downto 0) & b_sub(31 downto 14) when "01110",
                 b_sub(14 downto 0) & b_sub(31 downto 15) when "01111",
                 b_sub(15 downto 0) & b_sub(31 downto 16) when "10000",
                 b_sub(16 downto 0) & b_sub(31 downto 17) when "10001",
                 b_sub(17 downto 0) & b_sub(31 downto 18) when "10010",
                 b_sub(18 downto 0) & b_sub(31 downto 19) when "10011",
                 b_sub(19 downto 0) & b_sub(31 downto 20) when "10100",
                 b_sub(20 downto 0) & b_sub(31 downto 21) when "10101",
                 b_sub(21 downto 0) & b_sub(31 downto 22) when "10110",
                 b_sub(22 downto 0) & b_sub(31 downto 23) when "10111",
                 b_sub(23 downto 0) & b_sub(31 downto 24) when "11000",
                 b_sub(24 downto 0) & b_sub(31 downto 25) when "11001",
                 b_sub(25 downto 0) & b_sub(31 downto 26) when "11010",
                 b_sub(26 downto 0) & b_sub(31 downto 27) when "11011",
                 b_sub(27 downto 0) & b_sub(31 downto 28) when "11100",
                 b_sub(28 downto 0) & b_sub(31 downto 29) when "11101",
                 b_sub(29 downto 0) & b_sub(31 downto 30) when "11110",
                 b_sub(30 downto 0) & b_sub(31) when "11111",
                 b_sub when others;
    
    -- B xor A
    b <= b_rot xor a_reg;

    -- A = ((A - S[2×i]) >>> B) xor B;
    -- A - S[2*i]
    a_sub <= a_reg - skey(CONV_INTEGER(i_cnt & '0'));

    -- A >>> B
    with b(4 downto 0) select
        a_rot <= a_sub(0) & a_sub(31 downto 1) when "00001",
                 a_sub(1 downto 0) & a_sub(31 downto 2) when "00010",
                 a_sub(2 downto 0) & a_sub(31 downto 3) when "00011",
                 a_sub(3 downto 0) & a_sub(31 downto 4) when "00100",
                 a_sub(4 downto 0) & a_sub(31 downto 5) when "00101",
                 a_sub(5 downto 0) & a_sub(31 downto 6) when "00110",
                 a_sub(6 downto 0) & a_sub(31 downto 7) when "00111",
                 a_sub(7 downto 0) & a_sub(31 downto 8) when "01000",
                 a_sub(8 downto 0) & a_sub(31 downto 9) when "01001",
                 a_sub(9 downto 0) & a_sub(31 downto 10) when "01010",
                 a_sub(10 downto 0) & a_sub(31 downto 11) when "01011",
                 a_sub(11 downto 0) & a_sub(31 downto 12) when "01100",
                 a_sub(12 downto 0) & a_sub(31 downto 13) when "01101",
                 a_sub(13 downto 0) & a_sub(31 downto 14) when "01110",
                 a_sub(14 downto 0) & a_sub(31 downto 15) when "01111",
                 a_sub(15 downto 0) & a_sub(31 downto 16) when "10000",
                 a_sub(16 downto 0) & a_sub(31 downto 17) when "10001",
                 a_sub(17 downto 0) & a_sub(31 downto 18) when "10010",
                 a_sub(18 downto 0) & a_sub(31 downto 19) when "10011",
                 a_sub(19 downto 0) & a_sub(31 downto 20) when "10100",
                 a_sub(20 downto 0) & a_sub(31 downto 21) when "10101",
                 a_sub(21 downto 0) & a_sub(31 downto 22) when "10110",
                 a_sub(22 downto 0) & a_sub(31 downto 23) when "10111",
                 a_sub(23 downto 0) & a_sub(31 downto 24) when "11000",
                 a_sub(24 downto 0) & a_sub(31 downto 25) when "11001",
                 a_sub(25 downto 0) & a_sub(31 downto 26) when "11010",
                 a_sub(26 downto 0) & a_sub(31 downto 27) when "11011",
                 a_sub(27 downto 0) & a_sub(31 downto 28) when "11100",
                 a_sub(28 downto 0) & a_sub(31 downto 29) when "11101",
                 a_sub(29 downto 0) & a_sub(31 downto 30) when "11110",
                 a_sub(30 downto 0) & a_sub(31) when "11111",
                 a_sub when others;
    
    -- A xor B
    a <= a_rot xor b;

    -- a_reg
    PROCESS(rst, clk) BEGIN
        IF(rst = '1' or i_cnt = "0001") THEN a_reg <= din(63 DOWNTO 32);
        ELSIF(clk'EVENT AND clk ='1') THEN a_reg <= a;
        END IF;
    END PROCESS;

    -- b_reg
    PROCESS(rst, clk)  BEGIN
        IF(rst = '1' or i_cnt = "0001") THEN b_reg<=din(31 DOWNTO 0);
        ELSIF(clk'EVENT AND clk='1') THEN b_reg<=b;
        END IF;
    END PROCESS;   

    -- counter
    PROCESS(rst, clk)  
    BEGIN
        IF(rst = '1') THEN 
            i_cnt <= "0001";
            out_vld <= '0';
        ELSIF(clk'EVENT AND clk='1') THEN
            IF(i_cnt="1100") THEN
                i_cnt <= "0001";
                out_vld <= '1';
            ELSE
                i_cnt <= i_cnt+'1';
                out_vld <= '0';
       END IF;
    END IF;

    -- output signal
    dout <= a_reg & b_reg;

END PROCESS;

end Behavioral;
