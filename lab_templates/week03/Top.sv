`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National University of Singapore
// Engineer: Neil Banerjee
// 
// Create Date: 01.01.2025 21:55:29
// Design Name: Adder
// Module Name: Top
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


module Top(
    output [15:0] led,
    input [15:0] sw
    );
    
    Adder adder_1 (sw[15:8], sw[7:0], led[7:0], led[8]);
    
endmodule
