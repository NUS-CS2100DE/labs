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
    input [31:0] instrF,
    input [31:0] ReadDataM,       // v2: Renamed to support lb/lbu/lh/lhu
    output mem_read,
    output reg mem_writeM,  // Delete reg for release. v2: Changed to column-wise write enable to support sb/sw. Each column is a byte.
    output [31:0] pcF,
    output [31:0] alu_result,
    output reg [31:0] WriteDataM  // Delete reg for release. v2: Renamed to support sb/sw
    );
    
    
    
    //D Stage
    logic [31:0] instrD;
    logic [1:0] PCSD;
    logic reg_writeD;
    logic mem_to_regD;
    logic mem_writeD;
    logic [3:0] alu_controlD;
    logic [1:0] alu_src_aD;
    logic [1:0] alu_src_bD;
    logic [31:0] RD1D;
    logic[31:0] RD2D;
    logic [31:0] ExtImmD;
    logic [4:0] rdD;
    logic [31:0] pcD;
    logic [2:0]funct3D;
    
    logic [2:0] ImmSrc;
    
    assign funct3D = instrD[14:12];
    assign rdD = instrD[11:7];
    
    // E Stage
    logic [1:0] PCSE;
    logic reg_writeE;
    logic mem_to_regE;
    logic mem_writeE;
    logic [3:0] alu_controlE;
    logic [1:0] alu_src_aE;
    logic [1:0] alu_src_bE;
    logic [31:0] RD1E;
    logic[31:0] RD2E;
    logic [31:0] ExtImmE;
    logic [4:0] rdE;
    logic [31:0] pcE;
    
    logic [31:0] SrcA;
    logic [31:0] SrcA_PC;
    logic [31:0] SrcB;
    logic [31:0] SrcB_Ext;
    
    logic [1:0] PC_src;
    logic [31:0] pc_in;
    logic [2:0] alu_flags;
    logic [2:0]funct3E;
    
    assign SrcA_PC = (alu_src_aE[1]==0)?32'h0000:pcE;
    assign SrcA = (alu_src_aE[0]==0)?RD1E:SrcA_PC;
    
    assign SrcB_Ext = (alu_src_bE[1]==0)?32'h0004:ExtImmE;
    assign SrcB = (alu_src_bE[0]==0)?RD2E:SrcB_Ext;
//    assign pc_in = ((PC_src[1]==1)?RD1E:pcF) + ((PC_src[0]==1)?ExtImmE:32'd4); // need to or the pcf and pce
    
    logic [31:0] WriteDataE;
    logic [31:0] alu_resultE;

    //M Stage  
    logic reg_writeM;
    logic mem_to_regM;
//    logic mem_writeM;
//    logic [31:0] WriteDataM;
    logic [31:0] alu_resultM;
    logic [4:0] rdM;
    assign alu_result = alu_resultM;
    
    //W Stage
    logic reg_writeW;
    logic mem_to_regW;
    logic [31:0] WriteDataW;
    logic [4:0] rdW;
    logic [31:0] ReadDataW;
    logic [31:0] alu_resultW;
   
    
    logic [31:0] WD;
    
    assign WD = (mem_to_regW==1)? ReadDataW:alu_resultW;
    
//    assign mem_read = mem_to_reg; // This is needed for the proper functionality of some devices such as UART CONSOLE
    

    always @(*) begin
        case (PC_src)
            2'b00: pc_in = pcF +4; // normal
            2'b01: pc_in = pcE +ExtImmE; // branch
            2'b10: pc_in = pcE +ExtImmE; // jal
            2'b11: pc_in = RD1E +ExtImmE; // jalr
            default: pc_in = pcF +4;
        endcase
    end

	// Create all the wires/logic signals you need here
	always@(posedge clk)begin
	   // F to D
	   instrD<=instrF; 
	   pcD <=pcF;
	   // D to E
	   funct3E<=funct3D;
       PCSE<=PCSD;
       reg_writeE<=reg_writeD;
       mem_to_regE<=mem_to_regD;
       mem_writeE<=mem_writeD;
       alu_controlE<=alu_controlD;
       alu_src_aE<=alu_src_aD;
       alu_src_bE<=alu_src_bD;
       RD1E<=RD1D;
       RD2E<=RD2D;
       ExtImmE<=ExtImmD;
       rdE<=rdD;
       pcE<=pcD;
       // E to M

       reg_writeM<=reg_writeE;
       mem_to_regM<=mem_to_regE;
       mem_writeM<=mem_writeE;
       rdM<=rdE;
       alu_resultM<=alu_resultE;
       rdM<=rdE;
//       case (PC_src) // store return address
//            2'b00: rdM<=rdE; // normal
//            2'b01: rdM<=rdE; // branch
//            2'b10: rdM<=rdE; // jal
//            2'b11: rdM<=rdE; // jalr
//            default: rdM<=rdE;
//        endcase
       // M to W
       reg_writeW<=reg_writeM;
       mem_to_regW<=mem_to_regM;
       rdW<=rdM;
       alu_resultW <= alu_resultM;
       rdW<=rdM;
	
	end

	// Instantiate your extender module here
	Extend extend(
    .InstrImm(instrD[31:0]),
    .ImmSrc(ImmSrc),
    .ExtImm(ExtImmD)
    );


	// Instantiate your instruction decoder here
	Decoder decoder(    
    .instr(instrD),
    .PCS(PCSD),
    .mem_to_reg(mem_to_regD),
    .mem_write(mem_writeD),
    .alu_control(alu_controlD),
    .alu_src_a(alu_src_aD),
    .alu_src_b(alu_src_bD),
    .imm_src(ImmSrc),
    .reg_write(reg_writeD)
    );

	// Instantiate your ALU here
	ALU alu(
    .src_a(SrcA),
    .src_b(SrcB),
    .control(alu_controlE),
    .result(alu_resultE), 
    .flags(alu_flags)
    );



	// Instantiate the Register File
	RegFile regfile(
    .clk(clk),
    .we(reg_writeW),
    .rs1(instrD[19:15]),
    .rs2(instrD[24:20]),
    .rd(rdW),
    .WD(WD),
    .RD1(RD1D),
    .RD2(RD2D)
    );

	// Instantiate the PC Logic
	PC_Logic pc_logic( // This is a combinational module, unlike ARM. See the note below.
	.PCS(PCSE),	// 00 for non-control, 01 for conditional branch, 10 for jal, 11 for jalr
	.funct3(funct3E),	// condition specified in the instruction (eq / ne / lt / ge / ltu / geu)
	.alu_flags(alu_flags), 	// {eq, lt, ltu}
	.PC_src(PC_src)	// will need to be expanded to 2 bits to support jalr
    );

	// Instantiate the Program Counter
	ProgramCounter programcounter(
    .clk(clk),
    .rst(rst),
    .pc_in(pc_in),
    .pc(pcF)  
    );

endmodule
