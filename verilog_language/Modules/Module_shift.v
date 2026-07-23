module top_module ( input clk, input d, output q );
    // Step 1: Declare internal wires to bridge the flip-flops
    wire q1, q2;

    // Step 2: Instantiate and chain them together sequentially
    // Using by-name mapping for clean architecture
    my_dff inst1 ( .clk(clk), .d(d),  .q(q1) ); // Feeds wire q1
    my_dff inst2 ( .clk(clk), .d(q1), .q(q2) ); // Takes q1, feeds q2
    my_dff inst3 ( .clk(clk), .d(q2), .q(q)  ); // Takes q2, feeds final output q
endmodule
//	my_dff d1 ( clk, d, q1 );
//	my_dff d2 ( clk, q1, q2 );
//	my_dff d3 ( clk, q2, q );
