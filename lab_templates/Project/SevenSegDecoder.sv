`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2025 19:02:15
// Design Name: 
// Module Name: SevenSegDecoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SevenSegDecoder(
    input clk,
    input [31:0] data,
    output reg [6:0] seg,
    output reg [7:0] an
    );
    
    logic [12:0] counter;
    logic [2:0] an_to_display;
    
    logic [3:0] byte_to_display;
    
    assign seg = (byte_to_display == 4'b0000) ? 7'b1000000  // 0
                : (byte_to_display == 4'b0001) ? 7'b1111001  // 1
                : (byte_to_display == 4'b0010) ? 7'b0100100  // 2
                : (byte_to_display == 4'b0011) ? 7'b0110000  // 3
                : (byte_to_display == 4'b0100) ? 7'b0011001  // 4
                : (byte_to_display == 4'b0101) ? 7'b0010010  // 5
                : (byte_to_display == 4'b0110) ? 7'b0000010  // 6
                : (byte_to_display == 4'b0111) ? 7'b1111000  // 7
                : (byte_to_display == 4'b1000) ? 7'b0000000  // 8
                : (byte_to_display == 4'b1001) ? 7'b0010000  // 9
                : (byte_to_display == 4'b1010) ? 7'b0001000  // A
                : (byte_to_display == 4'b1011) ? 7'b0000011  // b
                : (byte_to_display == 4'b1100) ? 7'b1000110  // C
                : (byte_to_display == 4'b1101) ? 7'b0100001  // d
                : (byte_to_display == 4'b1110) ? 7'b0000110  // E
                : (byte_to_display == 4'b1111) ? 7'b0001110  // F
                : 7'b1111111;    
    
    initial begin
        counter <= 0;
        an_to_display <= 0;
    end
    
    always @(posedge clk) begin
        counter <= counter + 1;
        if (counter == 0) begin
            an_to_display <= an_to_display + 1;
        end
        
        case (an_to_display)
          3'b000: begin // Select highest nibble (bits 31-28), activate AN7
            byte_to_display <= data[31:28];
            an <= ~8'h80; // 1000 0000
          end
          3'b001: begin // Select next nibble (bits 27-24), activate AN6
            byte_to_display <= data[27:24];
            an <= ~8'h40; // 0100 0000
          end
          3'b010: begin // Select next nibble (bits 23-20), activate AN5
            byte_to_display <= data[23:20];
            an <= ~8'h20; // 0010 0000
          end
          3'b011: begin // Select next nibble (bits 19-16), activate AN4
            byte_to_display <= data[19:16];
            an <= ~8'h10; // 0001 0000
          end
          3'b100: begin // Select next nibble (bits 15-12), activate AN3
            byte_to_display <= data[15:12];
            an <= ~8'h08; // 0000 1000
          end
          3'b101: begin // Select next nibble (bits 11-8), activate AN2
            byte_to_display <= data[11:8];
            an <= ~8'h04; // 0000 0100
          end
          3'b110: begin // Select next nibble (bits 7-4), activate AN1
            byte_to_display <= data[7:4];
            an <= ~8'h02; // 0000 0010
          end
          3'b111: begin // Select lowest nibble (bits 3-0), activate AN0
            byte_to_display <= data[3:0];
            an <= ~8'h01; // 0000 0001
          end
          default: begin // Optional: Handle unexpected cases (e.g., 'x' or 'z')
            byte_to_display <= 4'b0; // Display 0 or blank
            an <= ~8'h00;             // Turn off all anodes/selectors (or 8'hFF depending on logic)
          end
        endcase
    end
endmodule
