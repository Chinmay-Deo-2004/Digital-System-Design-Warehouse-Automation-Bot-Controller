// mux8to1.v
module mux8to1 (
    input  wire [7:0] in,      // 8 input lines
    input  wire [2:0] sel,     // 3-bit selector
    output wire       out      // Output
);
    assign out = in[sel]; // Simple and synthesizable
endmodule
