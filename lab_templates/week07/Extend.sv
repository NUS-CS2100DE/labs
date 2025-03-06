`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2025 23:43:42
// Design Name: 
// Module Name: Extend
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
