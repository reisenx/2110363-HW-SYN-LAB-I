`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/16/2025 01:44:47 AM
// Design Name: StackCircuit
// Module Name: StackCircuit
// Project Name: StackCircuit
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: The Top level module for the Stack Circuit
//////////////////////////////////////////////////////////////////////////////////




module StackCircuit (
    input  wire       Clk,
    input  wire       Reset,
    input  wire       Push,
    input  wire       Pop,
    input  wire [7:0] DataIn,
    output wire [7:0] Segments,
    output wire [3:0] AN
);
  // Add your code here


  wire [1:0] InputSanitizerDataoutOutput ;
  wire [7:0] StackValueOutput ;
  wire [7:0] StackCounterOutput ;


  InputSanitizer InputSanitizerInst (
    .Reset (Reset) ,
    .Clk (Clk) ,
    .DataIn ({Push , Pop}) ,
    .DataOut (InputSanitizerDataoutOutput)
  ) ;
 
  StackUnit StackUnitInst (
    .Reset (Reset) ,
    .Clk (Clk) ,
    .Push (InputSanitizerDataoutOutput[1]) ,
    .Pop (InputSanitizerDataoutOutput[0]) ,
    .DataIn (DataIn) ,
    .StackValue (StackValueOutput) ,
    .StackCounter (StackCounterOutput)
  );


  SevenSegmentDisplay SevenSegmentDisplayInst (
    .Reset (Reset) ,
    .Clk (Clk) ,
    .DataIn ({StackValueOutput , StackCounterOutput}) ,
    .Segments (Segments) ,
    .AN (AN)
  );
  // End of your code
endmodule
