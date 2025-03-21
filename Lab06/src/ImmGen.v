module ImmGen (
    input [31:0] inst,                  // instruction
    output reg signed [31:0] imm        // imm value (output)
);
    // ImmGen generate imm value base opcode

    parameter OP_JAL    = 7'b1101111;
    parameter OP_JALR   = 7'b1100111;
    parameter OP_BRANCH = 7'b1100011;
    parameter OP_LW     = 7'b0000011;
    parameter OP_SW     = 7'b0100011;
    parameter OP_I      = 7'b0010011;
    parameter OP_R      = 7'b0110011;

    wire [6:0] opcode = inst[6:0];
    always @(*) begin
        case(opcode)
            // TODO: implement your ImmGen here
            // Hint: follow the RV32I opcode map (table in spec) to set imm value
            OP_BRANCH : imm = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0}; // B-type, shifted left by 1
            OP_LW     : imm = {{21{inst[31]}}, inst[30:20]};
            OP_SW     : imm = {{21{inst[31]}}, inst[30:25], inst[11:7]};
            OP_I      : imm = {{21{inst[31]}}, inst[30:20]};
            OP_JAL    : imm = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0}; // jal, shifted left by 1
            OP_JALR   : imm = {{21{inst[31]}}, inst[30:20]}; // jalr
            
        endcase
    end

endmodule

