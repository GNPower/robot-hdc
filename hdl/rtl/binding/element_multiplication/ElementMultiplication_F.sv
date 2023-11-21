`timescale 1ns/100ps

`include "ElementMultiplication_State.h"

module ElementMultiplication_F
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

logic [HV_DATA_WIDTH-1:0] a_latch;
logic [HV_DATA_WIDTH-1:0] partial_result;

logic [HV_DATA_WIDTH-1:0] mult_out;

assign data_out = partial_result;

fp_mult fp_mult_inst (
	.clk(clk),
	.areset(~reset_n),
	
	.a(a_latch),
	.b(data_in),
	.q(mult_out)
);


ElemMult_State_t state;

always_ff @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		// module state
		state <= S_IDLE;
		// output
		done <= 1'b0;
		ready <= 1'b0;
		// multiplier
		a_latch <= {HV_DATA_WIDTH{1'b0}};
		partial_result <= {HV_DATA_WIDTH{1'b0}};
	end else begin
	
		case(state)
		
			S_IDLE:			begin
									done <= 1'b1;
									ready <= 1'b1;
									
									if (valid & first) begin
										// Load the first data into a_latch
										a_latch <= data_in;
										// we are no longer done (but still ready for data on the next cycle)
										done <= 1'b0;
										// Advance states
										state <= S_DATA_WAIT_0;
									end else begin
										state <= S_IDLE;
									end
				
								end
						
			S_DATA_WAIT_0:	begin
			
									// If we are valid again we can start multiplying
									if (valid & last) begin
										// disable ready since FP_MULT has latency
										ready <= 1'b0;
										// advance to multiply state
										state <= S_FPMULT_0;
									// otherwise we stick around until data is here
									end else begin
										state <= S_DATA_WAIT_0;
									end
			
								end
								
			S_FPMULT_0:		begin
			
									// Wait for 1 clock cycles
									state <= S_FPMULT_1;
			
								end
								
			S_FPMULT_1:		begin
			
									// Wait for 0 clock cycles
									state <= S_FPMULT_2;
			
								end
								
			S_FPMULT_1:		begin
			
									// Mult data is ready, send it to the result register
									partial_result <= mult_out;
									
									done <= 1'b1;
									ready <= 1'b1;
									
									state <= S_IDLE;
			
								end
			
		endcase
	
	end
end

endmodule
