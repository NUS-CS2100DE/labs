`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National University of Singapore
// Engineer: Neil Banerjee
// 
// Create Date: 22.02.2025 21:29:09
// Design Name: RISCV-MMC
// Module Name: RISCV_MMC
// Project Name: CS2100DE Labs
// Target Devices: Nexys 4/Nexys 4 DDR
// Tool Versions: Vivado 2023.2
// Description: The main RISC-V CPU 
// 
// Dependencies: Nil
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RISCV_MMC(
    input clk,
    input rst,
    //input Interrupt,      // for optional future use.
    input [31:0] instr,
    input [31:0] mem_read_data,       // v2: Renamed to support lb/lbu/lh/lhu
    output mem_read,
    output reg mem_write,  // Delete reg for release. v2: Changed to column-wise write enable to support sb/sw. Each column is a byte.
    output [31:0] PC,
    output [31:0] alu_result,
    output reg [31:0] mem_write_data  // Delete reg for release. v2: Renamed to support sb/sw
    );

    logic [2:0] ImmSrc;
    logic [1:0] PCS;
    logic mem_to_reg;
//    logic mem_write;
    logic [3:0] alu_control;
    logic [1:0] alu_src_a;
    logic [1:0] alu_src_b;
//    logic imm_src;
    logic reg_write;
    logic [31:0] ExtImm;
//    logic [31:0] alu_result;
    logic [2:0] alu_flags;
    
    logic [31:0] RD1;
    logic [31:0] SrcA;
    logic [31:0] SrcA_PC;
    logic [31:0] SrcB;
    logic [31:0] SrcB_Ext;
    logic[31:0] RD2;
    
    logic [2:0] funct3;
    logic [31:0] WD;
    logic [31:0] pc_in;
    logic [1:0] PC_src;
    
    assign pc_in = ((PC_src[1]==1)?RD1:PC) + ((PC_src[0]==1)?ExtImm:32'd4);
    
    assign funct3 = instr[14:12];
    
    assign WD = (mem_to_reg==1)? mem_read_data:alu_result;
    
    assign mem_read = mem_to_reg; // This is needed for the proper functionality of some devices such as UART CONSOLE
    
    assign SrcA_PC = (alu_src_a[1]==0)?32'h0000:PC;
    assign SrcA = (alu_src_a[0]==0)?RD1:SrcA_PC;
    
    assign SrcB_Ext = (alu_src_b[1]==0)?32'h0004:ExtImm;
    assign SrcB = (alu_src_b[0]==0)?RD2:SrcB_Ext;
    

	// Create all the wires/logic signals you need here

	// Instantiate your extender module here
	Extend extend(
    .InstrImm(instr[31:0]),
    .ImmSrc(ImmSrc),
    .ExtImm(ExtImm)
    );


	// Instantiate your instruction decoder here
	Decoder decoder(    
    .instr(instr),
    .PCS(PCS),
    .mem_to_reg(mem_to_reg),
    .mem_write(mem_write),
    .alu_control(alu_control),
    .alu_src_a(alu_src_a),
    .alu_src_b(alu_src_b),
    .imm_src(ImmSrc),
    .reg_write(reg_write)
    );

	// Instantiate your ALU here
	ALU alu(
    .src_a(SrcA),
    .src_b(SrcB),
    .control(alu_control),
    .result(alu_result), 
    .flags(alu_flags)
    );



	// Instantiate the Register File
	RegFile regfile(
    .clk(clk),
    .we(reg_write),
    .rs1(instr[19:15]),
    .rs2(instr[24:20]),
    .rd(instr[11:7]),
    .WD(WD),
    .RD1(RD1),
    .RD2(RD2)
    );

	// Instantiate the PC Logic
	PC_Logic pc_logic( // This is a combinational module, unlike ARM. See the note below.
	.PCS(PCS),	// 00 for non-control, 01 for conditional branch, 10 for jal, 11 for jalr
	.funct3(funct3),	// condition specified in the instruction (eq / ne / lt / ge / ltu / geu)
	.alu_flags(alu_flags), 	// {eq, lt, ltu}
	.PC_src(PC_src)	// will need to be expanded to 2 bits to support jalr
    );

	// Instantiate the Program Counter
	ProgramCounter programcounter(
    .clk(clk),
    .rst(rst),
    .pc_in(pc_in),
    .pc(PC)  
    );

endmodule
