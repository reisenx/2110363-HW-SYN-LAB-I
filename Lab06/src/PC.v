module PC (
    input clk,              // clock
    input rst,              // active low reset
    input [31:0] pc_i,      // input program counter (value which will be assigned to PC)
    output reg [31:0] pc_o  // output program counter
);

    // TODO: implement your program counter here
    // Hint: If reset is low, assign PC to zero

        always @(posedge clk, negedge rst) begin

        if (!rst) begin
            pc_o <= 0;
        end else begin
            pc_o <= pc_i;
        end
    end


endmodule

