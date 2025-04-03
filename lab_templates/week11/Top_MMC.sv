`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National University of Singapore
// Engineer: Neil Banerjee
// 
// Create Date: 02.04.2025 17:57:12
// Design Name: RISCV-MMC
// Module Name: Top_MMC
// Project Name: CS2100DE Labs
// Target Devices: Nexys 4/Nexys 4 DDR
// Tool Versions: Vivado 2023.2
// Description: The Top module for the CPU design. Encapsulates the memories and MMIO components. 
// 
// Dependencies: Nil
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Top_MMC(
    input clk,
    input btnCpuReset,
    input btnC,
    input btnU,
    input btnL,
    input btnR,
    input btnD,
    input [15:0] sw,
    output reg [15:0] led,
    output [6:0] seg,
    output [7:0] an
    );
    
    localparam LED_ADDRESS = 32'h2400;
    localparam SW_ADDRESS = 32'h2404;
    localparam BTN_ADDRESS = 32'h2408;
    localparam SS_ADDRESS = 32'h2418;
    
    logic [31:0] instruction_rom [0:255];
    logic [31:0] data_memory [0:255];
    
    logic clk_cpu;
    logic [31:0] instr;
    logic [31:0] mem_read_data;
    logic mem_read;
    logic mem_we;
    logic [31:0] PC;
    logic [31:0] mem_addr;
    logic [31:0] mem_write_data;
    
    logic [31:0] seven_seg_data;
    
    // ONLY FOR SIMULATION - COMMENT OUT FOR HARDWARE IMPLEMENTATION!!!
//    assign clk_cpu = clk; 
    
    // ONLY FOR HARDWARE IMPLEMENTATION - COMMENT OUT FOR SIMULATION!!!
    logic [3:0] counter;
    assign clk_cpu = counter[3];
    
    always @(posedge clk) begin
        counter <= counter + 1;
    end
    
    // Initializing our instruction and data memories
    initial begin
        $readmemh("AA_IROM.mem", instruction_rom);
        $readmemh("AA_DMEM.mem", data_memory);
        
        counter <= 0;
        led <= 0;
        seven_seg_data <= 0;
    end
    
    // Returning instruction words from the instruction memory. Memory reading is combinational. 
    always_comb begin
        if (PC >= 32'h0 && PC < 32'hFF) begin
            instr <= instruction_rom[PC[10:2]];
        end
        else begin
            instr <= 32'hBAAAAAAD;
        end
    end
    
    // Returning data words from the data memory or MMIO. Memory reading is combinational. 
    always_comb begin
        if (mem_addr >= 32'h2000 && mem_addr <= 32'h20FF) begin
            mem_read_data <= data_memory[mem_addr[10:2]];
        end
        else if (mem_addr == SW_ADDRESS) begin
            mem_read_data <= {16'b0, sw};
        end
        else if (mem_addr == BTN_ADDRESS) begin
            mem_read_data <= {27'b0, btnC, btnU, btnL, btnR, btnD}; 
        end
        else begin
            mem_read_data <= 32'hDDEEAADD;
        end
    end
    
    // Writing data words to the data memory or MMIO. Memory writing is sequential. 
    always @(posedge clk_cpu) begin
        if (mem_we) begin
            if (mem_addr >= 32'h2000 && mem_addr <= 32'h20FF) begin
                data_memory[mem_addr[10:2]] <= mem_write_data;
            end
            else if (mem_addr == LED_ADDRESS) begin
                led <= mem_write_data[15:0];
            end
            else if (mem_addr == SS_ADDRESS) begin
                seven_seg_data <= mem_write_data;
            end
        end
    end
    
    // Similar architecture to the one designed in Lab 2/3
    SevenSegDecoder ss_decoder (
        .clk(clk_cpu),
        .data(seven_seg_data),
        .seg(seg),
        .an(an)
    );
    
    // Our CPU
    RISCV_MMC cpu (
        .clk(clk_cpu),
        .rst(!btnCpuReset),
        .instr(instr),
        .mem_read_data(mem_read_data),
        .mem_read(mem_read),
        .mem_write(mem_we),
        .PC(PC),
        .alu_result(mem_addr),
        .mem_write_data(mem_write_data)
    );
    
endmodule
