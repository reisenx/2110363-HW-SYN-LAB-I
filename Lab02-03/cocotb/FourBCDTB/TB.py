import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock

def IntToBCD (num):
    BCD = 0
    for i in range(4):
        BCD = BCD + (num%10)*(16**i)
        num = num//10
    return BCD

@cocotb.test()
async def FourBCDTB(dut):
    """Try accessing the design."""
    dut._log.info("Running test!")
    # create the clock
    cocotb.start_soon(Clock(dut.Clk, 1, units="ns").start())
    # varilables
    sum = 0
    BCDSum = 0

    #reset
    dut.Reset.value = 0
    dut.Trigger.value = 0
    await Timer(1.2, units="ns")
    dut.Reset.value = 1
    await Timer(1, units="ns")
    dut.Reset.value = 0
    dut.Trigger.value = 0b1111
    assert dut.DataOut.value == 0
    for i in range (10):
        await Timer(1, units="ns")
        sum = (sum + 1111)%10000
        BCDSum = IntToBCD(sum)
        assert dut.DataOut.value == BCDSum

    dut._log.info("Test Complete")
