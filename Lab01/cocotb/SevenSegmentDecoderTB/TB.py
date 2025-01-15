import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def SevenSegmentDecoderTB(dut):
    """Try accessing the design."""
    dut._log.info("Running test!")
    # create a testbench here
    test_cases = {
        0x0: 0b00000011,  # 0
        0x1: 0b10011111,  # 1
        0x2: 0b00100101,  # 2
        0x3: 0b00001101,  # 3
        0x4: 0b10011001,  # 4
        0x5: 0b01001001,  # 5
        0x6: 0b01000001,  # 6
        0x7: 0b00011111,  # 7
        0x8: 0b00000001,  # 8
        0x9: 0b00001001,  # 9
        0xA: 0b00010001,  # A
        0xB: 0b11000001,  # B
        0xC: 0b01100011,  # C
        0xD: 0b10000101,  # D
        0xE: 0b01100001,  # E
        0xF: 0b01110001,  # F
    }

    for DataIn, expected_segments in test_cases.items() :
        #assign data input
        dut.DataIn.value = DataIn
        #wait to change
        await Timer(1, units='ns')

        assert dut.Segments.value == expected_segments
    
    dut._log.info("Test Complete")
