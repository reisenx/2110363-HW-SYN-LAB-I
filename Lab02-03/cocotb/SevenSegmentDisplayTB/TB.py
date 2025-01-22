import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock

@cocotb.test()
async def SevenSegmentDisplayTB(dut):
    """Try accessing the design."""
    dut._log.info("Running test!")
    # create the clock
    cocotb.start_soon(Clock(dut.Clk, 1, units="ns").start())
    # variables
    AN_VALUE = [14,13,11,7]
    segment_values = [
        0b00000011,  # Equivalent to decimal 3
        0b10011111,  # Equivalent to decimal 159
        0b00100101,  # Equivalent to decimal 37
        0b00001101,  # Equivalent to decimal 13
        0b10011001,  # Equivalent to decimal 153
        0b01001001,  # Equivalent to decimal 73
        0b01000001,  # Equivalent to decimal 65
        0b00011111,  # Equivalent to decimal 31
        0b00000001,  # Equivalent to decimal 1
        0b00001001,  # Equivalent to decimal 9
        0b00010001,  # Equivalent to decimal 17
        0b11000001,  # Equivalent to decimal 193
        0b01100011,  # Equivalent to decimal 99
        0b10000101,  # Equivalent to decimal 133
        0b01100001,  # Equivalent to decimal 97
        0b01110001,  # Equivalent to decimal 113
    ]
    # reset
    dut.Reset.value = 0
    dut.DataIn.value = 0
    await Timer(1.2, units="ns")
    dut.Reset.value = 1
    await Timer(1, units="ns")
    dut.Reset.value = 0
    assert dut.AN.value == 15
    assert dut.Segments.value == segment_values[0]
    await Timer(1, units="ns")
    for i in range(4):
        for j in range(16):
            dut.DataIn.value = j * (16 ** i)
            await Timer(1, units="ns")
            assert dut.Segments.value == segment_values[j]
            assert dut.AN.value == AN_VALUE[i]
            await Timer(1, units="ns")
        await Timer(70, units="ns")
    dut._log.info("Test Complete")
