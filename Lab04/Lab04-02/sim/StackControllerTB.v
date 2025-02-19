`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/24/2025 02:15:04 AM
// Design Name: StackCircuit
// Module Name: StackControllerTB
// Project Name: StackCircuit
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: The Testbench for the StackController module
//////////////////////////////////////////////////////////////////////////////////


module StackControllerTB ();
  // reg/wire declaration
  reg        Push;
  reg        Pop;
  reg        Clk;
  reg        Reset;
  reg  [7:0] DataIn;
  wire [7:0] StackCounter;
  wire [7:0] StackValue;
  wire       RAMWriteEnable;
  wire       RAMEnable;
  wire [7:0] RAMAddress;
  wire [7:0] RAMDataIn;
  reg  [7:0] RAMDataOut;

  // instantiate the Multiplexer module
  StackController StackControllerInst (
      .Push          (Push),
      .Pop           (Pop),
      .Clk           (Clk),
      .Reset         (Reset),
      .DataIn        (DataIn),
      .StackCounter  (StackCounter),
      .StackValue    (StackValue),
      .RAMWriteEnable(RAMWriteEnable),
      .RAMEnable     (RAMEnable),
      .RAMAddress    (RAMAddress),
      .RAMDataIn     (RAMDataIn),
      .RAMDataOut    (RAMDataOut)
  );

  // instantiate variable
  integer flag = 0;
  integer TestCaseNo = 0;
  integer i;
  integer j;

  // task to check the output
  task check_output;
    input integer TestCaseNo;
    input reg [7:0] expected_StackCounter;
    input reg [7:0] expected_StackValue;
    input reg expected_RAMWriteEnable;
    input reg expected_RAMEnable;
    input reg [7:0] expected_RAMAddress;
    input reg [7:0] expected_RAMDataIn;
    begin
      if (StackCounter !== expected_StackCounter || StackValue !== expected_StackValue || RAMWriteEnable !== expected_RAMWriteEnable || RAMEnable !== expected_RAMEnable || RAMAddress !== expected_RAMAddress || RAMDataIn !== expected_RAMDataIn) begin
        $error(
            "ERROR: TestCaseNo %0d | Time = %0t | StackCounter = %b (Expected: %b) | StackValue = %b (Expected: %b) | RAMWriteEnable = %b (Expected: %b) | RAMEnable = %b (Expected: %b) | RAMAddress = %b (Expected: %b) | RAMDataIn = %b (Expected: %b)",
            TestCaseNo, $time, StackCounter, expected_StackCounter, StackValue,
            expected_StackValue, RAMWriteEnable, expected_RAMWriteEnable, RAMEnable,
            expected_RAMEnable, RAMAddress, expected_RAMAddress, RAMDataIn, expected_RAMDataIn);
        flag = 1;
      end
    end
  endtask

  localparam CLK_PERIOD = 2;
  always #(CLK_PERIOD / 2.0) Clk = ~Clk;

  // test cases
  initial begin
    // Reset
    Clk = 0;
    Reset = 0;
    Push = 0;
    Pop = 0;
    DataIn = 0;
    RAMDataOut = 0;
    #(CLK_PERIOD + 0.1);
    Reset = 1;
    #(CLK_PERIOD);
    // Reset done

    if (flag == 0) begin
      $display("All test cases pass");
    end else begin
      $display("Some test cases fail");
    end
    $finish;
  end
endmodule
