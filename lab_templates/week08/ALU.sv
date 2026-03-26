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
    
//    always @(src_a, src_b, control) begin
//        case (control)
//            4'b0000: begin
//                result <= src_a + src_b;
//            end
//            4'b0001: begin
//                result <= src_a << src_b;
//            end
//            4'b0010: begin
//                result <= ($signed(src_a) < $signed(src_b)) ? 1 : 0;
//            end
//            4'b0011: begin
//                result <= (src_a < src_b) ? 1 : 0;
//            end
//            4'b0100: begin
//                result <= src_a ^ src_b;
//            end
//            4'b0101: begin
//                result <= src_a >> src_b;
//            end
//            4'b0110: begin
//                result <= src_a | src_b;
//            end
//            4'b0111: begin
//                result <= src_a & src_b;
//            end
//            4'b1000: begin
//                result <= src_a - src_b;
//            end
//            4'b1101: begin
//                result <= src_a >>> src_b;
//            end
//            default: begin
//                result <= 32'b0;
//            end
//        endcase
//        flags[2] <= (src_a == src_b) ? 1 : 0;
//        flags[1] <= ($signed(src_a) < $signed(src_b)) ? 1 : 0;
//        flags[0] <= (src_a < src_b) ? 1 : 0;
//    end

    always_comb begin
            // --- ALU Operations ---
        case (control)
            4'b0000: result = src_a + src_b;                   // ADD (funct3=0, bit0=0)
            4'b0001: result = src_a - src_b;                   // SUB (funct3=0, bit0=1)
            4'b0010: result = src_a << src_b[4:0];             // SLL (funct3=1, bit0=0)
            4'b0100: result = ($signed(src_a) < $signed(src_b)) ? 32'd1 : 32'd0; // SLT (funct3=2)
            4'b0110: result = (src_a < src_b) ? 32'd1 : 32'd0; // SLTU (funct3=3)
            4'b1000: result = src_a ^ src_b;                   // XOR (funct3=4)
            4'b1010: result = src_a >> src_b[4:0];             // SRL (funct3=5, bit0=0)
            4'b1011: result = $signed(src_a) >>> src_b[4:0];   // SRA (funct3=5, bit0=1)
            4'b1100: result = src_a | src_b;                   // OR (funct3=6)
            4'b1110: result = src_a & src_b;                   // AND (funct3=7)
            default: result = 32'b0;
        endcase
    
            // --- Branch Flags ---
            // flags[2]: Zero (BEQ/BNE), flags[1]: Less Than Signed (BLT/BGE), flags[0]: Less Than Unsigned (BLTU/BGEU)
            flags[2] = (src_a == src_b);
            flags[1] = ($signed(src_a) < $signed(src_b));
            flags[0] = (src_a < src_b);
        end
endmodule