`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National University of Singapore
// Engineer: Neil Banerjee
// 
// Create Date: 22.02.2025 20:37:13
// Design Name: RISCV-MMC
// Module Name: Decoder 
// Project Name: CS2100DE Labs
// Target Devices: Nexys 4/Nexys 4 DDR
// Tool Versions: Vivado 2023.2
// Description: Instruction decoder and Control Unit for the RISC-V CPU we are building
// 
// Dependencies: Nil
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Decoder(    
    input instr,
    output PCS,
    output mem_to_reg,
    output mem_write,
    output alu_control,
    output alu_src_b,
    output imm_src,
    output reg_write
    );
    
    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;

    assign opcode = 0;
    assign funct3 = 0;
    assign funct7 = 0;
    
    always @(instr) begin

    end

endmodule
