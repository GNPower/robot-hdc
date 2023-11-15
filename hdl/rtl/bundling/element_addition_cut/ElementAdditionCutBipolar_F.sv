`timescale 1ns/100ps

`include "ElementAdditionCutBipolar_State.h"

module ElementAdditionCutBipolar_F
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


logic [HV_DATA_WIDTH-1:0] accumulate;


logic add_en;
logic comp_en;
logic c_leq_max;
logic c_leq_min;

logic [31:0] adder_out;


assign data_out = c_leq_max ? (c_leq_min ? CUT_NEG : accumulate ) : CUT_POS;


fp_add fp_add_inst (
	.clk(clk),
	.areset(~reset_n),
	.en(add_en),
	
	.a(data_in),
	.b(accumulate),
	.q(adder_out)
);

fp_compare c_leq_max_inst (
	.clk(clk),
	.areset(~reset_n),
	.en(comp_en),
	
	.a(accumulate),
	.b(CUT_POS),
	.q(c_leq_max)
);

fp_compare c_leq_min_inst (
	.clk(clk),
	.areset(~reset_n),
	.en(comp_en),
	
	.a(accumulate),
	.b(CUT_NEG),
	.q(c_leq_min)
);


ElemAdd_State_t state;

always_ff @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		// module state
		state <= S_IDLE;
		// output
		done <= 1'b0;
		ready <= 1'b1;
		// internal enables
		comp_en <= 1'b0;
		add_en <= 1'b0;
		// accumulator
		accumulate <= {HV_DATA_WIDTH{1'b0}};		
	end else begin
		
		case (state)
		
			S_IDLE:			begin
									done <= 1'b1;
									ready <= 1'b1;
									
									if (valid) begin
										// Load the first data directly into the register								
										accumulate <= data_in;
										// we are no longer done (but still ready for data on the next cycle)
										done <= 1'b0;
										// add_en goes high early so we can catch the next bit of data
										add_en <= 1'b1;
										// Advance states
										state <= S_DATA_WAIT_0;
									end else begin
										state <= S_IDLE;
									end
									
								end
							
			S_DATA_WAIT_0:	begin
				
									// If we are valid again we can start accumulating
									if (valid) begin
										// we've caught the data this cycle so we don't need add_en anymore
										add_en <= 1'b0;
										// disable ready since FP_ADD has latency
										ready <= 1'b0;
										// advance to accumulate state
										state <= S_FPADD_0;
									// otherwise we stick around until data is here
									end else begin
										state <= S_DATA_WAIT_0;
									end
			
								end
						
			S_FPADD_0:		begin
			
									// Wait for 3 clock cycles
									state <= S_FPADD_1;
									
								end
							
			S_FPADD_1:		begin
			
									// Wait for 2 clock cycles
									state <= S_FPADD_2;
				
								end
							
			S_FPADD_2:		begin
			
									// Wait for 1 clock cycles						
									state <= S_ACCUM;
				
								end
								
			S_ACCUM:			begin
			
									// Add data is ready, send it to the accumulator
									accumulate <= adder_out;
									// If this was the last data, move to the output state
									if (last) begin
										// Start the cut comparison
										comp_en <= 1'b1;
										// Move to comparison state
										state <= S_COMP;
									end else begin
										// Indicate we're done with this add and are ready for the next
										ready <= 1'b1;
										// add_en goes high early so we can catch the next bit of data
										add_en <= 1'b1;
										// Move back to waiting for new data
										state <= S_DATA_WAIT_0;
									end									
													
								end
							
			S_COMP:			begin
			
									// Output is ready, go back to idle and wait to start again
									comp_en <= 1'b0;
									done <= 1'b1;
									ready <= 1'b1;
									
									state <= S_IDLE;
				
								end
		
		endcase
				
	end
end

endmodule
