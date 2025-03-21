module BranchComp(
    input [31:0] rs1,       // First register value
    input [31:0] rs2,       // Second register value
    output brLt,            // Output for less than condition
    output brEq             // Output for equality condition
);

    // TODO: implement your branch comparator here for checking if
    // value is register is less than or equal to another register

    assign brEq = (rs1 == rs2);
    assign brLt = ($signed(rs1) <  $signed(rs2));


endmodule