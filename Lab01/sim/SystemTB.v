`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 12/23/2024 05:07:36 AM
// Design Name: Exercise1
// Module Name: SystemTB
// Project Name: Exercise1
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Testbench for the System module
//////////////////////////////////////////////////////////////////////////////////


module SystemTB ();
  // declare the reg/wire
  reg  [7:0] SW;
  reg        Reset;
  reg        Clk;
  wire [7:0] Segments;
  wire [3:0] AN;
  reg  [7:0] segment_values[15:0];

  // instantiate the SevenSegmentDecoder module
  System SystemInst (
      .SW(SW),
      .Reset(Reset),
      .Clk(Clk),
      .Segments(Segments),
      .AN(AN)
  );

  // instantiate variable
  integer flag = 0;
  integer TestCaseNo = 0;
  integer sw;

  // task to check the output
  task check_output;
    input integer TestCaseNo;
    input reg [7:0] expected_Segments;  // Expected output
    input reg [3:0] expected_AN;  // Expected output
    begin
      if (Segments !== expected_Segments | AN !== expected_AN) begin
        $error(
            "ERROR: TestCaseNo %0d | Time = %0t | SW = %b, Reset = %b | Segments = %b (Expected: %b) | AN = %b (Expected: %b)",
            TestCaseNo, $time, SW, Reset, Segments, expected_Segments, AN, expected_AN);
        flag = 1;
      end
    end
  endtask

  localparam CLK_PERIOD = 2;
  always #(CLK_PERIOD / 2.0) Clk = ~Clk;

  // test cases
  initial begin
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
    Reset = 1;
    SW = 8'b0;
    #(CLK_PERIOD) Reset = 0;
    for (sw = 0; sw < 16; sw = sw + 1) begin
      SW = {4'b0, sw};
      #CLK_PERIOD;
      check_output(TestCaseNo, segment_values[sw], 4'b1110);
      TestCaseNo = TestCaseNo + 1;
    end
    #(CLK_PERIOD*150000);
    for (sw = 0; sw < 16; sw = sw + 1) begin
      SW = {sw, 4'b0};
      #CLK_PERIOD;
      check_output(TestCaseNo, segment_values[sw], 4'b1101);
      TestCaseNo = TestCaseNo + 1;
    end
    if (flag == 0) begin
      $display("All test cases pass");
    end else begin
      $display("Some test cases fail");
    end
    $finish;
  end
endmodule
