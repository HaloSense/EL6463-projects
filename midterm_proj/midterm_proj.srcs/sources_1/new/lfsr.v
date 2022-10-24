`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/21 14:08:50
// Design Name: 
// Module Name: lfsr
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
module lfsr(
    input wire clk,
    input wire rst,
    input wire en,
    output reg [9:0] data
    );
    
wire msb;
assign msb = data[1] ^ data[2] ^ data [5] ^ data[8];

always@(posedge clk or posedge rst)
begin
    if(rst == 1) begin
        data <= 10'b0001000011;
    end
    else if(en == 1) begin
        data <= {msb, data[9:1]};
    end
end

endmodule
