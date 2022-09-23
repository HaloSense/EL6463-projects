library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_unsigned.ALL;
entity syn_count4 is
    port (  clk: in std_logic; clr: in std_logic;
                counter: out std_logic_vector(3 downto 0));
end syn_count4;
architecture do_it of syn_count4 is
Signal i_cnt: std_logic_vector (3 downto 0);
Begin
PROCESS (clr, clk)  
BEGIN
    IF(clr='0') THEN  i_cnt<="0010";   
    ELSIF (clk'EVENT AND clk='1') THEN
        IF (i_cnt = "1110") THEN
            i_cnt <= "0010";
        ELSE 
            i_cnt <= i_cnt + 2;
        END IF;
    END IF;
END PROCESS;
counter <= i_cnt;
End do_it;
