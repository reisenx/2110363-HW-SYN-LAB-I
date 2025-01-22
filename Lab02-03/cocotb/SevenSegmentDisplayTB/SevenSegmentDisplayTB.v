`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/01/2025 02:12:30 AM
// Design Name: BCD_Counter
// Module Name: SevenSegmentDisplayTB
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Instantiate SevenSegmentDisplay module for cocotb
//////////////////////////////////////////////////////////////////////////////////


module SevenSegmentDisplayTB (
    input wire [15:0] DataIn,
    input wire Clk,
    input wire Reset,
    output wire [7:0] Segments,
    output wire [3:0] AN
);
  SevenSegmentDisplay #(
      .ControllerClockCycle  (100),
      .ControllerCounterWidth(10)
  ) SevenSegmentDisplayInst (
      .DataIn  (DataIn),
      .Clk     (Clk),
      .Reset   (Reset),
      .Segments(Segments),
      .AN      (AN)
  );
  // cocotb dump waveforms
`ifdef COCOTB_SIM
  initial begin
    $dumpfile("waveform.vcd");  // Name of the dump file
    $dumpvars(0, SevenSegmentDisplayTB);  // Dump all variables for the top module
  end
`endif
endmodule
