`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National University of Singapore
// Engineer: Neil Banerjee
// 
// Create Date: 06.03.2025 23:18:08
// Design Name: RISCV-MMC
// Module Name: Decoder_Extend_sim
// Project Name: CS2100DE Labs
// Target Devices: Nexys4/Nexys 4 DDR
// Tool Versions: Vivado 2023.2
// Description: Simulating the decoder and immediate extender
// 
// Dependencies: Nil
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Decoder_Extend_sim(

    );
    
    logic [31:0] instr;
    logic imm_src;
    
    logic PCS;
    logic mem_to_reg;
    logic mem_write;
    logic alu_control;
    logic alu_src_b;
    logic reg_write;
    
    logic [31:0] ext_imm;
    
    Decoder decoder_uut (
        .instr(instr),
        .PCS(PCS),
        .imm_src(imm_src),
        .mem_to_reg(mem_to_reg),
        .mem_write(mem_write),
        .alu_control(alu_control),
        .alu_src_b(alu_src_b),
        .reg_write(reg_write)
    );
    
    Extend extender_uut (
        .instr_imm(instr[31:7]),
        .imm_src(imm_src),
        .ext_imm(ext_imm)
    );
    
    initial begin
        instr <= 32'hFF8A0A13; // corresponds to addi x20, x20, -8
        #10;
    end
    
endmodule