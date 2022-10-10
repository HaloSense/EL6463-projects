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
    output reg [15:0] O
    );

integer j;

always@(I, c)
    j := c;
    O := {I[15-j:0],I[15:16-j]};

endmodule
