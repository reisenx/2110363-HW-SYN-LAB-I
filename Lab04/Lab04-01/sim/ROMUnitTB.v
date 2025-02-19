`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/23/2025 11:16:37 PM
// Design Name: BinaryToDecimal
// Module Name: ROMUnitTB
// Project Name: BinaryToDecimal
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: The Test Bench for the ROMUnit Module
//////////////////////////////////////////////////////////////////////////////////


module ROMUnitTB ();
  // reg/wire declaration
  reg [5:0] Address;
  reg Clk;
  reg Reset;
  wire [15:0] DataOut;

  // instantiate the Multiplexer module
  ROMUnit ROMUnitInst (
      .Address(Address),
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
    input reg [15:0] expected_DataOut;  // Expected output
    begin
      if (DataOut !== expected_DataOut) begin
        $error("ERROR: TestCaseNo %0d | Time = %0t | DataOut = %b (Expected: %b)", TestCaseNo,
               $time, DataOut, expected_DataOut);
        flag = 1;
      end
    end
  endtask

  localparam CLK_PERIOD = 2;
  always #(CLK_PERIOD / 2.0) Clk = ~Clk;

  // test cases
  initial begin
    Address = 0;
    Clk = 0;
    Reset = 0;
    #(CLK_PERIOD + 0.1);
    Reset = 1;
    #(CLK_PERIOD);
    Reset = 0;
    check_output(0, 0);
    for (i=0; i<64; i=i+1) begin
      Address = i;
      #(CLK_PERIOD);
      check_output(i, (i%10) + (i/10*16));
    end
    if (flag == 0) begin
      $display("All test cases pass");
    end else begin
      $display("Some test cases fail");
    end
    $finish;
  end
endmodule
