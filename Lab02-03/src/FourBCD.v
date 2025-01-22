`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/01/2025 02:15:10 AM
// Design Name: BCD_Counter
// Module Name: FourBCD
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: The Four Digit BCD Counter Module
//////////////////////////////////////////////////////////////////////////////////


module FourBCD (
    input  wire [ 3:0] Trigger,
    input  wire        Clk,
    input  wire        Reset,
    output wire [15:0] DataOut
);
    // Add your code here
    wire [4:0] carry;
    assign carry[0] = 0;
    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin
            SingleBCD SingleBCDInst (
                .Trigger(Trigger[i]),
                .Clk    (Clk),
                .Reset  (Reset),
                .Cin    (carry[i]),
                .DataOut(DataOut[i*4+3:i*4]),
                .Cout   (carry[i+1])
            );
        end
    endgenerate
    // End of your code
endmodule