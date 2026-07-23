module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

    // Internal wires to hold the carry-out of the lower adder
    wire cout_lower;
    
    // Internal buses to hold the two pre-computed upper sum candidates
    wire [15:0] sum_upper_0;
    wire [15:0] sum_upper_1;

    // 1. Lower 16-bit Adder (always assumes cin = 0)

    add16 u_lower (
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(1'b0),
        .sum(sum[15:0]),     // Wire directly to lower half of output
        .cout(cout_lower)    // This carry will act as our MUX select line!
    );


    // 2. Upper 16-bit Adder Candidate A (assumes cin = 0)

    add16 u_upper_0 (
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(1'b0),
        .sum(sum_upper_0),   // Hold in candidate wire A
        .cout()              // Ignored
    );


    // 3. Upper 16-bit Adder Candidate B (assumes cin = 1)

    add16 u_upper_1 (
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(1'b1),
        .sum(sum_upper_1),   // Hold in candidate wire B
        .cout()              // Ignored
    );


    // 4. 16-bit 2-to-1 Multiplexer
    // If cout_lower is 1, pick sum_upper_1. Else, pick sum_upper_0.

    assign sum[31:16] = cout_lower ? sum_upper_1 : sum_upper_0;

endmodule
