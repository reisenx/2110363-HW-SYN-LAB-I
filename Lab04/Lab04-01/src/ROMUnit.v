`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/15/2025 09:47:52 PM
// Design Name: BinaryToDecimal
// Module Name: ROMUnit
// Project Name: BinaryToDecimal
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: The ROM Unit for the Binary to Decimal conversion Module
//////////////////////////////////////////////////////////////////////////////////


module ROMUnit (
    input wire [5:0] Address,
    input wire Clk,
    input wire Reset,
    output wire [15:0] DataOut
);
  // Add your code here
  reg [7:0] mem[63:0];

  // End of your code
`ifdef COCOTB_SIM
  initial begin
    $dumpfile("waveform.vcd");  // Name of the dump file
    $dumpvars(0, ROMUnit);  // Dump all variables for the top module
  end
`endif
endmodule
