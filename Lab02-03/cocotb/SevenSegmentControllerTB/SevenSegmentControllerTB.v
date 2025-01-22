`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/01/2025 02:12:30 AM
// Design Name: BCD_Counter
// Module Name: SevenSegmentControllerTB
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Instantiate SevenSegmentController module for cocotb
//////////////////////////////////////////////////////////////////////////////////


module SevenSegmentControllerTB (
    input  wire       Reset,
    input  wire       Clk,
    output wire [3:0] AN,
    output wire [1:0] Selector
);
  SevenSegmentController #(
      .ControllerClockCycle(4),
      .ControllerCounterWidth(3)
  ) SevenSegmentControllerInst (
      .Reset   (Reset),
      .Clk     (Clk),
      .AN      (AN),
      .Selector(Selector)
  );
  // cocotb dump waveforms
`ifdef COCOTB_SIM
  initial begin
    $dumpfile("waveform.vcd");  // Name of the dump file
    $dumpvars(0, SevenSegmentControllerTB);  // Dump all variables for the top module
  end
`endif
endmodule
