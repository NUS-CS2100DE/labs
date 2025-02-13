`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2025 23:58:59
// Design Name: 
// Module Name: DFF_sim
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


module DFF_sim(
    
    );
    
    logic clk, D, Q;
    
    DFF ff (clk, D, Q);
    
    initial begin
        clk = 0;
        D = 0;
        #2;
        D = 1;
        #2;
        D = 0;
        #2;
        D = 1;
        #5;
        D = 0;
        #7;
        D = 1;
        #10;
        D = 0;
        #5;
        $finish;
    end
    always begin
        clk = ~clk;
        #5;
    end
endmodule
