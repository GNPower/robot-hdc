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
	data_out,
	
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
output logic [HV_DATA_WIDTH-1:0] data_out;

output logic ready;
output logic done;

logic [HV_DATA_WIDTH-1:0] AB_mult_out;
logic [HV_DATA_WIDTH-1:0] AA_mult_out;
logic [HV_DATA_WIDTH-1:0] BB_mult_out;
logic [HV_DATA_WIDTH-1:0] AB_add_out;
logic [HV_DATA_WIDTH-1:0] AA_add_out;
logic [HV_DATA_WIDTH-1:0] BB_add_out;
logic [HV_DATA_WIDTH-1:0] AB_accumulate;
logic [HV_DATA_WIDTH-1:0] AA_accumulate;
logic [HV_DATA_WIDTH-1:0] BB_accumulate;

logic [HV_DATA_WIDTH-1:0] AA_sqrt;
logic [HV_DATA_WIDTH-1:0] BB_sqrt;
logic [HV_DATA_WIDTH-1:0] denominator;

logic [HV_DATA_WIDTH-1:0] result;

fp_mult fp_mult_AB (
	.clk(clk),
	.areset(~reset_n),
	
	.a(a_latch),
	.b(data_in),
	.q(AB_mult_out)
);

fp_mult fp_mult_AA (
	.clk(clk),
	.areset(~reset_n),
	
	.a(a_latch),
	.b(a_latch),
	.q(AA_mult_out)
);

fp_mult fp_mult_BB (
	.clk(clk),
	.areset(~reset_n),
	
	.a(data_in),
	.b(data_in),
	.q(BB_mult_out)
);

fp_add fp_add_AB (
	.clk(clk),
	.areset(~reset_n),
	
	.a(AB_mult_out),
	.b(AB_accumulate),
	.q(AB_add_out)
);

fp_add fp_add_AA (
	.clk(clk),
	.areset(~reset_n),
	
	.a(AA_mult_out),
	.b(AA_accumulate),
	.q(AA_add_out)
);

fp_add fp_add_BB (
	.clk(clk),
	.areset(~reset_n),
	
	.a(BB_mult_out),
	.b(BB_accumulate),
	.q(BB_add_out)
);


CosineSim_State_t state;

always_ff @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
	
	end else begin
		
		case (state):
		
			S_IDLE: 	begin
			
							
			
						end
		
		endcase
		
	end
end

endmodule
