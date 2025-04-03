`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2025 20:41:55
// Design Name: 
// Module Name: Top_Test
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


module Top_Test(
    
    );
    
    logic clk;          
    logic btnCpuReset;  
    logic btnC;         
    logic btnU;         
    logic btnL;         
    logic btnR;         
    logic btnD;         
    logic [15:0] sw;    
    
    logic [15:0] led;           
    logic [6:0] seg;    
    logic [7:0] an;     
    
    Top_MMC dut ( 
        .clk(clk),
        .btnCpuReset(btnCpuReset),
        .btnC(btnC),
        .btnU(btnU),
        .btnL(btnL),
        .btnR(btnR),
        .btnD(btnD),
        .sw(sw),
        .led(led),
        .seg(seg),
        .an(an)
    );
    
    initial begin
        clk = 0;
        btnCpuReset = 1;
        btnC = 0;
        btnU = 0;
        btnL = 0;
        btnR = 0;
        btnD = 0;
        sw = 16'hAA;
        #2;
        btnCpuReset = 0;
        #208;
        sw = 16'h55;
    end
    
    always begin
        clk = ~clk;
        #5;
    end
    
endmodule
