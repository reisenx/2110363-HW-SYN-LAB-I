`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/01/2025 02:12:30 AM
// Design Name: BCD_Counter
// Module Name: SingleBCDTB
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Instantiate SingleBCD module for cocotb
//////////////////////////////////////////////////////////////////////////////////


module SingleBCDTB (
    input  wire       Trigger,
    input  wire       Clk,
    input  wire       Reset,
    input  wire       Cin,
    output wire [3:0] DataOut,
    output wire       Cout
);
  SingleBCD SingleBCDInst (
      .Trigger(Trigger),
      .Clk(Clk),
      .Reset(Reset),
      .Cin(Cin),
      .DataOut(DataOut),
      .Cout(Cout)
  );

  // cocotb dump waveforms
`ifdef COCOTB_SIM
  initial begin
    $dumpfile("waveform.vcd");  // Name of the dump file
    $dumpvars(0, SingleBCDTB);  // Dump all variables for the top module
  end
`endif
endmodule
