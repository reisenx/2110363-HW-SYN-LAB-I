`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 12/23/2024 05:07:14 AM
// Design Name: Exercise1
// Module Name: SevenSegmentDecoderTB
// Project Name: Exercise1
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Testbench for the SevenSegmentDecoder module
//////////////////////////////////////////////////////////////////////////////////

module SevenSegmentDecoderTB ();
  // Declare the reg/wire
  reg  [3:0] DataIn;                    // Input to the SevenSegmentDecoder
  wire [7:0] Segments;                  // Output from the SevenSegmentDecoder
  reg  [7:0] segment_values[15:0];      // Expected segment patterns for each DataIn value

  // Instantiate the SevenSegmentDecoder module
  SevenSegmentDecoder SevenSegmentDecoderInst (
      .DataIn  (DataIn),
      .Segments(Segments)
  );

  // Instantiate variable
  integer flag = 0;                     // Flag to track if any test case fails
  integer TestCaseNo = 0;               // Counter for test cases
  integer i;                            // Loop variable

  // Task to check the output
  task check_output;
    input integer TestCaseNo;
    input reg [7:0] expected_Segments;  // Expected output
    begin
      if (Segments !== expected_Segments) begin
        $error("ERROR: TestCaseNo %0d | Time = %0t | DataIn = %b | Segments = %b (Expected: %b)",
              TestCaseNo, $time, DataIn, Segments, expected_Segments);
        flag = 1;
      end
    end
  endtask

  // Test cases
  initial begin
    // Initialize the expected segment values
    segment_values[4'b0000] = 8'b00000011; // '0'
    segment_values[4'b0001] = 8'b10011111; // '1'
    segment_values[4'b0010] = 8'b00100101; // '2'
    segment_values[4'b0011] = 8'b00001101; // '3'
    segment_values[4'b0100] = 8'b10011001; // '4'
    segment_values[4'b0101] = 8'b01001001; // '5'
    segment_values[4'b0110] = 8'b01000001; // '6'
    segment_values[4'b0111] = 8'b00011111; // '7'
    segment_values[4'b1000] = 8'b00000001; // '8'
    segment_values[4'b1001] = 8'b00001001; // '9'
    segment_values[4'b1010] = 8'b00010001; // 'A'
    segment_values[4'b1011] = 8'b11000001; // 'b'
    segment_values[4'b1100] = 8'b01100011; // 'C'
    segment_values[4'b1101] = 8'b10000101; // 'd'
    segment_values[4'b1110] = 8'b01100001; // 'E'
    segment_values[4'b1111] = 8'b01110001; // 'F'

    // Apply test cases for all DataIn values (0–15)
    for (i = 0; i < 16; i = i + 1) begin
      DataIn = i[3:0];                   // Set the input
      #10;                              // Wait for 10 time units
      check_output(TestCaseNo, segment_values[i]); // Check output
      TestCaseNo = TestCaseNo + 1;      // Increment test case number
    end

    // Final test results
    if (flag == 0) begin
      $display("All test cases pass");
    end else begin
      $display("Some test cases fail");
    end
    $finish;
  end
endmodule