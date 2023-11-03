`timescale 1ns/100ps

`include "ElementAdditionCitBipolar_State.h"

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

output logic we_n;
output logic [20:0] waddress;
output logic [31:0] data_wr;
output logic [20:0] raddress;
input logic [31:0] data_rd;

output logic done;

logic [20:0] addr_b_latch;

logic [31:0] mac;
logic [31:0] mac_a;
logic en;


fp_add fp_add_inst (
	.clk(clk),
	.areset(~reset_n),
	.en(en),
	
	.a(mac),
	.b(data_rd),
	.q(mac_a)
);

ElemAdd_State_t state;

always_ff @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		// output and intermediate signal reset
		done <= 1'b0;
		en <= 1'b0;
		mac <= 32'd0;
		// memory control reset
		we_n <= 1'b1;
		waddress <= 21'd0;
		data_wr <= 32'd0;
		raddress <= 21'd0;
	end else begin
		mac <= mac;
		
		case (state)
		
			S_IDLE:		begin
								
								if (valid) begin
									// Save addr_b for later cycle									
									addr_b_latch <= addr_b;
									// Make memory request for element A
									raddress <= addr_a;
									// Advance states
									state <= S_FPADD_0;
								end else begin
									state <= S_IDLE;
								end
								
							end
						
			S_FPADD_0:	begin
			
								// element A is ready, send to FP_ADD
								en <= 1'b1;
								// Wait for 3 clock cycles
								state <= S_FPADD_1;
			
							end
							
			S_FPADD_1:	begin
			
								en <= 1'b0;
								// Wait for 2 clock cycles
								state <= S_FPADD_2;
			
							end
							
			S_FPADD_2:	begin
			
								// Wait for 1 clock cycles
								state <= S_FPADD_3;
			
							end
							
			S_FPADD_3:	begin
			
								// Mac output is ready
								state <= S_FPADD_3;
			
							end
		
		endcase
		
		
	end
end

endmodule
