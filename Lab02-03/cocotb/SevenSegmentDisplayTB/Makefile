# Makefile

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/../../src/SevenSegmentDisplay.v $(PWD)/../../src/SevenSegmentController.v $(PWD)/../../src/SevenSegmentDecoder.v $(PWD)/../../src/Multiplexer.v $(PWD)/SevenSegmentDisplayTB.v
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = SevenSegmentDisplayTB

# MODULE is the basename of the Python test file
MODULE = TB

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim