module SingleCycleCPU (
    input   wire        clk,
    input   wire        start,
    output  wire [7:0]  segments,
    output  wire [3:0]  an
);

// When input start is zero, cpu should reset
// When input start is high, cpu start running

// TODO: Connect wires to realize SingleCycleCPU and instantiate all modules related to seven-segment displays
// The following provides simple template,
wire [31:0] pc, pcNext, inst, imm, aluResult, regData1, regData2, writeData, memReadData;
wire [31:0] pcPlus4, branchTarget;
wire [31:0] aluIn1, aluIn2;
wire [4:0] rd, rs1, rs2;
wire [2:0] aluCtrl;
wire [1:0] writeDataSel, memtoReg;
wire [6:0] opcode;
wire [2:0] funct3;
wire [6:0] funct7;
wire [3:0] ALUCtl;
wire memRead, memWrite, aluSrc1, aluSrc2, regWrite, pcSel, brLt, brEq;

PC m_PC(
    .clk(clk),
    .rst(start),      
    .pc_i(pcNext),      
    .pc_o(pc)         
);

Adder m_Adder_1(
    .a(pc),
    .b(32'd4),
    .sum(pcPlus4)
);

InstructionMemory m_InstMem(
    .readAddr(pc),
    .inst(inst)
);

assign opcode = inst[6:0];
assign rs1 = inst[19:15];
assign rs2 = inst[24:20];
assign rd = inst[11:7];
assign funct3 = inst[14:12];
assign funct7 = inst[30];

Control m_Control(
    .opcode(opcode),
    .memRead(memRead),
    .memtoReg(memtoReg),
    .ALUOp(aluCtrl),
    .memWrite(memWrite),
    .ALUSrc1(aluSrc1),
    .ALUSrc2(aluSrc2),
    .regWrite(regWrite),
    .PCSel(pcSel)
);

// ------------------------------------------
// For Student:
// Do not change the modules' instance names and I/O port names!!
// Or you will fail validation.
// By the way, you still have to wire up these modules

Register m_Register(
    .clk(clk),
    .rst(start),
    .regWrite(regWrite),
    .readReg1(rs1),
    .readReg2(rs2),
    .writeReg(rd),
    .writeData(writeData),
    .readData1(regData1),
    .readData2(regData2),
    .reg5Data()
);

DataMemory m_DataMemory(
    .rst(start),
    .clk(clk),
    .memWrite(memWrite),
    .memRead(memRead),
    .address(aluResult),
    .writeData(regData2),
    .readData(memReadData)
);

// ------------------------------------------

ImmGen m_ImmGen(
    .inst(inst),
    .imm(imm)
);

Mux2to1 #(.size(32)) m_Mux_PC(
    .sel(pcSel),
    .s0(pcPlus4),
    .s1(aluResult),
    .out(pcNext)
);

Mux2to1 #(.size(32)) m_Mux_ALU_1(
    .sel(aluSrc1),
    .s0(regData1),
    .s1(pc),
    .out(aluIn1)
);

Mux2to1 #(.size(32)) m_Mux_ALU_2(
    .sel(aluSrc2),
    .s0(regData2),
    .s1(imm),
    .out(aluIn2)
);

ALUCtrl m_ALUCtrl(
    .ALUOp(aluCtrl),
    .funct7(funct7),
    .funct3(funct3),
    .ALUCtl(ALUCtl) // ??
);

ALU m_ALU(
    .ALUctl(ALUCtl), // ??
    .brLt(brLt),
    .brEq(brEq),
    .A(aluIn1),
    .B(aluIn2),
    .ALUOut(aluResult)
);

Mux3to1 #(.size(32)) m_Mux_WriteData(
    .sel(memtoReg), // memtoReg
    .s0(aluResult),
    .s1(memReadData),
    .s2(pcPlus4),
    .out(writeData)
);

BranchComp m_BranchComp(
    .rs1(regData1),
    .rs2(regData2),
    .brLt(brLt),
    .brEq(brEq)
);

`ifdef COCOTB_SIM
  initial begin
    $dumpfile("waveform.vcd");  // Name of the dump file
    $dumpvars(0, SingleCycleCPU);  // Dump all variables for the top module
  end
`endif

endmodule