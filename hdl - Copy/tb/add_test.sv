`timescale 1ns/100ps
`default_nettype none

`include "./test_data.h"

// the top module of the testbench
module AddTestSim;

	localparam CLOCK_PERIOD_NS = 20;

	logic clock;
	logic reset_n;

	wire write_enable_n;
	wire [20:0] write_address;
	wire [31:0] data_i;
	
	wire [20:0] read_address;
	wire [31:0] data_o;
	

	dpRamEmulator emulated_DPRAM(
		.clk(clock),
		.reset_n(reset_n),
		
		.we_n(write_enable_n),
		.waddress(write_address),
		.data_i(data_i),
		
		.raddress(read_address),
		.data_o(data_o)
	);
	
	logic valid;
	logic [20:0] addr_a;
	logic [20:0] addr_b;
	wire done;
	
	ElementAdditionCutBiploar_F
	#(	
		.HYPERVECTOR_DIMENSIONS(1000),
		.NUM_KERNELS(1),

		.CUT_NEG(-1),
		.CUT_POS(1)
	)
	UUT
	(
		.clk(clock),
		.reset_n(reset_n),
		.valid(valid),
		.addr_a(addr_a),
		.addr_b(addr_b),
		.we_n(write_enable_n),
		.waddress(write_address),
		.data_wr(data_i),
		.raddress(read_address),
		.data_rd(data_o),
		.done(done)
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
	
	always begin
		#(CLOCK_PERIOD_NS/2);
		clock = ~clock;
	end
	
	initial begin
		// Initialize clock and reset
		$timeformat(-6, 2, "us", 10);
		clock = 1'b0;
		reset_n = 1'b1;
		// Initialize all other logic		
		valid = 1'b0;
		addr_a = 21'd0;
		addr_b = 21'd1024;
		// Set the initial memory
		for (int i = 0; i < 2097152; i++)
			emulated_DPRAM.DPRAM_data[i] = 32'd25;
		// Read out the memory to check
		
		$stop;
	end

endmodule
