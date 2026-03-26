`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National University of Singapore
// Engineer: Neil Banerjee
// 
// Create Date: 05.03.2025 23:43:42
// Design Name: RISCV-MMC
// Module Name: Extend
// Project Name: CS2100DE Labs
// Target Devices: Nexys 4/Nexys 4 DDR
// Tool Versions: Vivado 2023.2
// Description: Module for extending immediates
// 
// Dependencies: Nil
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Extend(
    input [31:0] InstrImm,
    input [2:0] ImmSrc,
    output reg [31:0] ExtImm
    );
    always@(InstrImm,ImmSrc)
        case(ImmSrc)
            3'b000: ExtImm = {InstrImm[31:12], 12'h000} ;  // U type
            3'b010: ExtImm = {{12{InstrImm[31]}}, InstrImm[19:12], InstrImm[20], InstrImm[30:21], 1'b0} ;   // UJ   
            3'b011: ExtImm = {{20{InstrImm[31]}}, InstrImm[31:20]} ;  // I    
            3'b110: ExtImm = {{20{InstrImm[31]}}, InstrImm[31:25], InstrImm[11:7]} ;  // S    
            3'b111: ExtImm = {{20{InstrImm[31]}}, InstrImm[7], InstrImm[30:25], InstrImm[11:8], 1'b0} ;  // SB    
            default: ExtImm = 32'bx ;  // undefined     
        endcase   
endmodule
