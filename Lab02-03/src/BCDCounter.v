`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/01/2025 02:10:33 AM
// Design Name: BCD_Counter
// Module Name: BCDCounter
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Top module for BCD Counter
//////////////////////////////////////////////////////////////////////////////////


module BCDCounter #(
    // Modify the parameter to match the requirements
    parameter CounterWidth           = 1,
    parameter DebounceTime           = 1,
    parameter ControllerClockCycle   = 1,
    parameter ControllerCounterWidth = 1
) (
    input  wire        Clk,
    input  wire        Reset,
    input  wire [ 3:0] Trigger,
    output wire [ 7:0] Segments,
    output wire [ 3:0] AN,
    output wire [15:0] led
);

    // Add your code here
    wire [ 3:0] SanitizedTrigger;
    wire [15:0] data;

    assign led = data;

    InputSanitizer InputSanitizerInst (
        .DataIn (Trigger),
        .Clk    (Clk),
        .Reset  (Reset),
        .DataOut(SanitizedTrigger)
    );

    FourBCD FourBCDInst (
        .Trigger(SanitizedTrigger),
        .Clk(Clk),
        .Reset(Reset),
        .DataOut(data)
    );

    SevenSegmentDisplay #(
        .ControllerClockCycle  (100000),
        .ControllerCounterWidth(17)
    ) SevenSegmentDisplayInst (
        .DataIn  (data),
        .Clk     (Clk),
        .Reset   (Reset),
        .Segments(Segments),
        .AN      (AN)
    );

    // End of your code
endmodule