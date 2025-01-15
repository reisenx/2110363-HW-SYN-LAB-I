`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 12/23/2024 04:14:16 AM
// Design Name: Exercise1
// Module Name: Multiplexer
// Project Name: Exercise1
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Multiplexer module to select between two hexadecimals input for 7-segment display
//////////////////////////////////////////////////////////////////////////////////


module Multiplexer (
    input  wire [3:0] In0,
    input  wire [3:0] In1,
    input  wire       Selector,
    output wire [3:0] DataOut
);

// Add code here //
assign DataOut = (Selector) ? In1 : In0;
// End of code //

// cocotb dump waveforms
`ifdef COCOTB_SIM
initial begin
    $dumpfile("waveform.vcd");  // Name of the dump file
    $dumpvars(0, Multiplexer);  // Dump all variables for the top module
end
`endif
endmodule
