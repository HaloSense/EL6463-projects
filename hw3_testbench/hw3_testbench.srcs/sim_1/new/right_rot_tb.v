`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/13 15:37:55
// Design Name: 
// Module Name: right_rot_tb
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

// No copilot used

module right_rot_tb();

    reg [15:0] t_i;
    reg [3:0] t_c;
    wire [15:0] t_o;
    
    integer fp, r;
    reg [15:0] f_i;
    reg [3:0] f_c;
    reg [15:0] f_o;
    
    right_verilog dut(
        .I(t_i),
        .c(t_c),
        .O(t_o)
    );
    
    initial begin
        fp = $fopen("test_cases_right_rot.csv", "r");
        
        if(fp == 0) begin
            $display("Error opening file.");
            $stop;
        end
        
        while (! $feof(fp)) begin
            r = $fscanf(fp, "%b,%b,%b", f_i, f_c, f_o);
            
            t_i = f_i;
            t_c = f_c;
            
            #20;
            
            if(t_o != f_o) begin
                $display("Output is incorrect at time %t", $time);
                $stop;
            end
        end
        
        $fclose(fp);
        
        $display("All test cases passed.");
        $stop;
        
    end

endmodule
