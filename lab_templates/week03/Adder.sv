`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National University of Singapore
// Engineer: Neil Banerjee
// 
// Create Date: 01.01.2025 21:55:29
// Design Name: Adder
// Module Name: Adder
// Project Name: CS2100DE Labs
// Target Devices: Nexys 4/Nexys 4 DDR
// Tool Versions: Vivado 2023.2
// Description:  
// 
// Dependencies: Nil
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Adder(
    input [7:0] in_a,
    input [7:0] in_b,
    output [7:0] result,
    output carry_out
    );
    
    logic[7:0] carry;
    
    assign carry[0] = 0;
    
    assign result[0] = in_a[0] ^ in_b[0] ^ carry[0];
    assign carry[1] = in_a[0] & in_b[0] | (in_a[0] ^ in_b[0]) & carry[0];
    
    assign result[1] = in_a[1] ^ in_b[1] ^ carry[1];
    assign carry[2] = in_a[1] & in_b[1] | (in_a[1] ^ in_b[1]) & carry[1];
    
    assign result[2] = in_a[2] ^ in_b[2] ^ carry[2];
    assign carry[3] = in_a[2] & in_b[2] | (in_a[2] ^ in_b[2]) & carry[2];
    
    assign result[3] = in_a[3] ^ in_b[3] ^ carry[3];
    assign carry[4] = in_a[2] & in_b[2] | (in_a[2] ^ in_b[2]) & carry[2];
    
    assign result[4] = in_a[4] ^ in_b[4] ^ carry[4];
    assign carry[5] = in_a[4] & in_b[4] | (in_a[4] ^ in_b[4]) & carry[4];
    
    assign result[5] = in_a[5] ^ in_b[5] ^ carry[5];
    assign carry[6] = in_a[5] & in_b[5] | (in_a[5] ^ in_b[5]) & carry[5];
    
    assign result[6] = in_a[6] ^ in_b[6] ^ carry[6];
    assign carry[7] = in_a[6] & in_b[6] | (in_a[6] ^ in_b[6]) & carry[6];
    
    assign result[7] = in_a[7] ^ in_b[7] ^ carry[7];
    assign carry_out = in_a[7] & in_b[7] | (in_a[7] ^ in_b[7]) & carry[7];
endmodule
