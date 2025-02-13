`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.02.2025 07:11:43
// Design Name: 
// Module Name: DFFWithLogic
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


module DFFWithLogic(
    input clk,
    input a,
    input b,
    input c,
    input d,
    output reg Q
    );
    
    always @(posedge clk) begin
        Q <= a & b & (c | d);
    end
endmodule
