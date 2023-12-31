// fp_sqrt.v

// Generated using ACDS version 23.3 104

`timescale 1 ps / 1 ps
module fp_sqrt (
		input  wire        clk,    //    clk.clk
		input  wire        areset, // areset.reset
		input  wire [31:0] a,      //      a.a
		output wire [31:0] q       //      q.q
	);

	fp_sqrt_altera_fp_functions_1917_hchdkjq fp_functions_0 (
		.clk    (clk),    //   input,   width = 1,    clk.clk
		.areset (areset), //   input,   width = 1, areset.reset
		.a      (a),      //   input,  width = 32,      a.a
		.q      (q)       //  output,  width = 32,      q.q
	);

endmodule
