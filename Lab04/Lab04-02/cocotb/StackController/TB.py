import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock


@cocotb.test()
async def StackControllerTB(dut):
    """Try accessing the design."""

    dut._log.info("Running test!")
    # create the clock
    cocotb.start_soon(Clock(dut.Clk, 1, units="ns").start())

    # reset
    dut.Reset.value = 1
    dut.Push.value = 0
    dut.Pop.value = 0
    dut.DataIn.value = 0
    dut.RAMDataOut.value = 0
    await Timer(1, units="ns")
    dut.Reset.value = 0
    # insert your test here
    dut._log.info("Test Complete")
