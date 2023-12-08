`timescale 1ns/100ps

`include "CosineSimilarity_State.h"

module CosineSimilarity_F
#(
	parameter HV_DATA_WIDTH	= 32
)
(
	// clock and reset signals
	clk,
	reset_n,
	
	// address control signals
	valid,
	first,
	last,
	
	// data
	data_in,
	AA_out,
	BB_out,
	AB_out,
	
	// output control signals
	ready,
	done
);

input logic clk;
input logic reset_n;

input logic valid;
input logic first;
input logic last;

input logic [HV_DATA_WIDTH-1:0] data_in;
output logic [HV_DATA_WIDTH-1:0] AA_out;
output logic [HV_DATA_WIDTH-1:0] BB_out;
output logic [HV_DATA_WIDTH-1:0] AB_out;

output logic ready;
output logic done;


localparam ADD_WAIT_CYCLES = 3;
localparam MUL_WAIT_CYCLES = 3;


// State

CosineSimilarity_State_t state;


// Registers for accumulation and results

logic [HV_DATA_WIDTH-1:0] a_latch;
logic [HV_DATA_WIDTH-1:0] b_latch;
logic [HV_DATA_WIDTH-1:0] last_latch;

logic [HV_DATA_WIDTH-1:0] AB_accumulate;
logic [HV_DATA_WIDTH-1:0] AA_accumulate;
logic [HV_DATA_WIDTH-1:0] BB_accumulate;

assign AB_out = AB_accumulate;
assign AA_out = AA_accumulate;
assign BB_out = BB_accumulate;

// Wires coming out of or into FP blocks

logic [HV_DATA_WIDTH-1:0] mult_a;
logic [HV_DATA_WIDTH-1:0] mult_b;
logic [HV_DATA_WIDTH-1:0] add_a;

logic [HV_DATA_WIDTH-1:0] mult_out;
logic [HV_DATA_WIDTH-1:0] add_out;


fp_mult fp_mult (
	.clk(clk),
	.areset(~reset_n),
	// 3 cycle latency
	.a(mult_a),
	.b(mult_b),
	.q(mult_out)
);

fp_add fp_add (
	.clk(clk),
	.areset(~reset_n),
	// 3 cycle latency
	.a(add_a),
	.b(mult_out),
	.q(add_out)
);


// Delay pipes for all result outputs

logic AB_mul_pipe_i;
logic AA_mul_pipe_i;
logic BB_mul_pipe_i;
logic [MUL_WAIT_CYCLES-1:0] AB_mul_pipe;
logic [MUL_WAIT_CYCLES-1:0] AA_mul_pipe;
logic [MUL_WAIT_CYCLES-1:0] BB_mul_pipe;

logic AB_add_pipe_i;
logic AA_add_pipe_i;
logic BB_add_pipe_i;
logic [ADD_WAIT_CYCLES-1:0] AB_add_pipe;
logic [ADD_WAIT_CYCLES-1:0] AA_add_pipe;
logic [ADD_WAIT_CYCLES-1:0] BB_add_pipe;


// Combinational logic for loading the multiplier and adder inputs

logic load_AA_mul_pipe;
logic load_BB_mul_pipe;
logic load_AB_mul_pipe;

assign load_AA_mul_pipe = ((state == S_DATA_WAIT_0) | (state == S_IDLE)) & valid;
assign load_BB_mul_pipe = (state == S_DATA_WAIT_1) & valid;
assign load_AB_mul_pipe = (state == S_DATA_WAIT_2) & BB_mul_pipe[MUL_WAIT_CYCLES - 1];

logic load_AA_add_pipe;
logic load_BB_add_pipe;
logic load_AB_add_pipe;

assign load_AA_add_pipe = AA_mul_pipe[0];
assign load_BB_add_pipe = BB_mul_pipe[0];
assign load_AB_add_pipe = AB_mul_pipe[0];


always_comb begin
	// Default pipe inputs are 0
	AA_mul_pipe_i = 1'b0;
	BB_mul_pipe_i = 1'b0;
	AB_mul_pipe_i = 1'b0;
	AA_add_pipe_i = 1'b0;
	BB_add_pipe_i = 1'b0;
	AB_add_pipe_i = 1'b0;

	// Load the multiplier inputs
	if (load_AA_mul_pipe) begin // AA
		mult_a = data_in;
		mult_b = data_in;
		AA_mul_pipe_i = 1'b1;
	end else if (load_BB_mul_pipe) begin // BB
		mult_a = data_in;
		mult_b = data_in;
		BB_mul_pipe_i = 1'b1;
	end else if (load_AB_mul_pipe) begin // AB
		mult_a = a_latch;
		mult_b = b_latch;
		AB_mul_pipe_i = 1'b1;
	end else begin // All 0's
		mult_a = {HV_DATA_WIDTH{1'b0}};
		mult_b = {HV_DATA_WIDTH{1'b0}};
	end
	
	// Load the adder inputs
	if (load_AA_add_pipe) begin // sum(AA)
		add_a = AA_accumulate;
		AA_add_pipe_i = 1'b1;
	end else if (load_BB_add_pipe) begin // sum(BB)
		add_a = BB_accumulate;
		BB_add_pipe_i = 1'b1;
	end else if (load_AB_add_pipe) begin // sum(AB)
		add_a = AB_accumulate;
		AB_add_pipe_i = 1'b1;
	end else begin // All 0's
		add_a = {HV_DATA_WIDTH{1'b0}};
	end
	
end


// Pipe Shifting

integer i;
always_ff @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		// All pipes
		AB_mul_pipe[MUL_WAIT_CYCLES-1:0] <= {MUL_WAIT_CYCLES{1'b0}};
		AA_mul_pipe[MUL_WAIT_CYCLES-1:0] <= {MUL_WAIT_CYCLES{1'b0}};
		BB_mul_pipe[MUL_WAIT_CYCLES-1:0] <= {MUL_WAIT_CYCLES{1'b0}};
		AB_add_pipe[ADD_WAIT_CYCLES-1:0] <= {ADD_WAIT_CYCLES{1'b0}};
		AA_add_pipe[ADD_WAIT_CYCLES-1:0] <= {ADD_WAIT_CYCLES{1'b0}};
		BB_add_pipe[ADD_WAIT_CYCLES-1:0] <= {ADD_WAIT_CYCLES{1'b0}};
	end else begin
		for (i = 0; i < MUL_WAIT_CYCLES-1; i = i + 1) begin
			AB_mul_pipe[i] <= AB_mul_pipe[i+1];
			AA_mul_pipe[i] <= AA_mul_pipe[i+1];
			BB_mul_pipe[i] <= BB_mul_pipe[i+1];			
		end
		AB_mul_pipe[MUL_WAIT_CYCLES-1] <= AB_mul_pipe_i;
		AA_mul_pipe[MUL_WAIT_CYCLES-1] <= AA_mul_pipe_i;
		BB_mul_pipe[MUL_WAIT_CYCLES-1] <= BB_mul_pipe_i;
		for (i = 0; i < ADD_WAIT_CYCLES-1; i = i + 1) begin
			AB_add_pipe[i] <= AB_add_pipe[i+1];
			AA_add_pipe[i] <= AA_add_pipe[i+1];
			BB_add_pipe[i] <= BB_add_pipe[i+1];
		end
		AB_add_pipe[ADD_WAIT_CYCLES-1] <= AB_add_pipe_i;
		AA_add_pipe[ADD_WAIT_CYCLES-1] <= AA_add_pipe_i;
		BB_add_pipe[ADD_WAIT_CYCLES-1] <= BB_add_pipe_i;
	end
end


// Loading results into registers

always_ff @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		AA_accumulate <= {HV_DATA_WIDTH{1'b0}};
		BB_accumulate <= {HV_DATA_WIDTH{1'b0}};
		AB_accumulate <= {HV_DATA_WIDTH{1'b0}};
	end else begin
		if (AA_add_pipe[0]) begin // AA
			AA_accumulate <= add_out;
		end
		if (BB_add_pipe[0]) begin // BB
			BB_accumulate <= add_out;
		end
		if (AB_add_pipe[0]) begin // AB
			AB_accumulate <= add_out;
		end
	end
end


// Data latching and external facing FSM

always_ff @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		// module state
		state <= S_IDLE;
		// output
		done <= 1'b0;
		ready <= 1'b0;
		// data latches
		last_latch <= 1'b0;
		a_latch <= {HV_DATA_WIDTH{1'b0}};
		b_latch <= {HV_DATA_WIDTH{1'b0}};
	end else begin

		case (state) 

			S_IDLE: 			begin
									done <= 1'b1;
									ready <= 1'b1;
									last_latch <= 1'b0;
									
									if (valid & first) begin
										// Load the first data into a_latch
										a_latch <= data_in;
										// we are no longer done (but still ready for data on the next cycle)
										done <= 1'b0;
										// latch the last signal if this is the lest element
										if (last) begin
											last_latch <= 1'b1;
										end
										// Advance states
										state <= S_DATA_WAIT_1;
									end else begin
										state <= S_IDLE;
									end

								end
							
			S_DATA_WAIT_0:	begin
									
									if (valid) begin
										// Load the first data into a_latch
										a_latch <= data_in;
										// latch the last signal if this is the lest element
										if (last) begin
											last_latch <= 1'b1;
										end
										// Advance states
										state <= S_DATA_WAIT_1;
									end else begin
										state <= S_DATA_WAIT_0;
									end
									
								end
								
			S_DATA_WAIT_1:	begin
									
									if (valid) begin
										// Load the first data into a_latch
										b_latch <= data_in;
										// We are no longer ready
										ready <= 1'b0;
										// latch the last signal if this is the lest element
										if (last) begin
											last_latch <= 1'b1;
										end
										// Advance states
										state <= S_DATA_WAIT_2;
									end else begin
										state <= S_DATA_WAIT_1;
									end
									
								end
								
			S_DATA_WAIT_2:	begin
			
									// AB pipe is the last addition to complete before results are ready
									if (AB_add_pipe[0]) begin
										// Indicate we are ready for the next inputs
										ready <= 1'b1;
										// If we are done go to idle, otherwise continue waiting for inputs
										if (last_latch) begin
											done <= 1'b1;
											state <= S_IDLE;
										end else begin
											state <= S_DATA_WAIT_0;
										end
									end else begin
										state <= S_DATA_WAIT_2;
									end
			
								end
		
		endcase
		
	end
end

endmodule
