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
    parameter ControllerClockCycle = 1,
    parameter ControllerCounterWidth = 1
) (
    input wire Reset,
    input wire Clk,
    output wire [3:0] AN,
    output wire [1:0] Selector
);
    reg [ControllerCounterWidth-1:0] Counter = 0;
    // Add your code here
    reg [3:0] ANReg = 4'b1111;
    reg [1:0] SelectorReg = 0;
    
    assign AN = ANReg;
    assign Selector = SelectorReg;
    
    always @(posedge Clk) begin
        SelectorReg = Reset ? 0 : (SelectorReg + (Counter == 0 && ANReg != 4'b1111));
        if (Reset) begin
            ANReg <= 4'b1111;
        end 
        else begin
            case (SelectorReg)
                2'b00: ANReg <= 4'b1110;
                2'b01: ANReg <= 4'b1101;
                2'b10: ANReg <= 4'b1011;
                2'b11: ANReg <= 4'b0111;
                default: ANReg <= 4'b1111;
            endcase
        end
        Counter = (Reset || Counter >= ControllerClockCycle - 1) ? 0 : (Counter + 1);
    end
endmodule