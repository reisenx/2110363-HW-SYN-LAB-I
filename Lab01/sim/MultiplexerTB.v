`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 12/23/2024 05:06:53 AM
// Design Name: Exercise1
// Module Name: MultiplexerTB
// Project Name: Exercise1
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Testbench for the Multiplexer module
//////////////////////////////////////////////////////////////////////////////////


module MultiplexerTB ();
  // reg/wire declaration
  reg  [3:0] In0;
  reg  [3:0] In1;
  reg        Selector;
  wire [3:0] DataOut;

  // instantiate the Multiplexer module
  Multiplexer MultiplexerInst (
      .In0(In0),
      .In1(In1),
      .Selector(Selector),
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
    input reg [3:0] expected_DataOut;  // Expected output
    begin
      if (DataOut !== expected_DataOut) begin
        $error(
            "ERROR: TestCaseNo %0d | Time = %0t | In0 = %b, In1 = %b, Selector = %b | DataOut = %b (Expected: %b)",
            TestCaseNo, $time, In0, In1, Selector, DataOut, expected_DataOut);
        flag = 1;
      end
    end
  endtask

  // test cases
  initial begin
    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        In0 = i;
        In1 = j;
        Selector = 0;
        #1;
        check_output(TestCaseNo, i);
        TestCaseNo = TestCaseNo + 1;
        Selector   = 1;
        #1;
        check_output(TestCaseNo, j);
        TestCaseNo = TestCaseNo + 1;
      end
    end
    if (flag == 0) begin
      $display("All test cases pass");
    end else begin
      $display("Some test cases fail");
    end
    $finish;
  end

endmodule
