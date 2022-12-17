`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2022 02:43:00 PM
// Design Name: 
// Module Name: trackctrl
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


module trackctrl(
    input wire clk, rst,
    input wire d1, d2, d3, d4,
    input wire estop, estop_clear,
    output wire r1, r2, g1, g2,
    output wire t14, t23
    );
    
    // regs to "register" the input and outputs (except for clk and rst)
    reg d1_r, d2_r, d3_r, d4_r;
    reg estop_r, estop_clear_r;
    reg r1_r, r2_r, g1_r, g2_r;
    reg t14_r, t23_r;
    
    // registering the inputs and outputs
    always@(posedge clk) begin
        d1_r <= d1;
        d2_r <= d2;
        d3_r <= d3;
        d4_r <= d4;
        estop_r <= estop;
        estop_clear_r <= estop_clear;
    end

    assign r1 = r1_r;
    assign r2 = r2_r;
    assign g1 = g1_r;
    assign g2 = g2_r;
    assign t14 = t14_r;
    assign t23 = t23_r;
    
    // Finite State Machine
    
    // state parameter declaration
    parameter integer n_states = 8;
    
    // 8 states, use one-hot coding
    parameter [n_states-1:0] s_idle = 8'b0000_0001;
    parameter [n_states-1:0] s_d1_enter = 8'b0000_0010;
    parameter [n_states-1:0] s_d1_in = 8'b0000_0100;
    parameter [n_states-1:0] s_d3_exit = 8'b0000_1000;
    parameter [n_states-1:0] s_d2_enter = 8'b0001_0000;
    parameter [n_states-1:0] s_d2_in = 8'b0010_0000;
    parameter [n_states-1:0] s_d4_exit = 8'b0100_0000;
    parameter [n_states-1:0] s_estop = 8'b1000_0000;
    
    // state registers
    reg [n_states-1:0] state;
    reg [n_states-1:0] next_state;
    
    // initial
    initial begin
        state = s_idle;
    end
    
    // state transition control
    always@(posedge clk or negedge rst) begin
        if(rst == 0) state <= s_idle;
        else state <= next_state;
    end
    
    // state transition control
    always@(d1_r or d2_r or d3_r or d4_r or estop_r or estop_clear_r or state)
    begin
        case(state)
            s_idle: begin
                // check for estop first, then d1, then d2
                if(estop_r == 1) next_state = s_estop;
                else if (d1_r == 1) next_state = s_d1_enter;
                else if (d2_r == 1) next_state = s_d2_enter;
                else next_state = s_idle;
            end
            
            s_d1_enter: if(d1_r == 0) next_state = s_d1_in;
                        else next_state = s_d1_enter;
                        
            s_d1_in:    if(d3_r == 1) next_state = s_d3_exit;
                        else next_state = s_d1_in;
                        
            s_d3_exit:  if(d3_r == 0) next_state = s_idle;
                        else next_state = s_d3_exit;
                        
            s_d2_enter: if(d2_r == 0) next_state = s_d2_in;
                        else next_state = s_d2_enter;
                       
            s_d2_in:    if(d4_r == 1) next_state = s_d4_exit;
                        else next_state = s_d2_in;
                        
            s_d4_exit:  if(d4_r == 0) next_state = s_idle;
                        else next_state = s_d4_exit;
                        
            s_estop:    if(estop_clear_r == 1) next_state = s_idle;
                        else next_state = s_estop;
                        
            default: next_state = s_idle;
            
        endcase
    end
    
    // state output control
    always@(posedge clk) begin
        case(state)
            s_idle: begin
                r1_r <= 1;
                g1_r <= 0;
                r2_r <= 1;
                g2_r <= 0;
                // t14 and t23 don't have to be at specific
                // positions at idle state, but I assign them
                // default position to avoid implicity
                t14_r <= 1;
                t23_r <= 0;
            end
            s_d1_enter: begin
                r1_r <= 0;
                g1_r <= 1;
                r2_r <= 1;
                g2_r <= 0;
                t14_r <= 1;
                t23_r <= 0;
            end
            s_d1_in: begin
                r1_r <= 1;
                g1_r <= 0;
                r2_r <= 1;
                g2_r <= 0;
                t14_r <= 1;
                t23_r <= 0;
            end
            s_d3_exit: begin
                r1_r <= 1;
                g1_r <= 0;
                r2_r <= 1;
                g2_r <= 0;
                t14_r <= 1;
                t23_r <= 0;
            end
            s_d2_enter: begin
                r1_r <= 1;
                g1_r <= 0;
                r2_r <= 0;
                g2_r <= 1;
                t14_r <= 0;
                t23_r <= 1;
            end
            s_d2_in: begin
                r1_r <= 1;
                g1_r <= 0;
                r2_r <= 1;
                g2_r <= 0;
                t14_r <= 0;
                t23_r <= 1;
            end
            s_d4_exit: begin
                r1_r <= 1;
                g1_r <= 0;
                r2_r <= 1;
                g2_r <= 0;
                t14_r <= 0;
                t23_r <= 1;
            end
            s_estop: begin
                r1_r <= 1;
                g1_r <= 0;
                r2_r <= 1;
                g2_r <= 0;
                t14_r <= 1;
                t23_r <= 0;
            end
            default: begin
                r1_r <= 1;
                g1_r <= 0;
                r2_r <= 1;
                g2_r <= 0;
                t14_r <= 1;
                t23_r <= 0;
            end
        endcase
    end
    
endmodule
