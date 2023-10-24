`timescale 1ns/100ps

module ElementAddition_I
#(
	parameter ELEMENT_WIDTH = 64
)
(
	clk,
	reset_n,
	
	valid,
	bundle_loop,
	elem_A,
	elem_B,
	
	elem_out,
	overflow,
	
	done
);

input logic clk;
input logic reset_n;

input logic valid;
input logic bundle_loop;
input logic [ELEMENT_WIDTH-1:0] elem_A;
input logic [ELEMENT_WIDTH-1:0] elem_B;

output logic [ELEMENT_WIDTH-1:0] elem_out;
output logic overflow;
output logic done;


logic overflow_a; // Upper bit of the last input
logic overflow_b; // Upper bit of the last output

logic overflow_c; // Current overflow bit
logic overflow_p; // Perminant overflow bit

// If the sum of two positive numbers yields a negative result, the sum has overflowed.
// If the sum of two negative numbers yields a positive result, the sum has overflowed.
assign overflow_c = (~overflow_a & ~overflow_b & elem_out[ELEMENT_WIDTH-1]) | (overflow_a & overflow_b & ~elem_out[ELEMENT_WIDTH-1]) ? 1'b1 : 1'b0;

// To avoid the clock cycle delay for current overflow to permanent overflow propagation
assign overflow = overflow_c | overflow_p;


// Track when an addition has been re-started to drop done bit
logic valid_last;
logic done_i;

assign done = (valid & ~valid_last) ? 1'b0 : done_i;


always_ff @ (posedge clk or negedge reset_n) begin
	// Reset output to zero
	if(!reset_n) begin
		elem_out <= {ELEMENT_WIDTH{1'b0}};
		overflow_c <= 1'b0;
		overflow_p <= 1'b0;
		done_i <= 1'b0;
		valid_last <= 1'b0;
	end else begin
		valid_last <= valid;
		// If input is valid, add the elem_in to the elem_out, check for overflow
		if (valid) begin
			// Allow bundle loop for multiple bunidling without re-write to memory
			if (bundle_loop) begin
				elem_out <= elem_A + elem_out;
				overflow_a <= elem_A[ELEMENT_WIDTH-1];
				overflow_b <= elem_out[ELEMENT_WIDTH-1];
			end else begin
				elem_out <= elem_A + elem_B;
				overflow_a <= elem_A[ELEMENT_WIDTH-1];
				overflow_b <= elem_B[ELEMENT_WIDTH-1];
			end
			done_i <= 1'b1;
		end
		// If the last addition overflowed, set the permanent overflow to 1, to remember the overflow
		if (overflow_c) begin
			overflow_p <= 1'b1;
		end
	end
end


endmodule
