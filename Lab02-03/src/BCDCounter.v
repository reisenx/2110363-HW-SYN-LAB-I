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
    parameter CounterWidth = 17,
    parameter DebounceTime = 100000,
    parameter ControllerClockCycle = 250000,
    parameter ControllerCounterWidth = 19
) (
    input wire Clk,
    input wire Reset,
    input wire [3:0] Trigger,
    output wire [7:0] Segments,
    output wire [3:0] AN
);
    wire [3:0] tmp1;
    wire [15:0] tmp2;
    InputSanitizer #(
        .CounterWidth(CounterWidth),
        .DebounceTime(DebounceTime)
    ) sanitizer (
        .DataIn(Trigger),
        .Clk(Clk),
        .Reset(Reset),
        .DataOut(tmp1)
    );
    FourBCD counter (
        .Reset(Reset),
        .Clk(Clk),
        .Trigger(tmp1),
        .DataOut(tmp2)
    );
    SevenSegmentDisplay #(
        .ControllerClockCycle(ControllerClockCycle),
        .ControllerCounterWidth(ControllerCounterWidth)
    ) display (
        .DataIn(tmp2),
        .Clk(Clk),
        .Reset(Reset),
        .Segments(Segments),
        .AN(AN)
    );
endmodule