`timescale 1ns/100ps

`include "BundleLinearMapper_State.h"

module BundleLinearMapper
#(
	parameter HV_DATA_WIDTH	= 32,
	parameter HV_ADDRESS_WIDTH = 20,
	
	parameter MAX_HYPERVECTOR_LENGTH = 4
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
	
	// bundling mode (0 = A&B, 1 = A->B)
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
output logic k_valid;
output logic k_first;
output logic k_last;

// data
output logic [HV_DATA_WIDTH-1:0] k_data_in;
input logic [HV_DATA_WIDTH-1:0] k_data_out;

// output control signals
input logic k_ready;
input logic k_done;



logic buff_loaded;
logic [HV_DATA_WIDTH-1:0] buff;

logic [HV_ADDRESS_WIDTH-1:0] addr_counter;

assign k_valid 	= k_ready & buff_loaded;
assign k_first 	= k_valid & (addr_counter == 0);
assign k_last 		= k_valid & (hva + addr_counter == hvb);
assign k_data_in 	= buff;


MapperBundleLinear_State_t state;

always_ff @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		// module state
		state <= S_IDLE;
		// output
		done <= 1'b1;
		we_n <= 1'b1;
		address <= {HV_ADDRESS_WIDTH{1'b1}};
		data_wr <= {HV_DATA_WIDTH{1'b0}};
		// internal enables
		// internal registers
		buff_loaded <= 1'b0;
		buff <= {HV_DATA_WIDTH{1'b0}};
		addr_counter <= {HV_ADDRESS_WIDTH{1'b0}};
	end else begin
	
		case(state)
		
			S_IDLE:	begin
							we_n <= 1'b1;
							done <= 1'b1;
							buff_loaded <= 1'b0;
							
							if(valid & k_ready) begin
								done <= 1'b0;
								// request the first address from memory (HVA[offset])
								address <= hva + hv_offset;
								we_n <= 1'b1;
								
								// advance to the next mode
								if (mode) begin
									// We are bundling all A->B
									addr_counter <= 1'b0;
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
							
							// request the next address from memory (HVA[offset]+1)
							address <= hva + hv_offset + addr_counter + MAX_HYPERVECTOR_LENGTH; // OLD:  hva + hv_offset + addr_counter + 1'b1
							we_n <= 1'b1;
							
							// Delay 1 cycle for memory read
							state <= S_MAPA_1;
			
						end
						
			S_MAPA_1:	begin
			
							// HVA[offset] is ready, buffer it
							buff <= data_rd;
							buff_loaded <= 1'b1;
							
							// Delay 0 cycle for memory read
							state <= S_MAPA_2;
			
						end
						
			S_MAPA_2:	begin
			
							// Kernel is ready and HVA[offset]+addr_counter is being read this cycle
							if (k_valid) begin
								buff <= data_rd;
								buff_loaded <= 1'b0;
								// increment addr_counter
								addr_counter <= addr_counter + MAX_HYPERVECTOR_LENGTH; // OLD: addr_counter + 1'b1
								if (addr_counter == (hvb - hva)) begin
									buff_loaded <= 1'b0;
									state <= S_WRITE_0;
								end else begin
									state <= S_MAPA_0;
								end								
							end else begin
								state <= S_MAPA_2;
							end
			
						end
						
			S_MAPB_0:	begin
			
							// request the final address from memory (HVB[offset])
							address <= hvb + hv_offset;
							we_n <= 1'b1;							
							
							// Delay 1 cycle for memory read
							state <= S_MAPB_1;
			
						end
						
			S_MAPB_1:	begin
							
							// set addr_counter to 0 so k_first is asserted next cycle
							addr_counter <= 0;
							// HVA[offset] is ready, buffer it
							buff <= data_rd;
							buff_loaded <= 1'b1;
							
							// Delay 0 cycle for memory read
							state <= S_MAPB_2;
				
						end
						
			S_MAPB_2:	begin
			
							// Kernel is ready and HVA[offset] is being read this cycle
							if (k_valid) begin
								buff <= data_rd;
								buff_loaded <= 1'b1;
								// increment addr_counter so k_last is asserted next cycle
								addr_counter <= hvb - hva;
								state <= S_MAPB_3;
							end else begin
								state <= S_MAPB_2;
							end
			
						end
						
			S_MAPB_3:	begin
			
							// Kernel is ready and HVB[offset] is being read this cycle
							if (k_valid) begin
								buff_loaded <= 1'b0;
								state <= S_WRITE_0;
							end else begin
								state <= S_MAPB_2;
							end
			
						end
						
			S_WRITE_0:	begin
			
							if (k_done) begin
								address <= hvc + hv_offset;
								data_wr <= k_data_out;
								we_n <= 1'b0;
								done <= 1'b1;
								state <= S_IDLE;
							end
			
						end
		
		endcase
		
	end
end


endmodule
