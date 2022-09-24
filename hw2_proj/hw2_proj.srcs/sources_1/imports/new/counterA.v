`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/21 21:27:09
// Design Name: 
// Module Name: counterA
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

// No Copilot used.

`default_nettype none

module counterA(
    input wire clk,
    input wire rst,
    input wire en,
    output reg [15:0] cnt
    );

// Initial block
initial begin
    cnt <= 16'd0;
end

// Counter block
always@(posedge clk or posedge rst)
begin
    if(rst == 1) begin // Asynchronous reset
        cnt <= 16'd1;
    end
    else if (en == 1) begin // Synchronous enable
        cnt <= cnt + 1;
    end
    else begin
        cnt <= cnt;
    end
end
        
endmodule
