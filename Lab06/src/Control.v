module Control (
    input [6:0] opcode,         // opcode field of instruction
    output reg memRead,         // memory read signal
    output reg [1:0] memtoReg,  // memory to register signal
    output reg [2:0] ALUOp,     // ALU operation signal
    output reg memWrite,        // memory write signal
    output reg ALUSrc1,         // ALU source 1 signal (for MUX)
    output reg ALUSrc2,         // ALU source 2 signal (for MUX)
    output reg regWrite,        // register write signal
    output reg PCSel            // PC select signal (for MUX PC)
);

    always @(*) begin
        // Default values to prevent latches
        memRead  = 0;
        memtoReg = 0;
        ALUOp    = 0;
        memWrite = 0;
        ALUSrc1  = 0;
        ALUSrc2  = 0;
        regWrite = 0;
        PCSel    = 0;

        case(opcode)
            7'b0110011 : begin // R-Type
                regWrite <= 1;
                ALUOp <= 3'b100;  // ALU performs operations
            end
            7'b0010011 : begin // I-Type (Immediate ALU instructions)
                ALUSrc2 <= 1;
                regWrite <= 1;
                ALUOp <= 3'b110;  // ALU performs immediate operations
            end
            7'b0000011 : begin // LW (Load Word)
                memRead <= 1;
                memtoReg <= 2'b01; // Load from memory
                ALUSrc2 <= 1;
                regWrite <= 1;
                ALUOp <= 3'b000; // Compute memory address
            end
            7'b0100011 : begin  // SW (Store Word)
                memWrite <= 1;
                ALUSrc2 <= 1;
                ALUOp <= 3'b000; // Compute memory address
            end
            7'b1100011 : begin // Branch
                PCSel <= 1;
                ALUSrc1 <= 1;
                ALUSrc2 <= 1;
                ALUOp <= 3'b010; // Compare registers
            end
            7'b1101111 : begin // JAL (Jump and Link)
                PCSel <= 1;
                regWrite <= 1;
                ALUSrc1 <= 1;
                ALUSrc2 <= 1;
                memtoReg <= 2'b10; // Write PC+4 to rd
                ALUOp <= 3'b011;  // Compute jump address
            end
            7'b1100111 : begin // JALR (Jump and Link Register)
                PCSel <= 1;
                regWrite <= 1;
                ALUSrc1 <= 0;
                ALUSrc2 <= 1;
                memtoReg <= 2'b10; // Write PC+4 to rd
                ALUOp <= 3'b101;  // Compute jump address
            end
        endcase
    end
endmodule