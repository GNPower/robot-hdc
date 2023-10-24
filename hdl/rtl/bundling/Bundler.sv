`timescale 1ns/100ps

module Bundler
#(
	// Unsigned Int = 1
	// Signed Int = 2
	// Floating Point = 3
	parameter ELEMENT_TYPE = 2,
	
	// Only used for Element Types 1 & 2
	// Max value is 64
	parameter ELEMENT_WIDTH = 64,
	
	// Only used for Element Type 3
	// Max sum of values is 63 (+1 implicit sign bit)
	parameter EXPONENT_WIDTH = 8,
	parameter MANTISSA_WIDTH = 23,
	
	parameter HYPERVECTOR_DIMENSIONS = 100,
	parameter NUM_PARALLEL_KERNELS = 1,
	
	// Element Addition = 1
	parameter BUNDLING_TYPE = 1,
)
(
	// clock and reset
	clk,
	reset_n,
	
	// Input data
	valid,
	hvec_A,
	hvec_B,
	
	// Output data
	hvec_Res,
	done
);

input logic clk;
input logic reset_n;

input logic valid;
input logic [ELEMENT_WIDTH-1:0] hvec_A [0:NUM_PARALLEL_KERNELS-1];
input logic [ELEMENT_WIDTH-1:0] hvec_B [0:NUM_PARALLEL_KERNELS-1];

output logic [ELEMENT_WIDTH-1:0] hvec_Res [0:NUM_PARALLEL_KERNELS-1];
output logic done;

genvar i;
logic [1:0] state;


// Grouped Kernel
generate
	if (BUNDLING_TYPE == 1) begin
	
		ElementAddition
		#(
			.ELEMENT_TYPE(ELEMENT_TYPE),
			.ELEMENT_WIDTH(ELEMENT_WIDTH),
			.EXPONENT_WIDTH(EXPONENT_WIDTH),
			.MANTISSA_WIDTH(MANTISSA_WIDTH),			
			.HYPERVECTOR_DIMENSIONS(HYPERVECTOR_DIMENSIONS),
			.NUM_PARALLEL_KERNELS(NUM_PARALLEL_KERNELS)
		)
		element_addition_inst
		(
			.clk(clk),
			.reset_n(reset_n),
			
			.valid(),
			.bundle_loop(1'b0),
			.elem_A(),
			.elem_B(),
			
			.elem_out(),
			.overflow(),
			.done()
		);
	
	end
endgenerate




always_ff @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		for ( i = 0; i < HYPERVECTOR_DIMENSIONS; i = i +1) begin
			hvec_Res[i] <= {ELEMENT_WIDTH{1'b0}};		
		end
		state <= S_IDLE;
	end else begin
		case (state)
			S_IDLE:	begin
							
							done <= 1'b0;
							if (valid) begin
								state <= S_
							end else begin
								state <= S_IDLE;
							end
							
						end
			
		endcase
	end
end


endmodule
