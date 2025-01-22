`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/09/2025 03:31:54 PM
// Design Name: BCD_Counter
// Module Name: SevenSegmentControllerTB
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: The Testbench for the SevenSegmentController module
//////////////////////////////////////////////////////////////////////////////////


module SevenSegmentControllerTB ();
  // reg/wire declaration
  reg        Reset;
  reg        Clk;
  wire [3:0] AN;
  wire [1:0] Selector;

  // instantiate the Multiplexer module
  SevenSegmentController #(
      .ControllerClockCycle  (4),
      .ControllerCounterWidth(3)
  ) SevenSegmentControllerInst (
      .Reset   (Reset),
      .Clk     (Clk),
      .AN      (AN),
      .Selector(Selector)
  );
  // instantiate variable
  integer flag = 0;
  integer TestCaseNo = 0;
  integer i;

  // task to check the output
  task check_output;
    input integer TestCaseNo;
    input reg [3:0] expected_AN;  // Expected output
    input reg [1:0] expected_Selector;  // Expected output
    begin
      if (AN !== expected_AN || Selector !== expected_Selector) begin
        $error("ERROR: TestCaseNo %0d | Time = %0t | AN = %b (Expected: %b) | Selector = %b (Expected: %b)",
               TestCaseNo, $time, AN, expected_AN, Selector, expected_Selector);
        flag = 1;
      end
    end
  endtask

  localparam CLK_PERIOD = 2;
  always #(CLK_PERIOD / 2.0) Clk = ~Clk;

  // test cases
  initial begin
    // Reset here
    Reset = 0;
    Clk = 0;
    #(CLK_PERIOD + 0.1);
    Reset = 1;
    check_output(0, 15, 0);
    // Insert test cases here
    if (flag == 0) begin
      $display("All test cases pass");
    end else begin
      $display("Some test cases fail");
    end
    $finish;
  end
endmodule
