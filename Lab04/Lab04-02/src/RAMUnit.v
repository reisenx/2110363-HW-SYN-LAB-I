`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/16/2025 01:45:27 AM
// Design Name: StackCircuit
// Module Name: RAMUnit
// Project Name: StackCircuit
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Handle storing Data in the RAM
//////////////////////////////////////////////////////////////////////////////////


module RAMUnit (
    input  wire       Clk,
    input  wire       Reset,
    input  wire       WriteEnable,
    input  wire       RamEnable,
    input  wire [7:0] Address,
    input  wire [7:0] DataIn,
    output wire [7:0] DataOut
);
  // Add your code here
  reg [7:0] mem[255:0];
  
  // End of your code
`ifdef COCOTB_SIM
  initial begin
    $dumpfile("waveform.vcd");  // Name of the dump file
    $dumpvars(0, RAMUnit);  // Dump all variables for the top module
  end
`endif
endmodule
