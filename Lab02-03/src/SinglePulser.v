`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/01/2025 02:12:30 AM
// Design Name: BCD_Counter
// Module Name: SinglePulser
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Single Pulser Module
//////////////////////////////////////////////////////////////////////////////////


module SinglePulser (
    input  wire DataIn,
    input  wire Clk,
    input  wire Reset,
    output wire DataOut
);
    // Add your code here
    reg out;
    reg state;
    assign DataOut = out;
    always @(posedge Clk) begin
        if (Reset) begin
            state <= 0;
            out   <= 0;
        end
        if (state == 0) begin
            if (DataIn) begin
                state <= 1;
                out   <= 1;
            end
        end else begin
            if (DataIn) begin
                out <= 0;
            end else begin
                state <= 0;
                out   <= 0;
            end
        end
    end
    // End of your code
endmodule
