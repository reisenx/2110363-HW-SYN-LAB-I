`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/01/2025 02:17:23 AM
// Design Name: BCD_Counter
// Module Name: SevenSegmentDecoder
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Seven Segment Decoder Module
//////////////////////////////////////////////////////////////////////////////////

// This module is already implemented for you. You can use this module in your design.
module SevenSegmentDecoder (
    input  wire [3:0] DataIn,
    output wire [7:0] Segments
);
  reg [7:0] segments = 8'b11111111;
  assign Segments = segments;
  always @(*) begin
    case (DataIn)
      4'b0000: segments = 8'b00000011;
      4'b0001: segments = 8'b10011111;
      4'b0010: segments = 8'b00100101;
      4'b0011: segments = 8'b00001101;
      4'b0100: segments = 8'b10011001;
      4'b0101: segments = 8'b01001001;
      4'b0110: segments = 8'b01000001;
      4'b0111: segments = 8'b00011111;
      4'b1000: segments = 8'b00000001;
      4'b1001: segments = 8'b00001001;
      4'b1010: segments = 8'b00010001;
      4'b1011: segments = 8'b11000001;
      4'b1100: segments = 8'b01100011;
      4'b1101: segments = 8'b10000101;
      4'b1110: segments = 8'b01100001;
      4'b1111: segments = 8'b01110001;
      default: segments = 8'b11111111;
    endcase
  end
endmodule
