`timescale 1ns/100ps

module ElementAdditionCutBipolar_F
#(	
	parameter HYPERVECTOR_DIMENSIONS = 1000,
	parameter NUM_KERNELS = 1,

	parameter CUT_NEG = -1,
	parameter CUT_POS = 1
)
(
	// clock and reset signals
	clk,
	reset_n,
	
	// address control signals
	valid,
	addr_a,
	addr_b,
	
	// memory interface
	we_n,
	waddress,
	data_wr,
	raddress,
	data_rd,
	
	// signals when done
	done
);


input logic clk;
input logic reset_n;

input logic valid;
input logic [20:0] addr_a;
input logic [20:0] addr_b;

output logic we_n;
output logic [20:0] waddress;
output logic [31:0] data_wr;
output logic [20:0] raddress;
input logic [31:0] data_rd;

output logic done;


localparam DIMENSIONS_TO_CALCULATE = (HYPERVECTOR_DIMENSIONS + NUM_KERNELS - 1) / NUM_KERNELS;


logic [31:0] mac;

logic [31:0] d_one = 32'b00111111100000000000000000000000;
logic [31:0] d_two = 32'b01000000000000000000000000000000;


fp_add_sub fp_add_inst (
	.add_sub(1'b1),
	.clock(clk),
	.dataa(d_one),
	.datab(d_two),
	.result(mac)
);

always_ff @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		// output and intermediate signal reset
		done <= 1'b0;
		// memory control reset
		we_n <= 1'b1;
		waddress <= 21'd0;
		data_wr <= 32'd0;
		raddress <= 21'd0;
	end else begin
		
	end
end

endmodule
