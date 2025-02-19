`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/16/2025 01:45:08 AM
// Design Name: StackCircuit
// Module Name: InputSanitizer
// Project Name: StackCircuit
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Debounce and Single pulser for the input signals
//////////////////////////////////////////////////////////////////////////////////

// This module is already implemented for you
module InputSanitizer (
    input  wire       Clk,
    input  wire       Reset,
    input  wire [1:0] DataIn,
    output wire [1:0] DataOut
);
  reg [ 1:0] PreviousData = 0;
  reg [19:0] Counter = 0;
  reg [ 1:0] DataOutReg = 0;
  assign DataOut = DataOutReg;

  always @(posedge Clk) begin
    if (Reset) begin
      Counter <= 0;
      PreviousData <= 1'b0;
      DataOutReg <= 1'b0;
    end else begin
      if (Counter == 0) begin
        if (DataIn[0] == 1'b1 && PreviousData[0] == 1'b0) begin
          DataOutReg[0] <= 1'b1;
        end
        if (DataIn[1] == 1'b1 && PreviousData[1] == 1'b0) begin
          DataOutReg[1] <= 1'b1;
        end
        PreviousData <= DataIn;
      end else begin
        DataOutReg <= 0;
      end
      Counter <= Counter + 1;
    end
  end
endmodule
