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
	logic [20:0] addr_c;
	wire done;
	
	ElementAdditionCutBipolar_F
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
		.addr_c(addr_c),
		
		.we_n(write_enable_n),
		.waddress(write_address),
		.data_wr(data_i),
		.raddress(read_address),
		.data_rd(data_o),
		
		.done(done)
	);

	
	always begin
		#(CLOCK_PERIOD_NS/2);
		clock = ~clock;
	end
	
	initial begin
		// Initialize clock and reset
		$timeformat(-6, 2, "us", 10);
		clock = 1'b1;
		reset_n = 1'b0;
		// Initialize all other logic		
		valid = 1'b0;
		addr_a = 21'd0;
		addr_b = 21'd1024;
		addr_c = 21'd2048;		
		// Raise reset_n after 2 clocks
		#(CLOCK_PERIOD_NS);
		reset_n = 1'b1;
		// Set the initial memory
		for (int i = 0; i < 2097152; i++)
			emulated_DPRAM.DPRAM_data[i] = 32'd25;
		// Start the UUT by setting valid
		valid = 1'b1;
		
		#500
		
		$stop;
	end

endmodule
