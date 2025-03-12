 `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/26/2025 11:54:43 PM
// Design Name: UARTLedSystem
// Module Name: UARTRx
// Project Name: UARTLedSystem
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Rx module for UART communication. Read data from Host PC via UART interface then write it to the FIFO.
//////////////////////////////////////////////////////////////////////////////////

module UARTRx (
	input  wire   	Clk,
	input  wire   	Reset,
	input  wire   	Rx,        	// UART receive line
	output wire [7:0] DataOut,   	// Data to FIFO
	output wire   	WriteEnable,   // Write signal for FIFO
	input  wire   	Full       	// FIFO full signal
);

  localparam WAIT_CYCLE = 868;

  localparam IDLE = 0;
  localparam CAPTURE = 1;
  reg rxState = IDLE;

  reg [9:0] clkCounter = 0;
  reg [9:0] rxShiftReg = 0;
  reg [3:0] bitPosition = 0;

  reg writeEnableFlag = 0;
  assign WriteEnable = writeEnableFlag;

  assign DataOut = rxShiftReg[8:1];

  always @(posedge Clk) begin
  if (Reset) begin
      rxState <= IDLE;
      clkCounter <= 0;
      rxShiftReg <= 0;
      writeEnableFlag <= 0;
      bitPosition <= 0;
  end else begin
      case (rxState)
          IDLE: begin
              writeEnableFlag <= 0;
              if (Rx == 0) begin  // Detect start bit
                  bitPosition <= 0;
                  clkCounter <= 0;
                  rxState <= CAPTURE;
              end
          end
          CAPTURE: begin
              if (clkCounter == WAIT_CYCLE) begin
                  clkCounter <= 0;
                  if (bitPosition == 10) begin
                      if (rxShiftReg[0] == 0 && rxShiftReg[9] == 1 && !Full) begin
                          writeEnableFlag <= 1;
                      end
                      rxState <= IDLE;
                  end else begin
                      bitPosition <= bitPosition + 1;
                  end
              end else begin
                  clkCounter <= clkCounter + 1;
                  if (clkCounter == WAIT_CYCLE / 2) begin
                      rxShiftReg[bitPosition] <= Rx;
                  end
              end
          end
      endcase
  end
  end

endmodule
