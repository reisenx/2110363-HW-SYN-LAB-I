`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/16/2025 01:45:42 AM
// Design Name: StackCircuit
// Module Name: StackController
// Project Name: StackCircuit
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: This module is used to implement the stack using a RAMUnit.
//////////////////////////////////////////////////////////////////////////////////


module StackController (
    input  wire       Push,          // Push signal (adds element to stack)
    input  wire       Pop,           // Pop signal (removes element from stack)
    input  wire       Clk,           // Clock signal
    input  wire       Reset,         // Reset signal (clears stack)
    input  wire [7:0] DataIn,        // Data input for push operation
    input  wire [7:0] RAMDataOut,    // Data read from RAM
    output reg  [7:0] StackCounter,  // Number of elements in the stack
    output reg  [7:0] StackValue,    // Last popped value
    output reg        RAMWriteEnable,// Controls RAM write operation
    output reg        RAMEnable,     // Enables RAM operation
    output reg  [7:0] RAMAddress,    // Address for RAM read/write
    output reg  [7:0] RAMDataIn      // Data to write into RAM
);


    // Synchronous process for stack operations
    always @(posedge Clk) begin
        if (Reset) begin
            // Reset everything
            StackCounter   <= 8'b0;  // Reset stack count
            StackValue     <= 8'b0;  // Reset last popped value
            RAMWriteEnable <= 1'b0;  // Disable writing
            RAMEnable      <= 1'b1;  // Keep RAM enabled
        end
        else if (Push && StackCounter == 255) begin
            StackCounter <= StackCounter;
            RAMAddress   <= StackCounter;
            RAMDataIn    <= DataIn;
            RAMWriteEnable <= 1'b1;
        end
        else if (Push && StackCounter < 255) begin
            StackCounter <= StackCounter + 1'b1;
            RAMAddress   <= StackCounter;
            RAMDataIn    <= DataIn;
            RAMWriteEnable <= 1'b1;
        end
        else if (Pop && RAMAddress == 255 && StackCounter == 255) begin
            // Pop operation: Retrieve last pushed value from RAM
            RAMAddress     <= RAMAddress - 1 ;
            StackValue     <= RAMDataOut;      
            StackCounter   <= StackCounter;
            RAMWriteEnable <= 1'b0;            
            RAMEnable      <= 1'b1;            
        end
        else if (Pop && StackCounter == 1) begin
            // Pop operation: Retrieve last pushed value from RAM
            RAMAddress     <= 0 ;
            StackValue     <= RAMDataOut;      
            StackCounter   <= StackCounter - 1;
            RAMWriteEnable <= 1'b0;            
            RAMEnable      <= 1'b1;            
        end
        else if (Pop && StackCounter > 1) begin
            // Pop operation: Retrieve last pushed value from RAM
            RAMAddress     <= StackCounter - 2;
            StackValue     <= RAMDataOut;      
            StackCounter   <= StackCounter - 1;
            RAMWriteEnable <= 1'b0;            
            RAMEnable      <= 1'b1;            
        end
        else begin
            // Default state: No operations, disable RAM write
            RAMWriteEnable <= 1'b0;
            RAMEnable      <= 1'b1;
        end
    end


    // For waveform dumping in COCOTB simulation
    `ifdef COCOTB_SIM
    initial begin
        $dumpfile("waveform.vcd");         // Name of the dump file
        $dumpvars(0, StackController);     // Dump all variables in this module
    end
    `endif


endmodule
