# Please read this markdown before running CocoTB testbenches

In InstructionMemory.v file, modify the $readmemb to read from absolute path instead of relate path

----- Example -----

$readmemb("/home/TA/Desktop/HW_SYN_LAB_TA/WorkPlace/Lab6/src/EXAMPLE_INSTRUCTIONS.mem", insts);
