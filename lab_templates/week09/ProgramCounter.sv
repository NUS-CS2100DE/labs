`timescale 1ns / 1ps
/*
----------------------------------------------------------------------------------
-- Company: NUS	
-- Engineer: (c) Rajesh Panicker  
-- 
-- Create Date: 09/22/2020 06:49:10 PM
-- Module Name: ProgramCounter
-- Project Name: CG3207 Project
-- Target Devices: Nexys 4 / Basys 3
-- Tool Versions: Vivado 2019.2
-- Description: RISC-V Processor Program Counter Module
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

module ProgramCounter(
    input clk,
    input rst,
    input [31:0] pc_in,
    output reg [31:0] pc  
    );
    
    //Perhaps pass the default PC value as a parameter from Wrapper. For future.
    // V2: Initialization for PC.
    initial begin 
        pc <= 32'h00000000; // Should be the same as IROM_BASE in Wrapper.v, 
        					//  and the .txt starting address in RARS Memory Configuration.
        					// RARS default = 32'h00400000. It is 32'h00000000 for compact memory configuration with .text at 0
    end
    
    always @(posedge clk) begin
        if(rst)
            pc <= 32'h00000000; // Should be the same as the initial value above.
        else 
            pc <= pc_in ;        
    end
    
endmodule