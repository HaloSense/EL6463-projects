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

// Declare a slower clock signal
wire clk_slow;
reg [15:0] clk_div;

// Initial block
initial begin
    clk_div <= 16'd0;
end

// Clock divider
// Divide clock frequency by 2^16
// 100MHz / 2^16 = 1525.87
always@(posedge CLK100MHZ)
begin
    clk_div <= clk_div + 1;
end

assign clk_slow = clk_div[15];

counterA instanceA(
    .clk(clk_slow),
    .rst(sw[0]),
    .en(sw[1]),
    .cnt(LED)
);

endmodule
