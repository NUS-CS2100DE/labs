`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National University of Singapore
// Engineer: Neil Banerjee
// 
// Create Date: 15.01.2025 15:07:03
// Design Name: 
// Module Name: SevenSegDecoder
// Project Name: CS2100DE Labs 
// Target Devices: Nexys 4
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


module SevenSegDecoder(
    input [6:0] sw,
    output [6:0] seg,
    output [7:0] an
    );
    
    // EXAMPLE OF RTL LOOP. You should not uncomment this code. It is simply to 
    // illustrate how loops can be used to implement repetitive logic. 
    // genvar i;
    // for(i = 0; i < 7; i++) begin
    //     assign an[i] = (sw[6:4] == i) ? 0 : 1;
    // end

    // Structural code for anodes here:
    an = 8'b1; // Replace this line

    // Code for segments here:
    seg = 7'b1; // Replace this line
    
endmodule
