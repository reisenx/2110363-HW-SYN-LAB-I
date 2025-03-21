module Mux3to1 #(
    parameter size = 32
) 
(
    input [1:0] sel,                // Selector (2 bits)
    input signed [size-1:0] s0,     // Input 0
    input signed [size-1:0] s1,     // Input 1
    input signed [size-1:0] s2,     // Input 2
    output signed [size-1:0] out    // Output
);
    // TODO: implement your 3to1 multiplexer here

    assign out = (sel == 2'b00) ? s0 : (sel == 2'b01) ? s1 : s2; //if sel is 1, output s1, else output s0

    
endmodule

