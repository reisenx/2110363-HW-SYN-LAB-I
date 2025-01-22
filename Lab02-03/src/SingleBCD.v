`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/01/2025 02:14:43 AM
// Design Name: BCD_Counter
// Module Name: SingleBCD
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: A single BCD counter module for 1 digit in a 4 digit BCD counter
//////////////////////////////////////////////////////////////////////////////////

module SingleBCD (
    input wire Trigger, // Trigger signal to increment counter
    input wire Clk, // Clock signal
    input wire Reset, // Reset signal
    input wire Cin, // Carry in from previous counter
    output wire [3:0] DataOut, // 4-bit BCD value
    output wire Cout // Carry out to next counter
);

    // Internal signal to calculate next value
    reg [3:0] Counter = 4'b0000;
    assign DataOut = Counter;
    assign Cout = (Counter + Trigger + Cin) >= 10;
    always @(posedge Clk) begin
        if (Reset) begin
            // Reset the counter to 0
            Counter <= 4'b0000;
        end 
        else if (Cin | Trigger) begin
            Counter <= (Counter + Cin + Trigger) % 10;
        end
    end

endmodule
