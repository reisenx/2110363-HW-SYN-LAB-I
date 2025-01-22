import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock

@cocotb.test()
async def SevenSegmentControllerTB(dut):
    """Try accessing the design."""
    dut._log.info("Running test!")
    # create the clock
    cocotb.start_soon(Clock(dut.Clk, 1, units="ns").start())
    # Reset the design
    dut.Reset.value = 1
    await Timer(1.2, units="ns")
    dut.Reset.value = 0
    assert dut.AN.value == 15
    assert dut.Selector.value == 0
    # Insert your testcase here
    dut._log.info("Test Complete")
