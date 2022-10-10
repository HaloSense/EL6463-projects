`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/14 23:11:26
// Design Name: 
// Module Name: left_verilog
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

module left_verilog(
    input wire [15:0] I,
    input wire [3:0] c,
    output wire [15:0] O
    );

assign O = (c == 4'd1) ? {I[14:0], I[15]}:
           (c == 4'd2) ? {I[13:0], I[15:14]}:
           (c == 4'd3) ? {I[12:0], I[15:13]}:
           (c == 4'd4) ? {I[11:0], I[15:12]}:
           (c == 4'd5) ? {I[10:0], I[15:11]}:
           (c == 4'd6) ? {I[9:0], I[15:10]}:
           (c == 4'd7) ? {I[8:0], I[15:9]}:
           (c == 4'd8) ? {I[7:0], I[15:8]}:
           (c == 4'd9) ? {I[6:0], I[15:7]}:
           (c == 4'd10) ? {I[5:0], I[15:6]}:
           (c == 4'd11) ? {I[4:0], I[15:5]}:
           (c == 4'd12) ? {I[3:0], I[15:4]}:
           (c == 4'd13) ? {I[2:0], I[15:3]}:
           (c == 4'd14) ? {I[1:0], I[15:2]}:
           (c == 4'd15) ? {I[0], I[15:1]}:
           I;
    
endmodule
