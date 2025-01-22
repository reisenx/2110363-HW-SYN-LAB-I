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
    localparam Start = 2'b00;
    localparam Two = 2'b01;
    localparam Three = 2'b10;
    reg [1:0] State = 2'b00;
    assign DataOut = (State == Two);
    always @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            end 
        else begin
            case (State)
                Start: begin
                    if (DataIn == 1) begin
                    State <= Two; // Change state to One
                    end
                end
                Two: begin
                    State <= Three; // Change state to Two
                end
                Three: begin
                    if(DataIn == 0) begin
                        State <= Start; // Change state to Start
                    end
                end
            endcase
        end
    end
// End of your code
endmodule
