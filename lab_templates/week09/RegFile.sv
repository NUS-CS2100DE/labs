`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National University of Singapore
// Engineer: Neil Banerjee
// 
// Create Date: 22.02.2025 21:14:07
// Design Name: RISCV-MMC
// Module Name: RegFile
// Project Name: CS2100DE Labs
// Target Devices: Nexys 4/Nexys 4 DDR
// Tool Versions: Vivado 2023.2
// Description: Register file for our RISC-V CPU. Does not include FP registers.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RegFile(
    input clk,
    input we,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] WD,
    output reg [31:0] RD1,
    output reg [31:0] RD2
    );
    
    logic [31:0] reg_bank [0:31];

    always_comb begin
        RD1 <= (rs1 == 0) ? 32'b0 : reg_bank[rs1];
        RD2 <= (rs2 == 0) ? 32'b0 : reg_bank[rs2];
    end
    
    always @(posedge clk) begin
        if (rd != 5'b0 && we) begin
            reg_bank[rd] <= WD;
        end
    end
    
endmodule
