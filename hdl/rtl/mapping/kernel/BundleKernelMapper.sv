`timescale 1ns/100ps

`include "BundleKernelMapper_State.h"

module BundleKernelMapper
#(
	parameter HV_DATA_WIDTH	= 32,
	parameter HV_ADDRESS_WIDTH = 20,
	
	parameter MAX_HYPERVECTOR_LENGTH = 4,
	parameter NUM_PARALLEL_KERNELS = 4,
	
	/*******************************
	 * 
	 * SELECT THE TYPE OF BUNDLE KERNEL TO GENERATE
	 *
	 * 1 = ElementAdditionCutBipolar_F
	 *
	 *******************************/
	parameter KERNEL_TO_GENERATE = 1
)
(
	// clock and reset signals
	clk,
	reset_n,
	
	// address and control signals
	valid,
	vec_length,
	
	// hypervector address components
	hva,
	hvb,
	hvc,
	
	// bundling mode (0 = A&B, 1 = A->B)
	mode,
	
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
input logic [HV_ADDRESS_WIDTH-1:0] vec_length;

input logic [HV_ADDRESS_WIDTH-1:0] hva;
input logic [HV_ADDRESS_WIDTH-1:0] hvb;
input logic [HV_ADDRESS_WIDTH-1:0] hvc;

input logic mode;

output logic [NUM_PARALLEL_KERNELS-1:0] we_n;
output logic [HV_ADDRESS_WIDTH-1:0] address [0:NUM_PARALLEL_KERNELS-1];
output logic [HV_DATA_WIDTH-1:0] data_wr [0:NUM_PARALLEL_KERNELS-1];
input logic [HV_DATA_WIDTH-1:0] data_rd [0:NUM_PARALLEL_KERNELS-1];

output logic done;


logic [HV_ADDRESS_WIDTH-1:0] group_offset;
logic [HV_ADDRESS_WIDTH-1:0] hva_latch;
logic [HV_ADDRESS_WIDTH-1:0] hvb_latch;
logic [HV_ADDRESS_WIDTH-1:0] hvc_latch;
logic mode_latch;


logic [NUM_PARALLEL_KERNELS-1:0] k_valid;
logic [NUM_PARALLEL_KERNELS-1:0] k_done;
logic [HV_ADDRESS_WIDTH-1:0] k_offset [0:NUM_PARALLEL_KERNELS-1];

logic all_kernels_complete;
assign all_kernels_complete = &k_done[NUM_PARALLEL_KERNELS-1:0];

integer k;
MapperBundleKernel_State_t state;

always_ff @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		// module state
		state <= S_IDLE;
		// output
		done <= 1'b1;
		// internal enables & registers
		group_offset <= {HV_ADDRESS_WIDTH{1'b0}};
		hva_latch <= {HV_ADDRESS_WIDTH{1'b0}};
		hvb_latch <= {HV_ADDRESS_WIDTH{1'b0}};
		hvc_latch <= {HV_ADDRESS_WIDTH{1'b0}};
		mode_latch <= 1'b0;
		for (k = 0; k < NUM_PARALLEL_KERNELS; k = k + 1) begin
			k_valid[k] <= 1'b0;
			k_offset[k] <= {HV_ADDRESS_WIDTH{1'b0}};
		end
	end else begin
		
		case (state)
		
			S_IDLE:	begin
							done <= 1'b1;
			
							if (valid) begin
								done <= 1'b0;
								
								group_offset <= vec_length;
								hva_latch <= hva;
								hvb_latch <= hvb;
								hvc_latch <= hvc;
								mode_latch <= mode;
								
								if (vec_length < NUM_PARALLEL_KERNELS) begin
									state <= S_MAP_3;
								end else begin
									state <= S_MAP_0;
								end								
								
							end
			
						end
						
			S_MAP_0:	begin
			
							// Set a single group of kernels to compute
							for (k = 0; k < NUM_PARALLEL_KERNELS; k = k + 1) begin
								k_valid[k] <= 1'b1;
								k_offset[k] <= group_offset - k - 1'b1;
							end
							
							group_offset <= group_offset - NUM_PARALLEL_KERNELS;
							state <= S_MAP_1;
			
						end
						
			S_MAP_1:	begin
							
							for (k = 0; k < NUM_PARALLEL_KERNELS; k = k + 1) begin
								k_valid[k] <= 1'b0;						
							end

							state <= S_MAP_2;
			
						end
						
			S_MAP_2: begin
				
							// Wait for all the kernels to complete
							if (all_kernels_complete) begin
								if (group_offset >= NUM_PARALLEL_KERNELS) begin
									state <= S_MAP_0;
								end else if (group_offset > 0) begin
									state <= S_MAP_3;
								end else begin
									done <= 1'b1;
									state <= S_IDLE;
								end
							end
			
						end
						
			S_MAP_3:	begin
			
							// Set the remaining few kernels off
							for (k = 0; k < NUM_PARALLEL_KERNELS; k = k + 1) begin
								if (group_offset > k) begin
									k_valid[k] <= 1'b1;
									k_offset[k] <= k;
								end
							end
							
							group_offset <= 0;
							state <= S_MAP_4;
			
						end
						
			S_MAP_4:	begin
			
							for (k = 0; k < NUM_PARALLEL_KERNELS; k = k + 1) begin
								k_valid[k] <= 1'b0;						
							end

							state <= S_MAP_5;
			
						end
						
			S_MAP_5:	begin
			
							for (k = 0; k < NUM_PARALLEL_KERNELS; k = k + 1) begin
								k_valid[k] <= 1'b0;						
							end
							
							// Wait for all the kernels to complete
							if (all_kernels_complete) begin
								done <= 1'b1;
								state <= S_IDLE;
							end
			
						end	
						
		endcase	
		
	end
end


genvar i;

generate
	for (i = 0; i < NUM_PARALLEL_KERNELS; i = i + 1) begin : KernelNum
	
		BundleKernelGenerator
		#(
			.HV_DATA_WIDTH(HV_DATA_WIDTH),
			.HV_ADDRESS_WIDTH(HV_ADDRESS_WIDTH),
			
			.KERNEL_TO_GENERATE(KERNEL_TO_GENERATE)
		)
		KernelGen_Inst
		(
			.clk(clk),
			.reset_n(reset_n),
			
			.valid(k_valid[i]),
			
			.hva(hva_latch),
			.hvb(hvb_latch),
			.hvc(hvc_latch),
			
			.hv_offset(k_offset[i]),
			
			.mode(mode_latch),

			.we_n(we_n[i]),
			.address(address[i]),
			.data_wr(data_wr[i]),
			.data_rd(data_rd[i]),
			
			.done(k_done[i])
		);
	
	end
endgenerate

endmodule
