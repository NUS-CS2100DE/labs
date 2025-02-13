`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.02.2025 07:21:34
// Design Name: 
// Module Name: LogicWithDFF
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


module LogicWithDFF(
    input a,
    input b,
    input c,
    input d,
    input clk,
    output Q
    );
    
    logic ff_in;
    DFF ff_1(clk, ff_in, Q);
    
    assign ff_in = a & b & (c | d); 
endmodule
