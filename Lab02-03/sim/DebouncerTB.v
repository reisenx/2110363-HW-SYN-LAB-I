`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/09/2025 03:26:02 PM
// Design Name: BCD_Counter
// Module Name: DebouncerTB
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: The Testbench for the Debouncer module
//////////////////////////////////////////////////////////////////////////////////

module DebouncerTB ();
  // reg/wire declaration
  reg  DataIn;
  reg  Reset;
  reg  Clk;
  wire DataOut;

  // instantiate the Multiplexer module
  Debouncer #(
      .CounterWidth(2),
      .DebounceTime(3)
  ) DebouncerInst (
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
    Clk = 0;
    Reset  = 1'b0;
    DataIn = 1'b0;
    #(CLK_PERIOD + 0.1);
    Reset = 1'b1;
    #(CLK_PERIOD);
    Reset  = 1'b0;
    DataIn = 1'b1;
    check_output(0, 0);
    #(CLK_PERIOD);
    check_output(1, 0);
    #(CLK_PERIOD);
    check_output(2, 0);
    #(CLK_PERIOD);
    DataIn = 1'b0;
    for (i = 0; i < 3; i = i + 1) begin
      check_output(i + 3, 1);
      #(CLK_PERIOD);
    end
    DataIn = 1'b1;
    for (i = 0; i < 3; i = i + 1) begin
      check_output(i + 6, 0);
      #(CLK_PERIOD);
    end
    for (i = 0; i < 3; i = i + 1) begin
      check_output(i + 9, 1);
      #(CLK_PERIOD);
    end
    if (flag == 0) begin
      $display("All test cases pass");
    end else begin
      $display("Some test cases fail");
    end
    $finish;
  end
endmodule
