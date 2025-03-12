`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/26/2025 11:54:27 PM
// Design Name: UARTLedSystem
// Module Name: UARTTx
// Project Name: UARTLedSystem
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Tx module for UART communication. Reads data from the FIFO then sends it to Host PC via UART interface.
//////////////////////////////////////////////////////////////////////////////////

module UARTTx (
	input  wire   	Clk,    	// Clock signal
	input  wire   	Reset,  	// Reset signal
	output wire   	Tx,     	// UART transmit bit
	input  wire [7:0] DataIn, 	// Data from FIFO
	input  wire   	Empty,  	// FIFO empty signal
	output wire   	ReadEnable, // Signal to read from FIFO
	input  wire   	DataValid   // Data is valid in FIFO
);

  localparam WAIT_CYCLE = 868;
  
  localparam IDLE = 0;
  localparam START_BIT = 1;
  localparam DATA = 2;
  localparam STOP_BIT = 3;
  
  reg [1:0] txState;
  reg [9:0] clkCounter;
  reg [7:0] txShiftReg;
  reg [3:0] bitPosition;
  
  reg readEnableFlag = 0;
  assign ReadEnable = readEnableFlag;
  
  reg txReg = 1;
  assign Tx = txReg;
  
  always @(posedge Clk) begin
    if (Reset) begin
        txState <= IDLE;
        txReg <= 1;
        clkCounter <= 0;
        bitPosition <= 0;
        readEnableFlag <= 0;
    end else begin
        case (txState)
            IDLE: begin
                if (!Empty && !readEnableFlag) begin
                    readEnableFlag <= 1;
                end else begin
                    readEnableFlag <= 0;
                end
                if (DataValid) begin	 
                    txShiftReg <= DataIn;
                    txState <= START_BIT;
                    clkCounter <= 0;
                    txReg <= 0;
                end
            end
            START_BIT: begin
                if (clkCounter == WAIT_CYCLE) begin
                    bitPosition <= 0;
                    txState <= DATA;
                end else begin
                    clkCounter <= clkCounter + 1;
                end
            end
            DATA: begin
                if (clkCounter == WAIT_CYCLE) begin
                    clkCounter <= 0;
                    if (bitPosition == 8) begin
                        txState <= STOP_BIT;
                        txReg <= 1;
                    end else begin
                        txReg <= txShiftReg[bitPosition];
                        bitPosition <= bitPosition + 1;
                    end
                end else begin
                    clkCounter <= clkCounter + 1;
                end
            end
            STOP_BIT: begin
                clkCounter <= clkCounter + 1;
                if (clkCounter == WAIT_CYCLE) begin
                    clkCounter <= 0;
                    txState <= IDLE;
                end
            end
        endcase
    end
  end

endmodule
