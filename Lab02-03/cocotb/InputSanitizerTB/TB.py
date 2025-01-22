import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock

@cocotb.test()
async def InputSanitizerTB(dut):
    """Try accessing the design."""
    dut._log.info("Running test!")
    # create the clock
    cocotb.start_soon(Clock(dut.Clk, 1, units="ns").start())

    # reset
    dut.Reset.value = 0
    dut.DataIn.value = 0
    await Timer(1.2, units="ns")
    dut.Reset.value = 1
    await Timer(1, units="ns")
    dut.Reset.value = 0
    assert dut.DataOut.value == 0
    for i in range(15):
        dut.DataIn.value = i
        await Timer(4, units="ns")
        dut.DataIn.value = 0
        assert dut.DataOut.value == i
        await Timer(2, units="ns")
    dut._log.info("Test Complete")
