`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/21 14:59:19
// Design Name: 
// Module Name: tb_lfsr
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

`default_nettype none
module tb_lfsr();

    reg t_clk;
    reg t_rst;
    reg t_en;
    wire [9:0] t_data;
    
    integer fp, r;
    reg f_rst;
    reg f_en;
    reg [9:0] f_data;
    
    lfsr dut(
        .clk(t_clk),
        .rst(t_rst),
        .en(t_en),
        .data(t_data)    
    );
    
    initial begin
        fp = $fopen("test_cases_lfsr.csv","r");
        
        if(fp == 0) begin
            $display("Error opening file.");
            $stop;
        end
        
        t_clk = 0;
        
        while (! $feof(fp)) begin
            r = $fscanf(fp, "%b,%b,%b", f_rst, f_en, f_data);
            
            t_rst = f_rst;
            t_en = f_en;
            
            t_clk = 1;
            #10;
            t_clk = 0;
            #10;
            
            if(t_data != f_data) begin
                $display("Output is incorrect at time %t", $time);
                $stop;
            end
            
        end
        
        $fclose(fp);
        
        $display("All test cases passed.");
        $stop;
            
    end
    
endmodule
