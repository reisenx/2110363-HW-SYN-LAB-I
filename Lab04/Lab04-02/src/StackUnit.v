`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/16/2025 01:45:55 AM
// Design Name: StackCircuit
// Module Name: StackUnit
// Project Name: StackCircuit
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: The Module that implement the Stack
//////////////////////////////////////////////////////////////////////////////////


module StackUnit (
    input wire Clk,
    input wire Reset,
    input wire [7:0] DataIn,
    input wire Push,
    input wire Pop,
    output wire [7:0] StackValue,
    output wire [7:0] StackCounter
);
  // Add your code here
  wire RAMWriteEnableOutput , RAMEnableOutput ;
  wire [7:0] RAMAddressOutput ;
  wire [7:0] RAMDataInOutput ;
  wire [7:0] DataOutOutput ;


  StackController StackControllerInst (
    .Push (Push) ,
    .Pop  (Pop) ,
    .Clk  (Clk) ,
    .Reset (Reset) ,
    .DataIn (DataIn) ,
    .RAMDataOut (DataOutOutput) ,
    .StackCounter (StackCounter) ,
    .StackValue (StackValue) ,
    .RAMWriteEnable (RAMWriteEnableOutput) ,
    .RAMEnable (RAMEnableOutput) ,
    .RAMAddress (RAMAddressOutput) ,
    .RAMDataIn (RAMDataInOutput)
  );


  RAMUnit RAMUnitInst (
    .Clk (Clk) ,        
    .Reset (Reset) ,      
    .WriteEnable (RAMWriteEnableOutput) ,
    .RamEnable (RAMEnableOutput) ,  
    .Address (RAMAddressOutput) ,    
    .DataIn (RAMDataInOutput),    
    .DataOut (DataOutOutput)  
  );


  // End of your code
endmodule
