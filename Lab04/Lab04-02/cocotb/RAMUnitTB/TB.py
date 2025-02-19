import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock


@cocotb.test()
async def RAMUnitTB(dut):
    """Try accessing the design."""

    dut._log.info("Running test!")
    # create the clock
    cocotb.start_soon(Clock(dut.Clk, 1, units="ns").start())

    # reset
    dut.Reset.value = 1
    dut.Address.value = 0
    dut.WriteEnable.value = 0
    dut.RamEnable.value = 0
    dut.Address.value = 0
    dut.DataIn.value = 0
    await Timer(1, units="ns")
    dut.Reset.value = 0
    dut.WriteEnable.value = 1
    dut.RamEnable.value = 1
    # write the RAM
    for i in range (256):
        dut.Address.value = i
        dut.DataIn.value = i
        await Timer(1, units="ns")
    # read the RAM
    dut.WriteEnable.value = 0
    for i in range (256):
        dut.Address.value = i
        await Timer(1, units="ns")
        assert dut.DataOut.value == i
    # write the RAM when not write enabled
    dut.Address.value = 5
    dut.DataIn.value = 123
    await Timer(1, units="ns")
    assert dut.DataOut.value == 5
    # read the RAM when not ram enabled
    dut.RamEnable.value = 0
    for i in range (256):
        dut.Address.value = i
        await Timer(1, units="ns")
        assert dut.DataOut.value == 5
    dut._log.info("Test Complete")
