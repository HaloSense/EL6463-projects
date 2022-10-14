`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/13 17:58:42
// Design Name: 
// Module Name: counterB_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// No copilot used.

module counterB_tb();

    reg t_clk;
    reg t_rst;
    reg t_en;
    wire [15:0] t_cnt;
    
    integer fp, r;
    reg f_rst;
    reg f_en;
    reg [15:0] f_cnt;
    
    counterB dut(
        .clk(t_clk),
        .rst(t_rst),
        .en(t_en),
        .cnt(t_cnt)
    );
    
    initial begin
        fp = $fopen("test_cases_counterB.csv","r");
        
        if(fp == 0) begin
            $display("Error opening file.");
            $stop;
        end
        
        t_clk = 0;
        
        while (! $feof(fp)) begin
            r = $fscanf(fp, "%b,%b,%b", f_rst, f_en, f_cnt);
            
            t_rst = f_rst;
            t_en = f_en;
            
            #10;
            t_clk = 1;
            #10;
            t_clk = 0;
            
            if (t_cnt != f_cnt) begin
                $display("Output is incorrect at time %t", $time);
                $stop;
            end
        end
        
        $fclose(fp);
        
        $display("All test cases passed.");
        $stop;
        
    end    
    
endmodule
