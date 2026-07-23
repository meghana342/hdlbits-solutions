module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);

    // Step 1: Declare an internal wire for the XORed version of bus b
    wire [31:0] b_xor;
    
    // Step 2: Declare the internal carry bridge between lower and upper adders
    wire cout_lower;

    // Step 3: Perform 32-bit XOR using the replication operator
    // If sub=1, b_xor becomes ~b. If sub=0, b_xor becomes b.
    assign b_xor = b ^ {32{sub}};

    // Step 4: Instantiate Lower 16-bit Adder (Notice cin is connected to 'sub'!)
    add16 u1 (
        .a(a[15:0]),
        .b(b_xor[15:0]),   // Pass the lower 16 bits of our XORed b bus
        .cin(sub),         // If sub=1, this adds the "+1" for Two's Complement!
        .sum(sum[15:0]),   
        .cout(cout_lower)  
    );

    // Step 5: Instantiate Upper 16-bit Adder
    add16 u2 (
        .a(a[31:16]),
        .b(b_xor[31:16]),  // Pass the upper 16 bits of our XORed b bus
        .cin(cout_lower),  // Catch the ripple carry from u1
        .sum(sum[31:16]),  
        .cout()            // Ignored
    );

endmodule
