`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National University of Singapore
// Engineer: Neil Banerjee
// 
// Create Date: 01.01.2025 21:55:29
// Design Name: Adder
// Module Name: Adder_sim
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


module Adder_sim(

    );
    
    logic[7:0] in_a;
    logic[7:0] in_b;
    logic[7:0] result;
    logic carry;
    
    Adder uut (in_a, in_b, result, carry);
    
    initial begin
        in_a = 8'b0;
        in_b = 8'b0;
        #10;
        in_a = 8'b1010;
        in_b = 8'b1010;
        #10;
        in_a = 8'b11111111;
        in_b = 8'b11111111;
        #10;
    end
endmodule
