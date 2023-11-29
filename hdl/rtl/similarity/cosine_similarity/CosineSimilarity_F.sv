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


localparam DIV_WAIT_CYCLES = 14;
localparam SQRT_WAIT_CYCLES = 8;

// Registers for accumulation and results

logic [HV_DATA_WIDTH-1:0] a_latch;
logic [HV_DATA_WIDTH-1:0] b_latch;
logic [HV_DATA_WIDTH-1:0] last_latch;
logic [DIV_WAIT_CYCLES-1:0] mac_wait;

logic [HV_DATA_WIDTH-1:0] AB_accumulate;
logic [HV_DATA_WIDTH-1:0] AA_accumulate;
logic [HV_DATA_WIDTH-1:0] BB_accumulate;

// Wires coming out of or into FP blocks

logic [HV_DATA_WIDTH-1:0] mult_a;
logic [HV_DATA_WIDTH-1:0] mult_b;
logic [HV_DATA_WIDTH-1:0] add_a;
logic [HV_DATA_WIDTH-1:0] sqrt_a;

logic [HV_DATA_WIDTH-1:0] mult_out;
logic [HV_DATA_WIDTH-1:0] add_out;
logic [HV_DATA_WIDTH-1:0] div_out;
logic [HV_DATA_WIDTH-1:0] sqrt_out;

logic [HV_DATA_WIDTH-1:0] AA_sqrt;
logic [HV_DATA_WIDTH-1:0] BB_sqrt;
logic [HV_DATA_WIDTH-1:0] denominator;

logic [HV_DATA_WIDTH-1:0] result;
assign data_out = result;


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

fp_div fp_div (
	.clk(clk),
	.areset(~reset_n),
	// 14 cycle latency
	.a(AB_accumulate),
	.b(mult_out),
	.q(div_out)
);

fp_sqrt fp_sqrt(
	.clk(clk),
	.areset(~reset_n),
	// 8 cycle latency
	.a(sqrt_a),
	.q(sqrt_out)
);


CosineSimilarity_State_t state;
integer i;

always_ff @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
	
	end else begin
	
		for (i = 0; i < DIV_WAIT_CYCLES - 1; i = i + 1) begin
			mac_wait[i] <= mac_wait[i+1];
		end
		mac_wait[DIV_WAIT_CYCLES-1] <= 1'b0;
		
		case (state) 
		
			S_IDLE: 		begin
								done <= 1'b1;
								ready <= 1'b1;
								
								if (valid & first) begin
									// Load the first data into a_latch
									a_latch <= data_in;									
									// we are no longer done (but still ready for data on the next cycle)
									done <= 1'b0;
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
									// we are no longer done (but still ready for data on the next cycle)
									done <= 1'b0;
									// Advance states
									state <= S_DATA_WAIT_1;
								end else begin
									state <= S_DATA_WAIT_0;
								end
		
							end
							
			S_DATA_WAIT_1:	begin
		
								// If we are valid again we can start multiplying
								if (valid) begin
									// disable ready since FP_MULT has latency
									ready <= 1'b0;
									// Load the second data into b_latch
									b_latch <= data_in;
									// latch the last signal so we know later if we're done
									last_latch <= last;
									// calculate B*B
									mult_a <= data_in;
									mult_b <= data_in;
									// advance to multiply state
									state <= S_MAC_0;
								// otherwise we stick around until data is here
								end else begin
									state <= S_DATA_WAIT_1;
								end
		
							end
							
			S_MAC_0:			begin
			
									// calculate A*A
									mult_a <= a_latch;
									mult_b <= a_latch;
			
									// Wait for 2 clock cycles for B*B
									state <= S_MAC_1;
			
								end
								
			S_MAC_1:			begin
			
									// calculate A*B
									mult_a <= a_latch;
									mult_b <= b_latch;
			
									// Wait for 1 clock cycles for B*B
									// Wait for 2 clock cycles for A*A
									state <= S_MAC_2;
			
								end
								
			S_MAC_2:			begin
			
									// Get BB ready for accumulation
									add_a <= BB_accumulate;
			
									// Wait for 0 clock cycles for B*B
									// Wait for 1 clock cycles for A*A
									// Wait for 2 clock cycles for A*B
									state <= S_MAC_3;
			
								end
								
			S_MAC_3:			begin
			
									// Get AA ready for accumulation
									add_a <= AA_accumulate;
									
									// Wait for 0 clock cycles for A*A
									// Wait for 1 clock cycles for A*B
									// Wait for 2 clock cycles for BB+(B*B)
									state <= S_MAC_4;
			
								end
								
			S_MAC_4:			begin
			
									// Get AB ready for accumulation
									add_a <= AB_accumulate;
									
									// Wait for 0 clock cycles for A*B
									// Wait for 1 clock cycles for BB+(B*B)
									// Wait for 2 clock cycles for AA+(A*A)
									state <= S_MAC_5;
			
								end
								
			S_MAC_5:			begin
									
									
									// Wait for 0 clock cycles for BB+(B*B)
									// Wait for 1 clock cycles for AA+(A*A)
									// Wait for 2 clock cycles for AB+(A*B)
									state <= S_MAC_6;
			
								end
								
			S_MAC_6:			begin
									
									BB_accumulate <= add_out;
									if (last_latch) begin
										mac_wait[SQRT_WAIT_CYCLES-1] <= 1'b1;
										sqrt_a <= add_out;
									end
									
									// Wait for 0 clock cycles for AA+(A*A)
									// Wait for 1 clock cycles for AB+(A*B)
									state <= S_MAC_7;
			
								end
								
			S_MAC_7:			begin
									
									AA_accumulate <= add_out;
									if (last_latch) begin
										mac_wait[SQRT_WAIT_CYCLES-1] <= 1'b1;
										sqrt_a <= add_out;
									end
									
									// Wait for 0 clock cycles for AB+(A*B)
									state <= S_MAC_8;
			
								end
								
			S_MAC_8:			begin
									
									AB_accumulate <= add_out;
									
									if (last_latch) begin										
										state <= S_SIM_0;		
									end else begin
										ready <= 1'b1;
										state <= S_DATA_WAIT_0;										
									end
										
								end
								
			S_SIM_0:			begin
			
									// Wait for result of sqrt(BB)
									if (mac_wait[0] == 1'b1) begin
										BB_sqrt <= sqrt_out;
										state <= S_SIM_1;
									end else begin
										state <= S_SIM_0;
									end
			
								end
								
			S_SIM_1:			begin
			
									// Wait for result of sqrt(AA)
									if (mac_wait[0] == 1'b1) begin
										AA_sqrt <= sqrt_out;
										mult_a <= BB_sqrt;
										mult_b <= sqrt_out;
										state <= S_SIM_2;
									end else begin
										state <= S_SIM_0;
									end
			
								end
								
			S_SIM_2:			begin
			
									// Wait for 2 clock cycles for sqrt(AA)*sqrt(BB)
									state <= S_SIM_3;
			
								end
								
			S_SIM_3:			begin
			
									// Wait for 1 clock cycles for sqrt(AA)*sqrt(BB)
									state <= S_SIM_4;
			
								end
			
			S_SIM_4:			begin
			
									// Wait for 0 clock cycles for sqrt(AA)*sqrt(BB)
									state <= S_SIM_5;
			
								end
								
			S_SIM_5:			begin
				
									// Load counter for division
									mac_wait[DIV_WAIT_CYCLES-1] <= 1'b1;
									
									state <= S_SIM_6;
			
								end
								
			S_SIM_6:			begin
			
									// Wait for result of sqrt(AA)
									if (mac_wait[0] == 1'b1) begin
										done <= 1'b1;
										ready <= 1'b1;
										result <= div_out;
										state <=	S_IDLE;
									end
			
								end
		
		endcase
		
	end
end

endmodule
