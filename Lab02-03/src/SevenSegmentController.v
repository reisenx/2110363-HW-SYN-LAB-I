`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: BCD_Counter
// Module Name: SevenSegmentController
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Controller module for 7-Segment Display
//////////////////////////////////////////////////////////////////////////////////


module SevenSegmentController #(
    parameter ControllerClockCycle   = 1,
    parameter ControllerCounterWidth = 1
) (
    input  wire       Reset,
    input  wire       Clk,
    output wire [3:0] AN,
    output wire [1:0] Selector
);
    reg [ControllerCounterWidth-1:0] Counter = 0;
    // Add your code here
    reg [                       1:0] rSelector;
    reg [                       3:0] rAN;
    assign Selector = rSelector;
    assign AN       = rAN;

    always @(posedge Clk) begin
        if (Reset) begin
            rAN       = 'b1111;
            rSelector = 0;
            Counter   = 0;
        end else begin
            if (rAN == 'b1111) begin
                rAN = 'b1110;
            end
            Counter = Counter + 1;
            if (Counter == ControllerClockCycle - 1) begin
                rSelector = rSelector + 1;
                case (rAN)
                    // 'b1111: rAN <= 'b1110;
                    'b1110: rAN = 'b1101;
                    'b1101: rAN = 'b1011;
                    'b1011: rAN = 'b0111;
                    'b0111: rAN = 'b1110;
                endcase
                Counter = 0;
            end
        end
    end
    // End of your code
endmodule
