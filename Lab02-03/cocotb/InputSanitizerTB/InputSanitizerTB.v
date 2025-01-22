`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/08/2025 02:11:40 AM
// Design Name: BCD_Counter
// Module Name: InputSanitizerTB
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Instantiate InputSanitizer module for cocotb
//////////////////////////////////////////////////////////////////////////////////


module InputSanitizerTB (
    input  wire [3:0] DataIn,
    input  wire       Clk,
    input  wire       Reset,
    output wire [3:0] DataOut
);
  InputSanitizer #(
      .CounterWidth(2),
      .DebounceTime(3)
  ) InputSanitizerInst (
      .DataIn(DataIn),
      .Clk(Clk),
      .Reset(Reset),
      .DataOut(DataOut)
  );
  // cocotb dump waveforms
`ifdef COCOTB_SIM
  initial begin
    $dumpfile("waveform.vcd");  // Name of the dump file
    $dumpvars(0, InputSanitizerTB);  // Dump all variables for the top module
  end
`endif
endmodule
