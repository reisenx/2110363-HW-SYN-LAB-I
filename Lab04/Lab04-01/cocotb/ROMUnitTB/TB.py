import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock


@cocotb.test()
async def ROMUnitTB(dut):
    """Try accessing the design."""

    dut._log.info("Running test!")
    # create the clock
    cocotb.start_soon(Clock(dut.Clk, 1, units="ns").start())

    # reset
    dut.Reset.value = 1
    dut.Address.value = 0
    await Timer(1, units="ns")
    dut.Reset.value = 0
    for i in range (64):
        dut.Address.value = i
        await Timer(1, units="ns")
        assert dut.DataOut.value == ((i%10) + (i//10*16))
    dut._log.info("Test Complete")
