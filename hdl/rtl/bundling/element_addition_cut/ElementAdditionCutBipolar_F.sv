`timescale 1ns/100ps

`include "ElementAdditionCutBipolar_State.h"

module ElementAdditionCutBipolar_F
#(
	parameter HYPERVECTOR_DIMENSIONS = 1000,
	parameter NUM_KERNELS = 1,

	parameter CUT_NEG = -1,
	parameter CUT_POS = 1
)
(
	// clock and reset signals
	clk,
	reset_n,
	
	// address control signals
	valid,
	addr_a,
	addr_b,
	addr_c,
	
	// memory interface
	we_n,
	waddress,
	data_wr,
	raddress,
	data_rd,
	
	// signals when done
	done
);

input logic clk;
input logic reset_n;

input logic valid;
input logic [20:0] addr_a;
input logic [20:0] addr_b;
input logic [20:0] addr_c;

logic [31:0] data_a_latch;
logic [20:0] addr_b_latch;
logic [20:0] addr_c_latch;

output logic we_n;
output logic [20:0] waddress;
output logic [31:0] data_wr;
output logic [20:0] raddress;
input logic [31:0] data_rd;

logic add_en;
logic comp_en;
logic c_leq_max;
logic c_leq_min;

logic [31:0] adder_out;
assign data_wr = c_leq_max ? (c_leq_min ? CUT_NEG : adder_out ) : CUT_POS;
output logic done; 


fp_add fp_add_inst (
	.clk(clk),
	.areset(~reset_n),
	.en(add_en),
	
	.a(data_a_latch),
	.b(data_rd),
	.q(adder_out)
);

fp_compare c_leq_max_inst (
	.clk(clk),
	.areset(~reset_n),
	.en(comp_en),
	.a(adder_out),
	.b(CUT_POS),
	.q(c_leq_max)
);

fp_compare c_leq_min_inst (
	.clk(clk),
	.areset(~reset_n),
	.en(comp_en),
	.a(adder_out),
	.b(CUT_NEG),
	.q(c_leq_min)
);


ElemAdd_State_t state;

always_ff @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		// module state
		state <= S_IDLE;
		// output and intermediate signal reset
		done <= 1'b0;
		add_en <= 1'b0;
		comp_en <= 1'b0;
		// memory control reset
		we_n <= 1'b1;
		waddress <= 21'd0;
		raddress <= 21'd0;
		// latches for old data
		data_a_latch <= 32'd0;
		addr_b_latch <= 21'd0;
		addr_c_latch <= 21'd0;
	end else begin
		
		case (state)
		
			S_IDLE:			begin
									we_n <= 1'b1;
									
									if (valid) begin
										// Save addr_b for later cycle									
										addr_b_latch <= addr_b;
										addr_c_latch <= addr_c;
										// Make memory request for element A
										raddress <= addr_a;
										// Advance states
										state <= S_DATA_WAIT_0;
									end else begin
										state <= S_IDLE;
									end
									
								end
							
			S_DATA_WAIT_0:	begin
				
									// element A is ready, latch it for later
									data_a_latch <= data_rd;
									// Request the second element address
									raddress <= addr_b_latch;								
									// The data will be on the line in the next clock cycle,
									// so we need to get the FP Adder ready to add
									add_en <= 1'b1;
									state <= S_FPADD_0;
			
								end
						
			S_FPADD_0:		begin
			
									// disable, since the data is already in
									add_en <= 1'b0;
									// Wait for 3 clock cycles
									state <= S_FPADD_1;			
								end
							
			S_FPADD_1:		begin
			
									// Wait for 2 clock cycles
									state <= S_FPADD_2;
				
								end
							
			S_FPADD_2:		begin
			
									// Wait for 1 clock cycles
									state <= S_COMP;
				
								end
								
			S_COMP:			begin
			
									// Add data is ready, compare for cut
									comp_en <= 1'b1;
									state <= S_DATA_RDY;
				
								end
							
			S_DATA_RDY:		begin
			
									// Output is ready, write it to the memory
									comp_en <= 1'b0;
									waddress <= addr_c_latch;
									we_n <= 1'b0;
									done <= 1'b1;								
				
								end
		
		endcase
				
	end
end

endmodule
