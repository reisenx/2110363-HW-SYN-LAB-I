module ALUCtrl (
    input [2:0] ALUOp,          // ALU operation
    input funct7,               // funct7 field of instruction (only 30th bit of instruction)
    input [2:0] funct3,         // funct3 field of instruction
    output reg [3:0] ALUCtl     // ALU control signal
);

    // TODO: implement your ALU control here
    // For testbench verifying, Do not modify input and output pin
    // For funct7, we care only 30th bit of instruction. Why?
    // See all R-type instructions in the lab and observe.

    // Hint: using ALUOp, funct7, funct3 to select exact operation

    parameter ALU_OP                    = 3'b100;
    parameter ALU_COMPUTE_MEM_ADDR      = 3'b000;
    parameter ALU_COMPUTE_BRANCH_ADDR   = 3'b010;
    parameter ALU_OP_I                  = 3'b110;
    parameter ALU_COMPUTE_JUMP_ADDR     = 3'b011;
    parameter ALU_COMPUTE_JUMPR_ADDR    = 3'b101;

    ////// norm alu
    parameter ALU_CTL_PLUS              = 4'b0000;
    parameter ALU_CTL_MINUS             = 4'b1000;
    parameter ALU_CTL_AND               = 4'b0111;
    parameter ALU_CTL_OR                = 4'b0110;
    parameter ALU_CTL_SLT               = 4'b0010;
    ////// branch alu
    parameter ALU_BR_BEQ                = 4'b1010;
    parameter ALU_BR_BNE                = 4'b1001;
    parameter ALU_BR_BLT                = 4'b1100;
    parameter ALU_BR_BGE                = 4'b1101;

    parameter BEQ_RAW_FUCT3             = 3'b000;

    always @(*) begin
        
        case(ALUOp)
            ALU_OP                  : ALUCtl = {funct7, funct3};
            ALU_COMPUTE_MEM_ADDR    : ALUCtl = ALU_CTL_PLUS;
            ALU_COMPUTE_BRANCH_ADDR : begin
                
                        if (funct3 == BEQ_RAW_FUCT3)begin
                            ALUCtl = ALU_BR_BEQ;
                        end else begin
                            ALUCtl = {1'b1, funct3};
                        end

            end 
            ALU_OP_I                : ALUCtl = {1'b0, funct3};
            ALU_COMPUTE_JUMP_ADDR   : ALUCtl = ALU_CTL_PLUS;
            ALU_COMPUTE_JUMPR_ADDR  : ALUCtl = ALU_CTL_PLUS;
        endcase


    end

endmodule

