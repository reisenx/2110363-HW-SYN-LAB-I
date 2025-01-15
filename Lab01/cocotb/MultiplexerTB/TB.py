import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def MultiplexerTB(dut):
    """Try accessing the design."""
    dut._log.info("Running test!")

    for i in range(16):
        for j in range(16):
            for k in range(2):
                dut.In0.value = i
                dut.In1.value = j
                dut.Selector.value = k
                await Timer(1, units='ns')
                if(k == 0):
                    assert dut.DataOut.value == i
                else:
                    assert dut.DataOut.value == j
    
    dut._log.info("Test Complete")
