`timescale 1ns/100ps

module ElementAddition_U
#(
	parameter ELEMENT_WIDTH = 64
)
(
	clk,
	reset_n,
	
	valid,
	elem_in,
	
	elem_out,
	overflow
);

input logic clk;
input logic reset_n;

input logic valid;
input logic [ELEMENT_WIDTH-1:0] elem_in;

output logic [ELEMENT_WIDTH-1:0] elem_out;
output logic overflow;


logic overflow_c; // Current overflow
logic overflow_p; // Past overflow

// To avoid the clock cycle delay for current overflow to permanent overflow propagation
assign overflow = overflow_c | overflow_p;


always_ff @ (posedge clk or negedge reset_n) begin
	// Reset output to zero
	if(!reset_n) begin
		elem_out <= {ELEMENT_WIDTH{1'b0}};
		overflow_c <= 1'b0;
		overflow_p <= 1'b0;
	end else begin
		// If input is valid, add the elem_in to the elem_out, check for overflow
		if (valid) begin
			{overflow_c, elem_out} <= elem_out + elem_in;			
		end
		// If the last addition overflowed, set the permanent overflow to 1, to remember the overflow
		if (overflow_c) begin
			overflow_p <= 1'b1;
		end
	end
end


endmodule