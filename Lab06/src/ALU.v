module ALU (
    input [3:0] ALUctl,                     // This will be used to select the operation of ALU
    input brLt,                             // Branch Less Than (for branching instruction)
    input brEq,                             // Branch Equal (for branching instruction)
    input signed [31:0] A,B,                // Operands
    output reg signed [31:0] ALUOut        // Output of ALU
);
    // ALU has two operand, it execute different operator based on ALUctl wire

    // TODO: implement your ALU here
    // Hint: you can use operator to implement

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


        wire[31: 0] nextPc = A + 32'd4;




        always @(*) begin
        ///// FOR NOW we use funct 3 as a decoder
        case(ALUctl)
            ALU_CTL_PLUS  : ALUOut = A + B; //// add, addi
            ALU_CTL_MINUS : ALUOut = $signed(A) - $signed(B); // sub
            ALU_CTL_AND   : ALUOut = A & B; // and
            ALU_CTL_OR    : ALUOut = A | B; // or
            ALU_CTL_SLT   : ALUOut = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0; //slt and slti
            
            ALU_BR_BEQ    : ALUOut = ( brEq) ? (A + B):nextPc;
            ALU_BR_BNE    : ALUOut = (!brEq) ? (A + B):nextPc;
            ALU_BR_BLT    : ALUOut = ( brLt) ? (A + B):nextPc;
            ALU_BR_BGE    : ALUOut = (!brLt) ? (A + B):nextPc;

        endcase
    end
    
endmodule

