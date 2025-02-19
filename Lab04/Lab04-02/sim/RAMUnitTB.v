`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/24/2025 12:00:33 AM
// Design Name: StackCircuit
// Module Name: RAMUnitTB
// Project Name: StackCircuit
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: The Testbench for the RAMUnit module
//////////////////////////////////////////////////////////////////////////////////


module RAMUnitTB ();
  // reg/wire declaration
  reg Clk;
  reg Reset;
  reg WriteEnable;
  reg RamEnable;
  reg [7:0] Address;
  reg [7:0] DataIn;
  wire [7:0] DataOut;

  // instantiate the Multiplexer module
  RAMUnit RAMUnitInst (
      .Clk        (Clk),
      .Reset      (Reset),
      .WriteEnable(WriteEnable),
      .RamEnable  (RamEnable),
      .Address    (Address),
      .DataIn     (DataIn),
      .DataOut    (DataOut)
  );

  // instantiate variable
  integer flag = 0;
  integer TestCaseNo = 0;
  integer i;
  integer j;

  // task to check the output
  task check_output;
    input integer TestCaseNo;
    input reg [7:0] expected_DataOut;  // Expected output
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
    Clk = 0;
    Reset = 0;
    WriteEnable = 0;
    RamEnable = 0;
    Address = 0;
    DataIn = 0;
    #(CLK_PERIOD + 0.1);
    Reset = 1;
    #(CLK_PERIOD);
    Reset = 0;

    // Write to RAM
    WriteEnable = 1;
    RamEnable = 1;
    for (i = 0; i < 256; i = i + 1) begin
      Address = i;
      DataIn = i;
      #(CLK_PERIOD);
    end
    WriteEnable = 0;
    // Read from RAM
    for (i = 0; i < 256; i = i + 1) begin
      Address = i;
      #(CLK_PERIOD);
      check_output(i, i);
    end
    // Try to write to RAM when not enabled
    Address = 5;
    DataIn = 123;
    #(CLK_PERIOD);
    check_output(256, 5);
    // Read from RAM when not enabled
    RamEnable = 0;
    for (i = 0; i < 256; i = i + 1) begin
      Address = i;
      #(CLK_PERIOD);
      check_output(i + 257, 5);
    end

    if (flag == 0) begin
      $display("All test cases pass");
    end else begin
      $display("Some test cases fail");
    end
    $finish;
  end
endmodule
