`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National University of Singapore
// Engineer: Neil Banerjee
// 
// Create Date: 22.02.2025 23:59:46
// Design Name: RISCV-MMC
// Module Name: ALU
// Project Name: CS2100DE Labs
// Target Devices: Nexys 4/Nexys 4 DDR
// Tool Versions: Vivado 2023.2
// Description: ALU for the RISC-V CPU
// 
// Dependencies: Nil
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    input src_a,
    input src_b,
    input control,
    output result, 
    output flags
    );
    
    always @(src_a, src_b, control) begin
        
    end
endmodule
