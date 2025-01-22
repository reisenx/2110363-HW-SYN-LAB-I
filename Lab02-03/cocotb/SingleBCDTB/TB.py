import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock

@cocotb.test()
async def SingleBCDTB(dut):
    """Try accessing the design."""
    dut._log.info("Running test!")
    # create the clock
    cocotb.start_soon(Clock(dut.Clk, 1, units="ns").start())
    # Reset the design
    dut.Reset.value = 1
    dut.Trigger.value = 0
    dut.Cin.value = 0
    await Timer(1.2, units="ns")
    dut.Reset.value = 0
    assert dut.DataOut.value == 0
    assert dut.Cout.value == 0
    # Insert your testcase here

    dut._log.info("Test Complete")
