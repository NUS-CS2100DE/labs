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
    input [4:0] control,
    output reg [31:0] result,
    output reg [2:0] flags
    );

    // 64-bit products for M-extension multiply instructions.
    // Operands are explicitly widened before multiply so SV performs 64-bit arithmetic.
    wire [63:0] mul_uu = {32'b0, src_a} * {32'b0, src_b};                                              // MULHU
    wire signed [63:0] mul_ss = $signed({{32{src_a[31]}}, src_a}) * $signed({{32{src_b[31]}}, src_b}); // MULH
    // For MULHSU: src_a signed, src_b unsigned.
    // {32'b0, src_b} has bit-63 = 0, so $signed treats it as a non-negative 64-bit value —
    // identical to interpreting src_b as unsigned. Both operands then signed → correct result.
    wire signed [63:0] mul_su = $signed({{32{src_a[31]}}, src_a}) * $signed({32'b0, src_b});            // MULHSU
    
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
        // --- Base RV32I operations (control[4] == 0) ---
        // Encoding: {1'b0, funct3[2:0], funct7[5]}
        // --- RV32M operations (control[4] == 1) ---
        // Encoding: {1'b1, funct3[2:0], 1'b0}
        case (control)
            // Base ISA
            5'b00000: result = src_a + src_b;                                        // ADD
            5'b00001: result = src_a - src_b;                                        // SUB
            5'b00010: result = src_a << src_b[4:0];                                  // SLL
            5'b00100: result = ($signed(src_a) < $signed(src_b)) ? 32'd1 : 32'd0;   // SLT
            5'b00110: result = (src_a < src_b) ? 32'd1 : 32'd0;                     // SLTU
            5'b01000: result = src_a ^ src_b;                                        // XOR
            5'b01010: result = src_a >> src_b[4:0];                                  // SRL
            5'b01011: result = $signed(src_a) >>> src_b[4:0];                        // SRA
            5'b01100: result = src_a | src_b;                                        // OR
            5'b01110: result = src_a & src_b;                                        // AND

            // M Extension — multiply
            5'b10000: result = src_a * src_b;                                        // MUL   (lower 32)
            5'b10010: result = mul_ss[63:32];                                        // MULH  (signed × signed, upper 32)
            5'b10100: result = mul_su[63:32];                                        // MULHSU (signed × unsigned, upper 32)
            5'b10110: result = mul_uu[63:32];                                        // MULHU (unsigned × unsigned, upper 32)

            // M Extension — divide / remainder
            // Division by zero: quotient = -1 (0xFFFF_FFFF), remainder = dividend (per RISC-V spec)
            // Signed overflow (INT_MIN / -1): quotient = INT_MIN, remainder = 0 (per RISC-V spec)
            5'b11000: result = (src_b == 32'b0) ? 32'hFFFF_FFFF :                   // DIV
                               ((src_a == 32'h8000_0000 && src_b == 32'hFFFF_FFFF) ? 32'h8000_0000 :
                               $signed(src_a) / $signed(src_b));

            5'b11010: result = (src_b == 32'b0) ? 32'hFFFF_FFFF :                   // DIVU
                               (src_a / src_b);

            5'b11100: result = (src_b == 32'b0) ? src_a :                           // REM
                               ((src_a == 32'h8000_0000 && src_b == 32'hFFFF_FFFF) ? 32'b0 :
                               $signed(src_a) % $signed(src_b));

            5'b11110: result = (src_b == 32'b0) ? src_a :                           // REMU
                               (src_a % src_b);

            default:  result = 32'b0;
        endcase

        // Branch flags — always computed from the raw register values
        // flags[2]: EQ (BEQ/BNE), flags[1]: LT signed (BLT/BGE), flags[0]: LT unsigned (BLTU/BGEU)
        flags[2] = (src_a == src_b);
        flags[1] = ($signed(src_a) < $signed(src_b));
        flags[0] = (src_a < src_b);
    end
endmodule