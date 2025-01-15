`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 12/23/2024 04:13:56 AM
// Design Name: Exercise1
// Module Name: Controller
// Project Name: Exercise1
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Controller module to control the 7-segment display
//////////////////////////////////////////////////////////////////////////////////

// This module is already implemented. You can use this module as is. //
module Controller (
    input  wire       Reset,
    input  wire       Clk,
    output wire [3:0] AN,
    output wire       Selector
);
  reg [ 3:0] an = 4'b1111;
  reg        selector = 1'b0;
  reg [17:0] counter = 0;
  assign AN = an;
  assign Selector = selector;
  always @(posedge Clk) begin
    if (Reset) begin
      an <= 4'b1111;
      selector <= 1'b0;
      counter <= 18'b0;
    end else begin
      counter <= counter + 1;
      if(counter[17] == 0) begin
        an <= 4'b1110;
        selector <= 1'b0;
      end else begin
        an <= 4'b1101;
        selector <= 1'b1;
      end
    end
  end
endmodule
