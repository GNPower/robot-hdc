`timescale 1ns/100ps

module BindKernelGenerator
#(
	parameter HV_DATA_WIDTH	= 32,
	parameter HV_ADDRESS_WIDTH = 20,
	
	/*******************************
	 * 
	 * SELECT THE TYPE OF BUNDLE KERNEL TO GENERATE
	 *
	 * 1 = ElementMultiplication_F
	 *
	 *******************************/
	parameter KERNEL_TO_GENERATE = 1
)
(
	//////////////////////////////
	// SIGNALS FROM KERNEL MAPPER
	//////////////////////////////

	// clock and reset signals
	clk,
	reset_n,
	
	// address control signals
	valid,
	
	// hypervector address components
	hva,
	hvb,
	hvc,
	hv_offset,
	
	// dpram signals
	we_n,
	address,
	data_wr,
	data_rd,
	
	// output control signals
	done
);

input logic clk;
input logic reset_n;

input logic valid;

input logic [HV_ADDRESS_WIDTH-1:0] hva;
input logic [HV_ADDRESS_WIDTH-1:0] hvb;
input logic [HV_ADDRESS_WIDTH-1:0] hvc;
input logic [HV_ADDRESS_WIDTH-1:0] hv_offset;

output logic we_n;
output logic [HV_ADDRESS_WIDTH-1:0] address;
output logic [HV_DATA_WIDTH-1:0] data_wr;
input logic [HV_DATA_WIDTH-1:0] data_rd;

output logic done;



logic k_valid;
logic k_first;
logic k_last;

logic [HV_DATA_WIDTH-1:0] k_data_in;
logic [HV_DATA_WIDTH-1:0] k_data_out;

logic k_ready;
logic k_done;


// Generate the Memory Mapper
generate
	
	// 1 = ElementMultiplication_F
	if (KERNEL_TO_GENERATE == 1) begin : MemMap
	
		BindDirectMapper
		#(
			.HV_DATA_WIDTH(HV_DATA_WIDTH),
			.HV_ADDRESS_WIDTH(HV_ADDRESS_WIDTH)
		)
		MemoryMapper_Inst
		(			
			.clk(clk),
			.reset_n(reset_n),
			.valid(valid),
			.hva(hva),
			.hvb(hvb),
			.hvc(hvc),
			.hv_offset(hv_offset),
			.we_n(we_n),
			.address(address),
			.data_wr(data_wr),
			.data_rd(data_rd),
			.done(done),

			.k_valid(k_valid),
			.k_first(k_first),
			.k_last(k_last),
			.k_data_in(k_data_in),
			.k_data_out(k_data_out),
			.k_ready(k_ready),
			.k_done(k_done)
		);
	
	end
	
endgenerate


// Generate the Kernel
generate
	
	// 1 = ElementMultiplication_F
	if (KERNEL_TO_GENERATE == 1) begin : Kernel
	
		ElementMultiplication_F
		#(
			.HV_DATA_WIDTH(HV_DATA_WIDTH)
		)
		Kernel_Inst
		(
			.clk(clk),
			.reset_n(reset_n),
			.valid(k_valid),
			.first(k_first),
			.last(k_last),
			.data_in(k_data_in),
			.data_out(k_data_out),
			.ready(k_ready),
			.done(k_done)
		);
	
	end
	
endgenerate


endmodule
