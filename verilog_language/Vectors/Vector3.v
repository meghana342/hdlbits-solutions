module top_module (
    input [4:0] a, b, c, d, e, f,
    output [7:0] w, x, y, z 
);

    // Bundle the 8-bit outputs together (32 bits total)
    // Bundle the 5-bit inputs + two '1' bits together (30 + 2 = 32 bits total)
    assign {w, x, y, z} = {a, b, c, d, e, f, 2'b11};

endmodule
