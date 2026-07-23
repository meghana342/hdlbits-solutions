module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cout_internal;

    // Lower 16 bits (bits 15:0)
    add16 u1 (
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(1'b0),        
        .sum(sum[15:0]),  
        .cout(cout_internal) 
    );

    // Upper 16 bits (bits 31:16)
    add16 u2 (
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(cout_internal), 
        .sum(sum[31:16]), 
        .cout()              
    );

endmodule


module add1 ( 
    input a, 
    input b, 
    input cin,   
    output sum, 
    output cout 
);


    assign sum  = a ^ b ^ cin;

    assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
