`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2022 03:36:32 PM
// Design Name: 
// Module Name: tb_trackctrl
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


module tb_trackctrl();
    
    // testing input regs and output wires
    reg t_clk, t_rst;
    reg t_d1, t_d2, t_d3, t_d4;
    reg t_estop, t_estop_clear;
    wire t_r1, t_r2, t_g1, t_g2;
    wire t_t14, t_t23;
    
    // file read regs
    integer r, fp;
    reg f_rst;
    reg f_d1, f_d2, f_d3, f_d4;
    reg f_estop, f_estop_clear;
    wire f_r1, f_r2, f_g1, f_g2;
    wire f_t14, f_t23;
    
    trackctrl dut(
        .clk(t_clk),
        .rst(t_rst),
        .d1(t_d1),
        .d2(t_d2),
        .d3(t_d3),
        .d4(t_d4),
        .estop(t_estop),
        .estop_clear(t_estop_clear),
        .r1(t_r1),
        .r2(t_r2),
        .g1(t_g1),
        .g2(t_g2),
        .t14(t_t14),
        .t23(t_t23)
    );
    
    initial begin
        fp = $fopen("test_cases_trackctrl.csv", "r");
        
        if(fp==0) begin
            $display("Error opening file.");
            $stop;
        end
        
        t_clk = 0;
        #10;
        
        while (! $feof(fp)) begin
            // arrange input line in csv as:
            // rst, d1, d2, d3, d4, estop, estop_clear, r1, g1, r2, g2, t14, t23
            r = $fscanf(fp, "%b, %b, %b, %b, %b, %b, %b, %b, %b, %b, %b, %b, %b", f_rst, f_d1, f_d2, f_d3, f_d4, f_estop, f_estop_clear, f_r1, f_g1, f_r2, f_g2, f_t14, f_t23);
            
            t_rst = f_rst;
            t_d1 = f_d1;
            t_d2 = f_d2;
            t_d3 = f_d3;
            t_d4 = f_d4;
            t_estop = f_estop;
            t_estop_clear = f_estop_clear;
            
            t_clk = 1;
            #10;
            t_clk = 0;
            #10;
            
            if (t_r1 != f_r1) begin
                $display("r1 is incorrect at time %t", $time);
                $stop;
            end
            if (t_r2 != f_r2) begin
                $display("r2 is incorrect at time %t", $time);
                $stop;
            end
            if (t_g1 != f_g1) begin
                $display("g1 is incorrect at time %t", $time);
                $stop;
            end
            if (t_g2 != f_g2) begin
                $display("g2 is incorrect at time %t", $time);
                $stop;
            end
            if (t_t14 != f_t14) begin
                $display("t14 is incorrect at time %t", $time);
                $stop;
            end
            if (t_t23 != f_t23) begin
                $display("t23 is incorrect at time %t", $time);
                $stop;
            end
        end
        
        $fclose(fp);
        
        $display("All test cases passed.");
        $stop;
    end
endmodule
