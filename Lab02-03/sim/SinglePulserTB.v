`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/09/2025 03:28:24 PM
// Design Name: BCD_Counter
// Module Name: SinglePulserTB
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: The Testbench for the SinglePulser module
//////////////////////////////////////////////////////////////////////////////////


module SinglePulserTB ();
  // reg/wire declaration
  reg  DataIn;
  reg  Reset;
  reg  Clk;
  wire DataOut;

  // instantiate the Multiplexer module
  SinglePulser SinglePulserInst (
      .DataIn(DataIn),
      .Clk(Clk),
      .Reset(Reset),
      .DataOut(DataOut)
  );
  // instantiate variable
  integer flag = 0;
  integer TestCaseNo = 0;
  integer i;
  integer j;

  // task to check the output
  task check_output;
    input integer TestCaseNo;
    input reg expected_DataOut;  // Expected output
    begin
      if (DataOut !== expected_DataOut) begin
        $error("ERROR: TestCaseNo %0d | Time = %0t | DataOut = %b (Expected: %b)", TestCaseNo, $time, DataOut,
              expected_DataOut);
        flag = 1;
      end
    end
  endtask

  localparam CLK_PERIOD = 2;
  always #(CLK_PERIOD / 2.0) Clk = ~Clk;

  // test cases
  initial begin
    DataIn = 0;
    Reset = 0;
    Clk = 0;

    // Insert test cases here
    #(CLK_PERIOD + 0.1);
    Reset = 1;
    #(CLK_PERIOD + 0.1);
    Reset = 0;
    check_output(0, 0); // Initial must be 0

    DataIn = 1;
    check_output(1, 0); // Wait 1 clock
    #(CLK_PERIOD + 0.1);
    check_output(2, 1); // Change value for 1 clk
    #(CLK_PERIOD + 0.1);
    check_output(3, 0); // Not changing
    #(CLK_PERIOD + 0.1);
    check_output(4, 0); // Not changing
    #(CLK_PERIOD + 0.1);
    Reset = 1;
    DataIn = 0;
    #(CLK_PERIOD + 0.1);
    DataIn = 1;
    check_output(5, 0); // Wait 1 clk
    #(CLK_PERIOD + 0.1);
    check_output(5, 0); // Not changing (reset = 1)

    if (flag == 0) begin
      $display("All test cases pass");
    end else begin
      $display("Some test cases fail");
    end
    $finish;
  end
endmodule
