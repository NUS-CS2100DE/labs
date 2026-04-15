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
    input [31:0] ReadDataM,
    output mem_read,
    output reg mem_writeM,
    output reg [2:0] mem_funct3M,
    output [31:0] pcF,
    output [31:0] alu_result,
    output reg [31:0] WriteDataM
    );

    localparam [31:0] NOP_INSTR = 32'h00000013;

    // D stage
    logic [31:0] instrD;
    logic [1:0] PCSD;
    logic reg_writeD;
    logic mem_to_regD;
    logic mem_writeD;
    logic [4:0] alu_controlD;
    logic [1:0] alu_src_aD;
    logic [1:0] alu_src_bD;
    logic [31:0] RD1D;
    logic [31:0] RD2D;
    logic [31:0] ExtImmD;
    logic [4:0] rs1D;
    logic [4:0] rs2D;
    logic [4:0] rdD;
    logic [31:0] pcD;
    logic [31:0] pcDNew;
    logic [2:0] funct3D;
    logic [2:0] ImmSrc;

    assign rs1D = instrD[19:15];
    assign rs2D = instrD[24:20];
    assign rdD = instrD[11:7];
    assign funct3D = instrD[14:12];

    // E stage
    logic [1:0] PCSE;
    logic reg_writeE;
    logic mem_to_regE;
    logic mem_writeE;
    logic [4:0] alu_controlE;
    logic [1:0] alu_src_aE;
    logic [1:0] alu_src_bE;
    logic [31:0] RD1E;
    logic [31:0] RD2E;
    logic [31:0] ExtImmE;
    logic [4:0] rs1E;
    logic [4:0] rs2E;
    logic [4:0] rdE;
    logic [31:0] pcE;
    logic [2:0] funct3E;

    logic [31:0] ForwardedRD1E;
    logic [31:0] ForwardedRD2E;
    logic [31:0] SrcA;
    logic [31:0] SrcA_PC;
    logic [31:0] SrcB;
    logic [31:0] SrcB_Ext;
    logic [31:0] WriteDataE;
    logic [31:0] alu_resultE;
    logic [2:0] alu_flags;
    logic [1:0] PC_src;
    logic [31:0] pc_in;
    logic control_hazardE;

    // M stage
    logic reg_writeM;
    logic mem_to_regM;
    logic [31:0] alu_resultM;
    logic [4:0] rdM;
    logic [31:0] ResultM;

    // W stage
    logic reg_writeW;
    logic mem_to_regW;
    logic [4:0] rdW;
    logic [31:0] ReadDataW;
    logic [31:0] alu_resultW;
    logic [31:0] WD;

    assign alu_result = alu_resultM;
    assign mem_read = mem_to_regM;
    assign ResultM = mem_to_regM ? ReadDataM : alu_resultM;
    assign WD = mem_to_regW ? ReadDataW : alu_resultW;
    
    
    // if MemtoRegE == 1, AluResultE== rs1D and is not LUI AUIPC or JAL, AluResultE== rs2D and is r-type store or branch
    logic stall;
    logic uses_rs1;
    logic uses_rs2;
    logic [6:0] opcodeD;
    assign opcodeD = instrD[6:0];
    assign uses_rs1 = !(opcodeD == 7'h37 ||  // LUI
                        opcodeD == 7'h17 ||  // AUIPC
                        opcodeD == 7'h6F);   // JAL
  
    assign uses_rs2 = (opcodeD == 7'h33) || // R-type (add, sub, etc.)
                      (opcodeD == 7'h63) || // B-type (beq, bne, etc.)
                      (opcodeD == 7'h23);   // S-type (sw, sb, etc.)
                    
                    
                    
    always@(*) begin
        stall=0;
        if (mem_to_regE) begin
            if ((uses_rs1 && (rs1D == rdE)) || (uses_rs2 && (rs2D == rdE))) begin
                stall = 1;
            end
        end
    end
    
    

    always @(*) begin // forwarding
        ForwardedRD1E = RD1E;
        if (reg_writeM && (rdM != 5'd0) && (rdM == rs1E)) begin
            ForwardedRD1E = ResultM;
        end
        else if (reg_writeW && (rdW != 5'd0) && (rdW == rs1E)) begin
            ForwardedRD1E = WD;
        end
    end

    always @(*) begin // forwarding
        ForwardedRD2E = RD2E;
        if (reg_writeM && (rdM != 5'd0) && (rdM == rs2E)) begin
            ForwardedRD2E = ResultM;
        end
        else if (reg_writeW && (rdW != 5'd0) && (rdW == rs2E)) begin
            ForwardedRD2E = WD;
        end
    end

    assign SrcA_PC = alu_src_aE[1] ? pcE : 32'h0000_0000;
    assign SrcA = alu_src_aE[0] ? SrcA_PC : ForwardedRD1E;
    assign SrcB_Ext = alu_src_bE[1] ? ExtImmE : 32'd4;
    assign SrcB = alu_src_bE[0] ? SrcB_Ext : ForwardedRD2E;
    assign WriteDataE = ForwardedRD2E;

    always @(*) begin
        if(stall) begin
            pc_in = pcF;
        end
        else begin
            case (PC_src)
                2'b00: pc_in = pcF + 32'd4;
                2'b01: pc_in = pcE + ExtImmE;
                2'b10: pc_in = pcE + ExtImmE;
                2'b11: pc_in = ForwardedRD1E + ExtImmE;
                default: pc_in = pcF + 32'd4;
            endcase
        end
    end

    assign control_hazardE = (PC_src != 2'b00);
    
    assign pcDNew = control_hazardE? 32'b0:pcD; // flush

    initial begin
        instrD = NOP_INSTR;
        pcD = 32'd0;
        PCSE = 2'b00;
        reg_writeE = 1'b0;
        mem_to_regE = 1'b0;
        mem_writeE = 1'b0;
        alu_controlE = 5'b00000;
        alu_src_aE = 2'b00;
        alu_src_bE = 2'b00;
        RD1E = 32'd0;
        RD2E = 32'd0;
        ExtImmE = 32'd0;
        rs1E = 5'd0;
        rs2E = 5'd0;
        rdE = 5'd0;
        pcE = 32'd0;
        funct3E = 3'b000;
        reg_writeM = 1'b0;
        mem_to_regM = 1'b0;
        mem_writeM = 1'b0;
        mem_funct3M = 3'b000;
        alu_resultM = 32'd0;
        rdM = 5'd0;
        WriteDataM = 32'd0;
        reg_writeW = 1'b0;
        mem_to_regW = 1'b0;
        rdW = 5'd0;
        ReadDataW = 32'd0;
        alu_resultW = 32'd0;
    end

    always @(posedge clk) begin
        if (rst) begin
            instrD <= NOP_INSTR;
            pcD <= 32'd0;
            PCSE <= 2'b00;
            reg_writeE <= 1'b0;
            mem_to_regE <= 1'b0;
            mem_writeE <= 1'b0;
            alu_controlE <= 5'b00000;
            alu_src_aE <= 2'b00;
            alu_src_bE <= 2'b00;
            RD1E <= 32'd0;
            RD2E <= 32'd0;
            ExtImmE <= 32'd0;
            rs1E <= 5'd0;
            rs2E <= 5'd0;
            rdE <= 5'd0;
            pcE <= 32'd0;
            funct3E <= 3'b000;
            reg_writeM <= 1'b0;
            mem_to_regM <= 1'b0;
            mem_writeM <= 1'b0;
            mem_funct3M <= 3'b000;
            alu_resultM <= 32'd0;
            rdM <= 5'd0;
            WriteDataM <= 32'd0;
            reg_writeW <= 1'b0;
            mem_to_regW <= 1'b0;
            rdW <= 5'd0;
            ReadDataW <= 32'd0;
            alu_resultW <= 32'd0;
        end
        else begin
            // F to D
            if (control_hazardE) begin // stalling
                pcD <= 32'd0;
                instrD <= NOP_INSTR;
            end
            else if(stall)begin
                pcD <= pcD;
                instrD <= instrD;
            end
            else begin
                pcD <= pcF;
                instrD <= instrF;
            end

            // D to E
            if (control_hazardE||stall) begin // flush
                funct3E <= 3'b000;
                PCSE <= 2'b00;
                reg_writeE <= 1'b0;
                mem_to_regE <= 1'b0;
                mem_writeE <= 1'b0;
                alu_controlE <= 5'b00000;
                alu_src_aE <= 2'b00;
                alu_src_bE <= 2'b00;
                RD1E <= 32'd0;
                RD2E <= 32'd0;
                ExtImmE <= 32'd0;
                rs1E <= 5'd0;
                rs2E <= 5'd0;
                rdE <= 5'd0;
                pcE <= 32'd0;
            end
            else begin
                funct3E <= funct3D;
                PCSE <= PCSD;
                reg_writeE <= reg_writeD;
                mem_to_regE <= mem_to_regD;
                mem_writeE <= mem_writeD;
                alu_controlE <= alu_controlD;
                alu_src_aE <= alu_src_aD;
                alu_src_bE <= alu_src_bD;
                RD1E <= RD1D;
                RD2E <= RD2D;
                ExtImmE <= ExtImmD;
                rs1E <= rs1D;
                rs2E <= rs2D;
                rdE <= rdD;
                pcE <= pcDNew;
            end

            // E to M
            WriteDataM <= WriteDataE;
            reg_writeM <= reg_writeE;
            mem_to_regM <= mem_to_regE;
            mem_writeM <= mem_writeE;
            mem_funct3M <= funct3E;
            rdM <= rdE;
            alu_resultM <= alu_resultE;

            // M to W
            reg_writeW <= reg_writeM;
            mem_to_regW <= mem_to_regM;
            rdW <= rdM;
            ReadDataW <= ReadDataM;
            alu_resultW <= alu_resultM;
        end
    end

    Extend extend(
        .InstrImm(instrD[31:0]),
        .ImmSrc(ImmSrc),
        .ExtImm(ExtImmD)
    );

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

    ALU alu(
        .src_a(SrcA),
        .src_b(SrcB),
        .control(alu_controlE),
        .result(alu_resultE),
        .flags(alu_flags)
    );

    RegFile regfile(
        .clk(clk),
        .we(reg_writeW),
        .rs1(rs1D),
        .rs2(rs2D),
        .rd(rdW),
        .WD(WD),
        .RD1(RD1D),
        .RD2(RD2D)
    );

    PC_Logic pc_logic(
        .PCS(PCSE),
        .funct3(funct3E),
        .alu_flags(alu_flags),
        .PC_src(PC_src)
    );

    ProgramCounter programcounter(
        .clk(clk),
        .rst(rst),
        .pc_in(pc_in),
        .pc(pcF)
    );

endmodule
