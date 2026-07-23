module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output reg [7:0] q  // Notice we changed 'output [7:0] q' to 'output reg [7:0] q'
);

    // Step 1: Declare 8-bit wide internal vectors to bridge the flop stages
    wire [7:0] q1, q2, q3;

    // Step 2: Instantiate the three 8-bit DFF modules (chaining them together)
    my_dff8 u1 ( .clk(clk), .d(d),  .q(q1) ); // Stage 1 (1 cycle delay)
    my_dff8 u2 ( .clk(clk), .d(q1), .q(q2) ); // Stage 2 (2 cycles delay)
    my_dff8 u3 ( .clk(clk), .d(q2), .q(q3) ); // Stage 3 (3 cycles delay)

    // Step 3: Implement the 8-bit wide 4-to-1 Multiplexer
    // Using always @(*) for clean combinational logic
    always @(*) begin
        case (sel)
            2'b00: q = d;   // 0 cycles delay (bypass)
            2'b01: q = q1;  // 1 cycle delay
            2'b10: q = q2;  // 2 cycles delay
            2'b11: q = q3;  // 3 cycles delay
            default: q = 8'b0; // Good practice to prevent unwanted latches
        endcase
    end

endmodule

