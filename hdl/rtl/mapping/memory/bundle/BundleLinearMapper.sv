`timescale 1ns/100ps

`include "BundleLinearMapper_State.h"

module BundleLinearMapper
#(
	parameter HV_DATA_WIDTH	= 32,
	parameter HV_ADDRESS_WIDTH = 20
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
	
	// bundling mode
	mode,
	
	// dpram signals
	we_n,
	address,
	data_wr,
	data_rd,
	
	// output control signals
	done,
	
	//////////////////////////////
	// SIGNALS TO BUNDLE KERNEL
	//////////////////////////////
	
	// address control signals
	k_valid,
	k_first,
	k_last,
	
	// data
	k_data_in,
	k_data_out,
	
	// output control signals
	k_ready,
	k_done
);

//////////////////////////////
// SIGNALS FROM KERNEL MAPPER
//////////////////////////////

input logic clk;
input logic reset_n;

input logic valid;

input logic [HV_ADDRESS_WIDTH-1:0] hva;
input logic [HV_ADDRESS_WIDTH-1:0] hvb;
input logic [HV_ADDRESS_WIDTH-1:0] hvc;
input logic [HV_ADDRESS_WIDTH-1:0] hv_offset;

input logic mode;

output logic we_n;
output logic [HV_ADDRESS_WIDTH-1:0] address;
output logic [HV_DATA_WIDTH-1:0] data_wr;
input logic [HV_DATA_WIDTH-1:0] data_rd;

output logic done;

//////////////////////////////
// SIGNALS TO BUNDLE KERNEL
//////////////////////////////

// address control signals
output k_valid;
output k_first;
output k_last;

// data
output [HV_DATA_WIDTH-1:0] k_data_in;
input [HV_DATA_WIDTH-1:0] k_data_out;

// output control signals
input k_ready;
input k_done;




logic [HV_DATA_WIDTH-1:0] buff1;
//logic [HV_DATA_WIDTH-1:0] buff2;
assign k_data_in = buff1;

logic [HV_ADDRESS_WIDTH-1:0] addr_counter;


MapperBundleLinear_State_t state;

always_ff @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		// module state
		state <= S_IDLE;
		// output
		done <= 1'b0;
		we_n <= 1'b1;
		address <= {HV_ADDRESS_WIDTH{1'b0}};
		data_wr <= {HV_DATA_WIDTH{1'b0}};
		// internal enables
		// internal registers
		buff1 <= {HV_DATA_WIDTH{1'b0}};
//		buff2 <= {HV_DATA_WIDTH{1'b0}};
		addr_counter <= {HV_ADDRESS_WIDTH{1'b0}};
	end else begin
	
		case(state)
		
			S_IDLE:	begin
							done <= 1'b1;
							
							if(valid) begin
								done <= 1'b0;
								// request the first address from memory (HVA[offset])
								address <= hva + hv_offset;
								we_n <= 1'b1;
								
								// advence to the next mode
								if (mode) begin
									// We are bundling all A->B
									state <= S_MAPA_0;
								end else begin
									// We are just bundling A&B
									state <= S_MAPB_0;
								end
								
							end else begin
								state <= S_IDLE;
							end
							
			
						end
						
			S_MAPA_0:	begin
			
							
			
						end
						
			S_MAPB_0:	begin
			
							// request the final address from memory (HVB[offset])
							address <= hvb + hv_offset;
							we_n <= 1'b1;
							// HVA[offset] is ready, buffer it
							buff1 <= data_rd;
							// signal to bundle kernel we are  ready
							k_valid <= 1'b1;
							k_first <= 1'b1;
							
							state <= S_MAPB_1;
			
						end
						
			S_MAPB_1:	begin
							k_first <= 1'b0;
							
							// HVB[offset] is ready, buffer it
							buff1 <= data_rd;
							
							if (k_ready) begin
								k_valid <= 1'b1;
								k_last <= 1'b1;
								state <= S_WRITE_0;
							end else begin
								k_valid <= 1'b0;
								state <= S_MAPB_2;
							end
							
				
						end
						
			S_MAPB_2:	begin
			
							if (k_ready) begin
								k_valid <= 1'b1;
								k_last <= 1'b1;
								state <= S_WRITE_0;
							end
			
						end
						
			S_WRITE_0:	begin
			
							if (k_done) begin
								address <= hvc + hv_offset;
								data_wr <= k_data_out;
								done <= 1'b1;
								state <= S_IDLE;
							end
			
						end
		
		endcase
		
	end
end


endmodule
