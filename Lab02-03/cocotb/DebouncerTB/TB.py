import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock

@cocotb.test()
async def DebouncerTB(dut):
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
    dut.DataIn.value = 1
    assert dut.DataOut.value == 0
    assert dut.DebouncerInst.Counter == 0
    await Timer(1, units="ns")
    assert dut.DataOut.value == 0
    assert dut.DebouncerInst.Counter == 1
    await Timer(1, units="ns")
    assert dut.DataOut.value == 0
    assert dut.DebouncerInst.Counter == 2
    await Timer(1, units="ns")
    dut.DataIn.value = 0
    for i in range(3):
        assert dut.DataOut.value == 1
        assert dut.DebouncerInst.Counter == i
        await Timer(1, units="ns")
    dut.DataIn.value = 1
    for i in range(3):
        assert dut.DataOut.value == 0
        assert dut.DebouncerInst.Counter == i
        await Timer(1, units="ns")
    for i in range(3):
        assert dut.DataOut.value == 1
        assert dut.DebouncerInst.Counter == i
        await Timer(1, units="ns")
    
    dut._log.info("Test Complete")
