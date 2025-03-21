`timescale 1ns / 1ps
/*
----------------------------------------------------------------------------------
-- Company: NUS	
-- Engineer: (c) Rajesh Panicker  
-- 
-- Create Date: 09/22/2020 06:49:10 PM
-- Module Name: CondLogic
-- Project Name: CG3207 Project
-- Target Devices: Nexys 4 / Basys 3
-- Tool Versions: Vivado 2019.2
-- Description: RISC-V Processor Conditional Logic Module
-- 
-- Dependencies: NIL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Interface and implementation can be modified.
-- 
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
--	License terms :
--	You are free to use this code as long as you
--		(i) DO NOT post it on any public repository;
--		(ii) use it only for educational purposes;
--		(iii) accept the responsibility to ensure that your implementation does not violate anyone's intellectual property.
--		(iv) accept that the program is provided "as is" without warranty of any kind or assurance regarding its suitability for any particular purpose;
--		(v) send an email to rajesh<dot>panicker<at>ieee.org briefly mentioning its use (except when used for the course CG3207 at the National University of Singapore);
--		(vi) retain this notice in this file as well as any files derived from this.
----------------------------------------------------------------------------------
*/

module PC_Logic( // This is a combinational module, unlike ARM. See the note below.
	input [1:0] PCS,	// 00 for non-control, 01 for conditional branch, 10 for jal, 11 for jalr
	input [2:0] funct3,	// condition specified in the instruction (eq / ne / lt / ge / ltu / geu)
	input [2:0] alu_flags, 	// {eq, lt, ltu}
	output reg PC_src	// will need to be expanded to 2 bits to support jalr
    );
    
    /* 
    	Important Note : alu_flags are not *stored* in flag registers in RISC-V, unlike ARM and most other processors.
    	In RISC-V, the flags are produced and consumed in the same branch instruction. 
    	The effect of CMP R1, R2 and BEQ LABEL in ARM is beq x1, x2, LABEL in RISC-V.
    */
    
    
	always @(*) begin
		case (PCS)
			2'b00: PC_src <= 2'b00;
			2'b01: // branch
				case (funct3)
					3'b000: PC_src      <= { 1'b0, alu_flags[2] };
					3'b001: PC_src      <= { 1'b0, ~alu_flags[2] };
					3'b100: PC_src      <= { 1'b0, alu_flags[1] };
					3'b101: PC_src      <= { 1'b0, ~alu_flags[1] };
					3'b110: PC_src      <= { 1'b0, alu_flags[0] };
					3'b111: PC_src      <= { 1'b0, ~alu_flags[0] };
					default: PC_src      <= 2'b0;
				endcase
			2'b10: PC_src      <= 2'b01;
			2'b11: PC_src      <= 2'b11;
			default: PC_src    <= 2'b00;
		endcase
	end
	
	
endmodule