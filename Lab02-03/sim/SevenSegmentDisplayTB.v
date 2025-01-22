`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/09/2025 03:30:27 PM
// Design Name: BCD_Counter
// Module Name: SevenSegmentDisplayTB
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: The Testbench for the SevenSegmentDisplay module
//////////////////////////////////////////////////////////////////////////////////


module SevenSegmentDisplayTB ();
  // reg/wire declaration
  reg  [15:0] DataIn;
  reg         Reset;
  reg         Clk;
  wire [ 3:0] AN;
  wire [ 7:0] Segments;
  reg  [ 3:0] AN_values     [ 3:0];
  reg  [ 7:0] segment_values[15:0];

  // instantiate the Multiplexer module
  SevenSegmentDisplay #(
      .ControllerClockCycle  (100),
      .ControllerCounterWidth(10)
  ) SevenSegmentDisplayInst (
      .DataIn  (DataIn),
      .Clk     (Clk),
      .Reset   (Reset),
      .Segments(Segments),
      .AN      (AN)
  );
  // instantiate variable
  integer flag = 0;
  integer TestCaseNo = 0;
  integer i;
  integer j;

  // task to check the output
  task check_output;
    input integer TestCaseNo;
    input reg [3:0] expected_AN;  // Expected output
    input reg [7:0] expected_Segments;  // Expected output
    begin
      if (AN !== expected_AN || Segments !== expected_Segments) begin
        $error("ERROR: TestCaseNo %0d | Time = %0t | AN = %b (Expected: %b) | Segments = %b (Expected: %b)",
               TestCaseNo, $time, AN, expected_AN, Segments, expected_Segments);
        flag = 1;
      end
    end
  endtask

  localparam CLK_PERIOD = 2;
  always #(CLK_PERIOD / 2.0) Clk = ~Clk;

  // test cases
  initial begin
    AN_values[0] = 4'b1110;
    AN_values[1] = 4'b1101;
    AN_values[2] = 4'b1011;
    AN_values[3] = 4'b0111;
    segment_values[4'b0000] = 8'b00000011;
    segment_values[4'b0001] = 8'b10011111;
    segment_values[4'b0010] = 8'b00100101;
    segment_values[4'b0011] = 8'b00001101;
    segment_values[4'b0100] = 8'b10011001;
    segment_values[4'b0101] = 8'b01001001;
    segment_values[4'b0110] = 8'b01000001;
    segment_values[4'b0111] = 8'b00011111;
    segment_values[4'b1000] = 8'b00000001;
    segment_values[4'b1001] = 8'b00001001;
    segment_values[4'b1010] = 8'b00010001;
    segment_values[4'b1011] = 8'b11000001;
    segment_values[4'b1100] = 8'b01100011;
    segment_values[4'b1101] = 8'b10000101;
    segment_values[4'b1110] = 8'b01100001;
    segment_values[4'b1111] = 8'b01110001;
    Clk = 0;
    Reset = 0;
    DataIn = 0;
    #(CLK_PERIOD + 0.1);
    Reset = 1;
    #(CLK_PERIOD);
    Reset = 0;
    check_output(0, 4'b1111, 8'b00000011);
    #(CLK_PERIOD);
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        if (i == 0) begin
          DataIn = j;
        end else if (i == 1) begin
          DataIn = j * 16;
        end else if (i == 2) begin
          DataIn = j * 16 * 16;
        end else begin
          DataIn = j * 16 * 16 * 16;
        end
        #(CLK_PERIOD);
        check_output(i * 16 + j + 1, AN_values[i], segment_values[j]);
        #(CLK_PERIOD);
      end
      #(CLK_PERIOD * 70);
    end
    if (flag == 0) begin
      $display("All test cases pass");
    end else begin
      $display("Some test cases fail");
    end
    $finish;
  end
endmodule
