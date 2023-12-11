`timescale 1ns/100ps

`include "SimilarityKernelMapper_State.h"

module SimilarityKernelMapper
#(
	parameter HV_DATA_WIDTH	= 32,
	parameter HV_ADDRESS_WIDTH = 20,
	parameter SIM_ADDRESS_WIDTH = 5,
	
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
	simc,
	
	// kernel dpram signals
	we_n,
	address,
	data_wr,
	data_rd,
	
	// sim dpram signals
	s_we_n,
	s_address,
	s_data_wr,
	s_data_rd,
	
	// output control signals
	done
);

input logic clk;
input logic reset_n;

input logic valid;
input logic [HV_ADDRESS_WIDTH-1:0] vec_length;

input logic [HV_ADDRESS_WIDTH-1:0] hva;
input logic [HV_ADDRESS_WIDTH-1:0] hvb;
input logic [SIM_ADDRESS_WIDTH-1:0] simc;

output logic [NUM_PARALLEL_KERNELS-1:0] we_n;
output logic [HV_ADDRESS_WIDTH-1:0] address [0:NUM_PARALLEL_KERNELS-1];
output logic [HV_DATA_WIDTH-1:0] data_wr [0:NUM_PARALLEL_KERNELS-1];
input logic [HV_DATA_WIDTH-1:0] data_rd [0:NUM_PARALLEL_KERNELS-1];

output logic s_we_n;
output logic [SIM_ADDRESS_WIDTH-1:0] s_address;
output logic [SIM_ADDRESS_WIDTH-1:0] s_data_wr;
input logic [SIM_ADDRESS_WIDTH-1:0] s_data_rd;

output logic done;


// Timing for IP

localparam ACCUM_WAIT_CYCLES = 4;
localparam MUL_WAIT_CYCLES = 3;
localparam SQRT_WAIT_CYCLES = 8;
localparam DIV_WAIT_CYCLES = 14;

// Starting offsets for kernels
localparam bit [HV_ADDRESS_WIDTH-1:0] KERNEL_RUN_LENGTH = $ceil(MAX_HYPERVECTOR_LENGTH / NUM_PARALLEL_KERNELS);
localparam bit [HV_ADDRESS_WIDTH-1:0] [NUM_PARALLEL_KERNELS-1:0] KERNEL_START_ADDRESSES = START_CALC();
function bit [HV_ADDRESS_WIDTH-1:0] [NUM_PARALLEL_KERNELS-1:0] START_CALC();
	for (int k = 0; k < NUM_PARALLEL_KERNELS; k++)
		START_CALC[k] = k*KERNEL_RUN_LENGTH;
endfunction
localparam bit [HV_ADDRESS_WIDTH-1:0] [NUM_PARALLEL_KERNELS-1:0] KERNEL_END_ADDRESSES = END_CALC();
function bit [HV_ADDRESS_WIDTH-1:0] [NUM_PARALLEL_KERNELS-1:0] END_CALC();
	for (int k = 0; k < NUM_PARALLEL_KERNELS-1; k++)
		END_CALC[k] = ((k+1)*KERNEL_RUN_LENGTH)-1;
	END_CALC[NUM_PARALLEL_KERNELS-1] = MAX_HYPERVECTOR_LENGTH - 1;
endfunction


// Final sumation parameters

localparam SUMMATION_INDEX_BITS = $clog2(NUM_PARALLEL_KERNELS);


// Final cosine similarity calculations

logic [HV_DATA_WIDTH-1:0] acc_aa;
logic [HV_DATA_WIDTH-1:0] acc_bb;
logic [HV_DATA_WIDTH-1:0] acc_ab;
logic [HV_DATA_WIDTH-1:0] acc_aa_out;
logic [HV_DATA_WIDTH-1:0] acc_bb_out;
logic [HV_DATA_WIDTH-1:0] acc_ab_out;

logic [HV_DATA_WIDTH-1:0] sqrt_a;
logic [HV_DATA_WIDTH-1:0] sqrt_out;

logic [HV_DATA_WIDTH-1:0] mult_a;
logic [HV_DATA_WIDTH-1:0] mult_b;
logic [HV_DATA_WIDTH-1:0] mult_out;

logic [HV_DATA_WIDTH-1:0] div_a;
logic [HV_DATA_WIDTH-1:0] div_b;
logic [HV_DATA_WIDTH-1:0] div_out;

fp_accum fp_accum_aa (
	.clk(clk),
	.areset(~reset_n),
	.acc(acc_pipe_i),
	// 3 cycle latency
	.a(acc_aa),
	.q(acc_aa_out)
);

fp_accum fp_accum_bb (
	.clk(clk),
	.areset(~reset_n),
	.acc(acc_pipe_i),
	// 3 cycle latency
	.a(acc_bb),
	.q(acc_bb_out)
);

fp_accum fp_accum_ab (
	.clk(clk),
	.areset(~reset_n),
	.acc(acc_pipe_i),
	// 3 cycle latency
	.a(acc_ab),
	.q(acc_ab_out)
);

fp_sqrt fp_sqrt (
	.clk(clk),
	.areset(~reset_n),
	// 8 cycle latency
	.a(sqrt_a),
	.q(sqrt_out)
);

fp_mult fp_mult (
	.clk(clk),
	.areset(~reset_n),
	// 3 cycle latency
	.a(mult_a),
	.b(mult_b),
	.q(mult_out)
);

fp_div fp_div (
	.clk(clk),
	.areset(~reset_n),
	// 14 cycle latency
	.a(div_a),
	.b(div_b),
	.q(div_out)
);


// Delay pipes for all result outputs

logic acc_pipe_i;
logic [ACCUM_WAIT_CYCLES-1:0] acc_pipe;

logic AA_sqrt_pipe_i;
logic BB_sqrt_pipe_i;
logic [SQRT_WAIT_CYCLES-1:0] AA_sqrt_pipe;
logic [SQRT_WAIT_CYCLES-1:0] BB_sqrt_pipe;

logic DEN_mult_pipe_i;
logic [MUL_WAIT_CYCLES-1:0] DEN_mult_pipe;

logic SIM_div_pipe_i;
logic [DIV_WAIT_CYCLES-1:0] SIM_div_pipe;


// State

integer k;
MapperBundleKernel_State_t state;


// Combinational logic for accum, sqrt, mult, and div inputs

logic load_acc_pipe;

assign load_acc_pipe = 1'b0; // TODO

logic load_AA_sqrt_pipe;
logic load_BB_sqrt_pipe;

assign load_AA_sqrt_pipe = AA_add_pipe[0];
assign load_BB_sqrt_pipe = BB_add_pipe[0];

logic load_DEN_mult_pipe;
logic load_SIM_div_pipe;

assign load_DEN_mult_pipe = AA_sqrt_pipe[0] & BB_sqrt_pipe[0];
assign load_SIM_div_pipe = DEN_mult_pipe[0];


always_comb begin
	// Default pipe inputs are 0
	acc_pipe_i = 1'b0;
	AA_sqrt_pipe_i = 1'b0;
	BB_sqrt_pipe_i = 1'b0;
	DEN_mult_pipe_i = 1'b0;
	SIM_div_pipe_i = 1'b0;
	
	// Load the adder inputs
	if (load_acc_pipe) begin // All accum's together
		acc_aa = AA_out[summation_index];
		acc_bb = BB_out[summation_index];
		acc_ab = AB_out[summation_index];
		acc_pipe_i = 1'b1;
	end else begin // All 0's
		acc_aa = {HV_DATA_WIDTH{1'b0}};
		acc_bb = {HV_DATA_WIDTH{1'b0}};
		acc_ab = {HV_DATA_WIDTH{1'b0}};
	end
	
	// Load the square root inputs
	if (load_AA_sqrt_pipe) begin // sqrt(AA)
		sqrt_a = acc_aa;
		AA_sqrt_pipe_i = 1'b1;
	end else if (load_BB_sqrt_pipe) begin // sqrt(BB)
		sqrt_a = acc_bb;
		BB_sqrt_pipe_i = 1'b1;
	end else begin // All 0's
		sqrt_a = {HV_DATA_WIDTH{1'b0}};
	end
	
	// Load the multiplier inputs
	if (load_DEN_mult_pipe) begin // sqrt(AA) * sqrt(BB)
		mult_a = AA_res;
		mult_b = BB_res;
		DEN_mult_pipe_i = 1'b1;
	end else begin // All 0's
		mult_a = {HV_DATA_WIDTH{1'b0}};
		mult_b = {HV_DATA_WIDTH{1'b0}};
	end
	
	// Load the divider inputs
	if (load_SIM_div_pipe) begin // Final cosine similarity
		div_a = AB_res;
		div_b = AA_res;
		SIM_div_pipe_i = 1'b1;
	end else begin // All 0's
		div_a = {HV_DATA_WIDTH{1'b0}};
		div_b = {HV_DATA_WIDTH-1{1'b0},1'b1};
	end
end


// Pipe Shifting

always_ff @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		acc_pipe[ACCUM_WAIT_CYCLES-1:0] <= {ACCUM_WAIT_CYCLES{1'b0}};
		AA_sqrt_pipe[SQRT_WAIT_CYCLES-1:0] <= {SQRT_WAIT_CYCLES{1'b0}};
		BB_sqrt_pipe[SQRT_WAIT_CYCLES-1:0] <= {SQRT_WAIT_CYCLES{1'b0}};
		DEN_mult_pipe[MUL_WAIT_CYCLES-1:0] <= {MUL_WAIT_CYCLES{1'b0}};
		SIM_div_pipe[DIV_WAIT_CYCLES-1:0] <= {DIV_WAIT_CYCLES{1'b0}};
	end else begin
		for (k = 0; k < MUL_WAIT_CYCLES-1; k = k + 1) begin
			acc_pipe[i] <= acc_pipe[i+1];		
		end
		acc_pipe[ACCUM_WAIT_CYCLES-1] <= acc_pipe_i;
		for (k = 0; k < SQRT_WAIT_CYCLES-1; k = k + 1) begin
			AA_sqrt_pipe[i] <= AA_sqrt_pipe[i+1];
			BB_sqrt_pipe[i] <= BB_sqrt_pipe[i+1];
		end
		AA_sqrt_pipe[SQRT_WAIT_CYCLES-1] <= AA_sqrt_pipe_i;
		BB_sqrt_pipe[SQRT_WAIT_CYCLES-1] <= BB_sqrt_pipe_i;
		for (k = 0; k < MUL_WAIT_CYCLES-1; k = k + 1) begin
			DEN_mult_pipe[i] <= DEN_mult_pipe[i+1];
		end
		DEN_mult_pipe[MUL_WAIT_CYCLES-1] <= DEN_mult_pipe_i;
		for (k = 0; k < DIV_WAIT_CYCLES-1; k = k + 1) begin
			SIM_div_pipe[i] <= SIM_div_pipe[i+1];
		end
		SIM_div_pipe[DIV_WAIT_CYCLES] <= SIM_div_pipe_i;
	end
end


// Loading results into registers

logic [HV_DATA_WIDTH-1:0] AA_res;
logic [HV_DATA_WIDTH-1:0] BB_res;
logic [HV_DATA_WIDTH-1:0] AB_res;

always_ff @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		AA_res <= {HV_DATA_WIDTH{1'b0}};
		BB_res <= {HV_DATA_WIDTH{1'b0}};
		AB_res <= {HV_DATA_WIDTH{1'b0}};
	end else begin
		if (acc_pipe[0]) begin // Accumulation
			AA_res <= acc_aa_out;
			BB_res <= acc_bb_out;
			AB_res <= acc_ab_out;
		end else begin // sqrt(AA)
			if (AA_sqrt_pipe[0]) begin
				AA_res <= sqrt_out;
			end else if (DEN_mult_pipe[0]) begin
				AA_res <= mult_out;
			end else if (SIM_div_pipe[0]) begin
				AA_res <= div_out;
			end
			if (BB_sqrt_pipe) begin
				BB_res <= sqrt_out;
			end
		end
	end
end


// Setting summation index

logic [SUMMATION_INDEX_BITS-1:0] summation_index;

always_ff @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		summation_index <= {SUMMATION_INDEX_BITS{1'b0}};
	end else begin
		if (final_result_complete) begin
			summation_index <= {SUMMATION_INDEX_BITS{1'b0}};
		end else if (acc_pipe[0]) begin
			summation_index <= summation_index + 1'b1;
		end
	end
end


// Kernel control and data

logic [HV_ADDRESS_WIDTH-1:0] hva_latch;
logic [HV_ADDRESS_WIDTH-1:0] hvb_latch;
logic [HV_ADDRESS_WIDTH-1:0] simc_latch;

logic [NUM_PARALLEL_KERNELS-1:0] k_valid;
logic [NUM_PARALLEL_KERNELS-1:0] k_done;
logic [HV_ADDRESS_WIDTH-1:0] k_hv_start [0:NUM_PARALLEL_KERNELS-1];
logic [HV_ADDRESS_WIDTH-1:0] k_hv_end [0:NUM_PARALLEL_KERNELS-1];

logic all_kernels_complete;
assign all_kernels_complete = &k_done[NUM_PARALLEL_KERNELS-1:0];

logic final_result_complete;
logic begin_final_calculation;

logic [HV_DATA_WIDTH-1:0] AA_out [NUM_PARALLEL_KERNELS-1:0];
logic [HV_DATA_WIDTH-1:0] BB_out [NUM_PARALLEL_KERNELS-1:0];
logic [HV_DATA_WIDTH-1:0] AB_out [NUM_PARALLEL_KERNELS-1:0];


always_ff @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		// module state
		state <= S_IDLE;
		// output
		done <= 1'b1;
		s_we_n <= 1'b1;
		s_address <= {SIM_ADDRESS_WIDTH{1'b0}};
		s_data_wr <= {HV_DATA_WIDTH{1'b0}};
		// internal enables & registers
		vec_length_latch <= {HV_ADDRESS_WIDTH{1'b0}};
		hva_latch <= {HV_ADDRESS_WIDTH{1'b0}};
		hvb_latch <= {HV_ADDRESS_WIDTH{1'b0}};
		simc_latch <= {SIM_ADDRESS_WIDTH{1'b0}};
		summation_index <= {SUMMATION_INDEX_BITS{1'b0}};
		for (k = 0; k < NUM_PARALLEL_KERNELS; k = k + 1) begin
			k_valid[k] <= 1'b0;
			k_offset[k] <= {HV_ADDRESS_WIDTH{1'b0}};
			k_hv_start[k] <= {HV_ADDRESS_WIDTH{1'b0}};
			k_hv_end[k] <= {HV_ADDRESS_WIDTH{1'b0}};
		end
		// internal FSM control
		begin_final_calculation <= 1'b0;
	end else begin
		
		case (state)
		
			S_IDLE:	begin
							done <= 1'b1;
							s_we_n <= 1'b1;
			
							if (valid) begin
								done <= 1'b0;
								
								hva_latch <= hva;
								hvb_latch <= hvb;
								simc_latch <= simc;
								
								for (k = 0; k < NUM_PARALLEL_KERNELS; k = k + 1) begin
									// Check if kernel should be started
									if (KERNEL_START_ADDRESSES[k] < vec_length) begin
										k_valid[k] <= 1'b1;
										hv_start[k] <= KERNEL_START_ADDRESSES[k];
										hv_end[k] <= (vec_length > KERNEL_END_ADDRESSES[k]) ? vec_length - 1'b1 : KERNEL_END_ADDRESSES[k]; 
									end
								end
								
								state <= S_MAP_0;
							end else begin
								state <= S_IDLE;
							end
			
						end
						
			S_MAP_0:	begin
							
							for (k = 0; k < NUM_PARALLEL_KERNELS; k = k + 1) begin
								k_valid[k] <= 1'b0;						
							end

							// Wait for all the kernels to complete
							if (all_kernels_complete) begin
								begin_final_calculation <= 1'b1;
								state <= S_MAP_1;
							end else begin
								state <= S_MAP_0;
							end
			
						end
						
			S_MAP_1: begin
				
							begin_final_calculation <= 1'b0;
				
							// Wait for all results to complete
							if (final_result_complete) begin
								s_we_n <= 1'b0;
								s_address <= simc_latch;
								s_data_wr <= AA_res;
								done <= 1'b1;
								state <= S_IDLE;
							end else begin
								state <= S_MAP_1;
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
