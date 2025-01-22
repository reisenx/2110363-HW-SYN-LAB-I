`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/09/2025 03:30:01 PM
// Design Name: BCD_Counter
// Module Name: FourBCDTB
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: The Testbench for the FourBCD module
//////////////////////////////////////////////////////////////////////////////////


module FourBCDTB ();
  // reg/wire declaration
  reg  [ 3:0] Trigger;
  reg         Clk;
  reg         Reset;
  wire [15:0] DataOut;

  // instantiate the Multiplexer module
  FourBCD FourBCDInst (
      .Trigger(Trigger),
      .Clk(Clk),
      .Reset(Reset),
      .DataOut(DataOut)
  );
  // instantiate variable
  integer flag = 0;
  integer TestCaseNo = 0;
  integer i;
  integer sum = 0;
  integer BCD_SUM = 0;

  // task to check the output
  task check_output;
    input integer TestCaseNo;
    input reg [15:0] expected_DataOut;  // Expected output
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
    Trigger = 0;
    #(CLK_PERIOD + 0.1);
    Reset = 1;
    #(CLK_PERIOD);
    Reset   = 0;
    Trigger = 15;
    check_output(0, 0);
    for (i = 0; i < 10; i = i + 1) begin
      #(CLK_PERIOD);
      sum = (sum + 1111) % 10000;
      BCD_SUM = sum%10 + (sum/10)%10*16 + (sum/100)%10*256 + (sum/1000)%10*4096;
      check_output(i + 1, BCD_SUM);
    end
    if (flag == 0) begin
      $display("All test cases pass");
    end else begin
      $display("Some test cases fail");
    end
    $finish;
  end
endmodule
