`timescale 1ns/100ps

module ElementAddition
#(
	// Unsigned Int = 1
	// Signed Int = 2
	// Floating Point = 3
	parameter ELEMENT_TYPE = 2,
	
	// Only used for Element Types 1 & 2
	parameter ELEMENT_WIDTH = 64,
	
	// Only used for Element Type 3
	parameter EXPONENT_WIDTH = 8,
	parameter MANTISSA_WIDTH = 23,
	
	parameter HYPERVECTOR_DIMENSIONS = 100,
	parameter NUM_PARALLEL_KERNELS = 1
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
input logic [ELEMENT_WIDTH-1:0] elem_A [0:NUM_PARALLEL_KERNELS-1];
input logic [ELEMENT_WIDTH-1:0] elem_B [0:NUM_PARALLEL_KERNELS-1];

output logic [ELEMENT_WIDTH-1:0] elem_out [0:NUM_PARALLEL_KERNELS-1];
output logic overflow [0:NUM_PARALLEL_KERNELS-1];
output logic done;

logic [NUM_PARALLEL_KERNELS-1:0] done_i;
assign done = &done_i;

genvar i;
generate
	for (i = 0; i < NUM_PARALLEL_KERNELS; i++) begin : kernel_i
		
		if (ELEMENT_TYPE == 1) begin
		
			
		
		end else if (ELEMENT_TYPE == 2) begin
		
			ElementAddition_I( .ELEMENT_WIDTH(ELEMENT_WIDTH) ) element_addition_signed
			(
				.clk(clk),
				.reset_n(reset_n),
				
				.valid(valid),
				.bundle_loop(bundle_loop),
				.elem_A(elem_A[i]),
				.elem_B(elem_B[i]),
				
				.elem_out(elem_out[i]),
				.overflow(overflow[i]),
				
				.done(done_i[i])
			);
		
		end else if (ELEMENT_TYPE == 3) begin
		
			
		
		end
		
		
		
	end
endgenerate


endmodule
