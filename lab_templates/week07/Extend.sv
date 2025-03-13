`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National University of Singapore
// Engineer: Neil Banerjee
// 
// Create Date: 05.03.2025 23:43:42
// Design Name: RISCV-MMC
// Module Name: Extend
// Project Name: CS2100DE Labs
// Target Devices: Nexys 4/Nexys 4 DDR
// Tool Versions: Vivado 2023.2
// Description: Module for extending immediates
// 
// Dependencies: Nil
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Extend(
    input [31:7] instr_imm,
    input imm_src,
    output reg [31:0] ext_imm
    );
    
    always @(imm_src, instr_imm) begin
        case (imm_src)
            3'b000: begin // I
                ext_imm <= 32'b0;
            end
            3'b001: begin // S
                ext_imm <= 32'b0;
            end
            3'b010: begin // B
                ext_imm <= 32'b0;
            end
            3'b011: begin // U
                ext_imm <= 32'b0;
            end
            3'b100: begin // J/UJ
                ext_imm <= 32'b0;
            end
            default: begin
                ext_imm <= 32'b0;
            end
        endcase
    end
endmodule
