`timescale 1ns/100ps

module HyperdimensionalComputing
#(
	// Maximum num parallel kernels
	parameter NUM_PARALLEL_KERNELS = 1,
	
	// Number of dimensions in a Hypervector
	parameter HYPERVECTOR_DIMENSIONS = 100
)
(
	clk,
	reset_n,
	
	start,
	hvecA,
	hvecB,
	
	hvecRes,
	done
);

localparam LOOP_TIME


input logic clk;
input logic reset_n;

input logic valid;
input logic [63:0] hvecA 	[0:HYPERVECTOR_DIMENSIONS-1];
input logic [63:0] hvecB 	[0:HYPERVECTOR_DIMENSIONS-1];
output logic [63:0] hvecRes[0:HYPERVECTOR_DIMENSIONS-1];

output logic done;


genvar i;


always_ff @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		for (i = 0; i < HYPERVECTOR_DIMENSIONS; i = i + 1) begin
			hvecA[i] <= 64'b0;
			hvecB[i] <= 64'b0;
			hvecRes[i] <= 64'b0;
		end
	end else begin
		
	end
end







//
//localparam NUM_MEMORIES = 3 * NUM_PARALLEL_KERNELS;
//localparam NUM_WORDS_PER_MEMORY = (HYPERVECTOR_DIMENSIONS + NUM_PARALLEL_KERNELS - 1) / NUM_PARALLEL_KERNELS; // = ceil(#dims/#kernels)
//localparam MEMORY_ADDRESS_BITS = $clog2(NUM_WORDS_PER_MEMORY);
//localparam HYPERVECTOR_INDEX_BITS = $clog2(HYPERVECTOR_DIMENSIONS);
//
//enum bit [1:0] {
//	WRITE_ELEMENT = 0,
//	READ_ELEMENT = 1,
//	COMPUTE_ELEMENT = 2
//};
//
//
//// Input & Output Logic
//input logic clk;
//input logic reset_n;
//
//input logic valid;
//input logic [1:0] action;
//
//input logic [63:0] data_in;
//output logic [63:0] data_out;
//
//input logic [1:0] HvecID;
//input logic [HYPERVECTOR_INDEX_BITS-1:0] HvecElem;
//
//output logic done;
//
//
//// Create the memories for use
//logic [HYPERVECTOR_INDEX_BITS-1:0] address_a [0:NUM_MEMORIES-1];
//logic [HYPERVECTOR_INDEX_BITS-1:0] address_b [0:NUM_MEMORIES-1];
//logic [63:0] data_a [0:NUM_MEMORIES-1];
//logic [63:0] data_b [0:NUM_MEMORIES-1];
//logic [NUM_MEMORIES-1:0] rden_a;
//logic [NUM_MEMORIES-1:0] rden_b;
//logic [NUM_MEMORIES-1:0] wren_a;
//logic [NUM_MEMORIES-1:0] wren_b;
//logic [63:0] out_a [0:NUM_MEMORIES-1];
//logic [63:0] out_b [0:NUM_MEMORIES-1];
//
//genvar i;
//generate
//	for (i = 0; i < NUM_MEMORIES; i++) begin : memory_i
//	
//		hypervector_memory #( ADDRESS_BITS(HYPERVECTOR_INDEX_BITS)) hv_memory
//		(
//			.address_a(address_a[i]),
//			.address_b(address_b[i]),
//			.clock(clk),
//			.data_a(data_a[i]),
//			.data_b(data_b[i]),
//			.rden_a(rden_a[i]),
//			.rden_b(rden_b[i]),
//			.wren_a(wren_a[i]),
//			.wren_b(wren_b[i]),
//			.q_a(q_a[i]),
//			.q_b(q_b[i])
//		);
//	
//	end
//endgenerate


endmodule
