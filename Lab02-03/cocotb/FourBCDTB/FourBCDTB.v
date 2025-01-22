`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/01/2025 02:12:30 AM
// Design Name: BCD_Counter
// Module Name: FourBCDTB
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Instantiate FourBCDTB module for cocotb
//////////////////////////////////////////////////////////////////////////////////


module FourBCDTB (
    input  wire [ 3:0] Trigger,
    input  wire        Clk,
    input  wire        Reset,
    output wire [15:0] DataOut
);
  FourBCD FourBCDInst (
      .Trigger(Trigger),
      .Clk(Clk),
      .Reset(Reset),
      .DataOut(DataOut)
  );

  // cocotb dump waveforms
`ifdef COCOTB_SIM
  initial begin
    $dumpfile("waveform.vcd");  // Name of the dump file
    $dumpvars(0, FourBCDTB);  // Dump all variables for the top module
  end
`endif
endmodule
