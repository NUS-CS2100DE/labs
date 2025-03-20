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

	assign mem_read = mem_to_reg; // This is needed for the proper functionality of some devices such as UART CONSOLE

	// Create all the wires/logic signals you need here

	// Instantiate your extender module here

	// Instantiate your instruction decoder here

	// Instantiate your ALU here



	// Instantiate the Register File

	// Instantiate the PC Logic

	// Instantiate the Program Counter

endmodule
