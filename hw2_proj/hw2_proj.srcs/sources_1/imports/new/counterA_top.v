`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/21 21:57:15
// Design Name: 
// Module Name: counterA_top
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

module counterA_top(
    input wire CLK100MHZ,
    input wire [15:0] sw,
    output wire [15:0] LED
);

counterA instanceA(
    .clk(CLK100MHZ),
    .rst(sw[0]),
    .en(sw[1]),
    .cnt(LED)
);

endmodule
