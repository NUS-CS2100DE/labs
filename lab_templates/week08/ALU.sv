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
    input [31:0] src_a,
    input [31:0] src_b,
    input [3:0] control,
    output reg [31:0] result, 
    output reg [2:0] flags
    );
    
    always @(src_a, src_b, control) begin
        case (control)
            4'b0000: begin
                result <= src_a + src_b;
            end
            4'b0001: begin
                result <= src_a << src_b;
            end
            4'b0010: begin
                result <= ($signed(src_a) < $signed(src_b)) ? 1 : 0;
            end
            4'b0011: begin
                result <= (src_a < src_b) ? 1 : 0;
            end
            4'b0100: begin
                result <= src_a ^ src_b;
            end
            4'b0101: begin
                result <= src_a >> src_b;
            end
            4'b0110: begin
                result <= src_a | src_b;
            end
            4'b0111: begin
                result <= src_a & src_b;
            end
            4'b1000: begin
                result <= src_a - src_b;
            end
            4'b1101: begin
                result <= src_a >>> src_b;
            end
            default: begin
                result <= 32'b0;
            end
        endcase
        flags[2] <= (src_a == src_b) ? 1 : 0;
        flags[1] <= ($signed(src_a) < $signed(src_b)) ? 1 : 0;
        flags[0] <= (src_a < src_b) ? 1 : 0;
    end
endmodule