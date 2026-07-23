module top_module ( input a, input b, output out );
	// Create an instance of "mod_a" named "inst1", and connect ports by name:
    mod_a instance1( 
        .in1(a), // Port"in1"connects to wire "a"
		.in2(b),	// Port "in2" connects to wire "b"
		.out(out)	// Port "out" connects to wire "out" 
				// (Note: mod_a's port "out" is not related to top_module's wire "out". 
				// It is simply coincidence that they have the same name)
    );

endmodule
