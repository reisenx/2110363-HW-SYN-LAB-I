`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/09/2025 03:29:22 PM
// Design Name: BCD_Counter
// Module Name: InputStabilizerTB
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: The Testbench for the InputSanitizer module
//////////////////////////////////////////////////////////////////////////////////


module InputSanitizerTB ();
  // reg/wire declaration
  reg  [3:0] DataIn;
  reg        Clk;
  reg        Reset;
  wire [3:0] DataOut;

  // instantiate the Multiplexer module
  InputSanitizer #(
      .CounterWidth(2),
      .DebounceTime(3)
  ) InputSanitizerInst (
      .DataIn(DataIn),
      .Clk(Clk),
      .Reset(Reset),
      .DataOut(DataOut)
  );
  // instantiate variable
  integer flag = 0;
  integer TestCaseNo = 0;
  integer i;

  // task to check the output
  task check_output;
    input integer TestCaseNo;
    input reg [3:0] expected_DataOut;  // Expected output
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
    Reset = 0;
    DataIn = 0;
    #(CLK_PERIOD + 0.1);
    Reset = 1;
    #(CLK_PERIOD);
    Reset = 0;
    check_output(0, 0);
    for (i = 0; i < 16; i = i + 1) begin
      DataIn = i;
      #(CLK_PERIOD * 4);
      DataIn = 0;
      check_output(i + 1, i);
      #(CLK_PERIOD * 2);
    end
    if (flag == 0) begin
      $display("All test cases pass");
    end else begin
      $display("Some test cases fail");
    end
    $finish;
  end
endmodule
