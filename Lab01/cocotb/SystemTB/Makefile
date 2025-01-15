# Makefile

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/../../src/*.v
# VERILOG_SOURCES += $(PWD)/../Lab1PartA.srcs/sources_1/new/Module2.v
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = System

# MODULE is the basename of the Python test file
MODULE = TB

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim