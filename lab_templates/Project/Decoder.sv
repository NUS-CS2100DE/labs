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
    input reg [31:0]instr,
    output reg [1:0] PCS,
    output reg mem_to_reg,
    output reg mem_write,
    output reg [3:0] alu_control,
    output reg [1:0] alu_src_a,
    output reg [1:0] alu_src_b,
    output reg [2:0] imm_src,
    output reg reg_write
    );
    
    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic ALUControl_0;
    
//    assign ALUControl_0 = 0;
    assign opcode = instr[6:0];
    assign funct3 = instr[14:12];
    assign funct7 = instr[31:25];
    
    always @(instr) begin
        case(opcode)
            7'h33:begin //DP Reg
                PCS = 2'b00;
                mem_to_reg = 0;
                mem_write =0;
                alu_control = {funct3,funct7[5]};
                alu_src_a = 2'bx0;
                alu_src_b = 2'bx0;;
                imm_src = 3'bxxx;
                reg_write = 1;
            end
            7'h13:begin //DP Imm
                if(funct3==3'h1)begin
                    ALUControl_0 = funct7[5];
                end else if (funct3==33'h5) begin
                    ALUControl_0  = funct7[5];
                end else begin
                    ALUControl_0  = 1'b0;
                end
//                ALUControl_0 = ((funct3==3'h1)|(funct3==33'h5)))?funct7[5]:1'b0;
                PCS = 2'b00;
                mem_to_reg = 0;
                mem_write =0;
                alu_control = {funct3,ALUControl_0};
                alu_src_a = 2'bx0;
                alu_src_b = 2'b11;
                imm_src = 3'b011;
                reg_write = 1;
            end
            7'h03:begin //Load
                PCS = 2'b00;
                mem_to_reg = 1;
                mem_write =0;
                alu_control = 4'b0000;
                alu_src_a = 2'bx0;
                alu_src_b = 2'b11;
                imm_src = 3'b011;
                reg_write = 1;
            end
            7'h23:begin
                PCS = 2'b00; // store
                mem_to_reg = 1'bx;
                mem_write =1;
                alu_control = 4'b0000;
                alu_src_a = 2'bx0;
                alu_src_b = 2'b11;
                imm_src = 3'b110;
                reg_write = 0;
            end
            7'h63:begin //branch
                PCS = 2'b01;
                mem_to_reg = 1'bx;
                mem_write =0;
                alu_control = 4'b0001;
                alu_src_a = 2'bx0;
                alu_src_b = 2'bx0;
                imm_src = 3'b111;
                reg_write = 0;
            end
            7'h6F:begin // jal
                PCS = 2'b10;
                mem_to_reg = 1'b0;
                mem_write =0;
                alu_control = 4'b0000;
                alu_src_a = 2'b11;
                alu_src_b = 2'b01;
                imm_src = 3'b010;
                reg_write = 1;
            end
            7'h17:begin //auipc
                PCS = 2'b00;
                mem_to_reg = 0;
                mem_write =0;
                alu_control = 4'b0000;
                alu_src_a = 2'b11;
                alu_src_b = 2'b11;
                imm_src = 3'b000;
                reg_write = 1;
            end
            7'h37:begin //lui
                PCS = 2'b00;
                mem_to_reg = 0;
                mem_write =0;
                alu_control = 4'b0000;
                alu_src_a = 2'b01;
                alu_src_b = 2'b11;
                imm_src = 3'b000;
                reg_write = 1;
            end
            7'h67:begin //jalr
                PCS = 2'b11;
                mem_to_reg = 0;
                mem_write =0;
                alu_control = 4'b0000;
                alu_src_a = 2'b11;
                alu_src_b = 2'b01;
                imm_src = 3'b011;
                reg_write = 1;
            end
        endcase

    end

endmodule
