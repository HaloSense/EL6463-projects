`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/10 17:06:17
// Design Name: 
// Module Name: enc_tb
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


module enc_tb();
    
    reg t_clk;
    reg t_rst;
    reg [63:0] t_din;
    wire t_out_vld;
    wire [63:0] t_dout;
    
    integer fp, r;
    reg f_rst;
    reg [63:0] f_din;
    reg f_out_vld;
    reg [63:0] f_dout;
    
    rc5_enc dut(
        .clk(t_clk),
        .rst(t_rst),
        .din(t_din),
        .out_vld(t_out_vld),
        .dout(t_dout)
    );
    
    initial begin
        fp = $fopen("p2c_test_cases.csv","r");
        
        if(fp == 0) begin
            $display("Error opening file.");
            $stop;
        end
        
        t_clk = 0;
        
        while (! $feof(fp)) begin
            r = $fscanf(fp, "%b,%h,%b,%h", f_rst, f_din, f_out_vld, f_dout);
            
            t_rst = f_rst;
            t_din = f_din;
            
            while(t_out_vld != f_out_vld) begin
                t_clk = 1;
                #10;
                t_clk = 0;
                #10;
            end
            
            if (t_dout != f_dout) begin
                $display("Output is incorrect at time %t", $time);
                $stop;
            end
        end
        
        $fclose(fp);
        
        $display("All test cases passed.");
        $stop;
        
    end
    
endmodule
