`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/08/2025 02:11:40 AM
// Design Name: BCDC_Counter
// Module Name: DebouncerTB
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Instantiate Debouncer module for cocotb
//////////////////////////////////////////////////////////////////////////////////


module DebouncerTB (
    input  wire DataIn,
    input  wire Clk,
    input  wire Reset,
    output wire DataOut
);
  Debouncer #(
    .CounterWidth(2),
    .DebounceTime(3)
  ) DebouncerInst (
      .DataIn(DataIn),
      .Clk(Clk),
      .Reset(Reset),
      .DataOut(DataOut)
  );
  // cocotb dump waveforms
`ifdef COCOTB_SIM
  initial begin
    $dumpfile("waveform.vcd");  // Name of the dump file
    $dumpvars(0, DebouncerTB);  // Dump all variables for the top module
  end
`endif
endmodule
