module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    // Step 1: Declare a single internal wire to bridge the carry-out to carry-in
    wire cout_internal;

    // Step 2: Instantiate the lower 16-bit adder (computes bits 15 to 0)
    add16 u1 (
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(1'b0),         // Tied to 0 as per instructions
        .sum(sum[15:0]),    // Wire directly to lower half of final output
        .cout(cout_internal) // Send carry bit to our internal wire
    );

    // Step 3: Instantiate the upper 16-bit adder (computes bits 31 to 16)
    add16 u2 (
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(cout_internal), // Catch the carry bit from u1
        .sum(sum[31:16]),    // Wire directly to upper half of final output
        .cout()              // Leave empty to ignore (standard Verilog practice)
    );

endmodule
