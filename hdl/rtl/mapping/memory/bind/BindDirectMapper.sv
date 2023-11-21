`timescale 1ns/100ps

`include "BundleLinearMapper_State.h"

module BindDirectMapper
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


logic [HV_DATA_WIDTH-1:0] buff;

assign k_valid = (
						(state == S_MAPB_1) |
						((state == S_MAPB_2) & k_ready) |
						((state == S_WRITE_0) & k_ready & ~k_done)
						) ? 1'b1 : 1'b0;
assign k_first = (state == S_MAPB_1) ? 1'b1 : 1'b0;
assign k_last =  (
						((state == S_MAPB_2) & k_ready) |
						((state == S_WRITE_0) & k_ready & ~k_done)
						) : 1'b1 : 1'b0;
assign k_data_in = (state == S_MAPB_1 | state == S_MAPB_2) ? data_rd : buff;


MapperBindDirect_State_t state;

always_ff @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		// module state
		state <= S_IDLE;
		// output
		done <= 1'b1;
		we_n <= 1'b1;
		address <= {HV_ADDRESS_WIDTH{1'b1}};
		data_wr <= {HV_DATA_WIDTH{1'b0}};
		// internal enables
		k_valid <= 1'b0;
		k_first <= 1'b0;
		k_last <= 1'b0;
		// internal registers
		buff_loaded <= 1'b0;
		buff <= {HV_DATA_WIDTH{1'b0}};
	end else begin
	
		case (state)
		
			S_IDLE:	begin
							we_n <= 1'b1;
							done <= 1'b1;
							buf_loaded <= 1'b0;
							
							if (valid & k_ready) begin
								// request the first address from memory (HVA[offset])
								address <= hva + hv_offset;
								we_n <= 1'b1;
								
								// advance to the next mode
								state <= S_MAPB_0;
							end else begin
								state <= S_IDLE;
							end
							
						end
							
			S_MAPB_0:begin
			
							// request the next address from memory (HVB[offset])
							address <= hvb + hv_offset;
							we_n <= 1'b1;
							
							// Delay 1 cycle for memory read
							state <= S_MAPA_1;
							
						end
						
			S_MAPB_1:begin
							
							// HVA[offset] is ready, but it will be passed directly to the kernel (i.e. read this cycle)
							
							// Delay 0 cycle for memory read
							state <= S_MAPB_2;
			
						end
						
			S_MAPB_2:begin
			
							// HVB[offset] is ready this cycle, buffer it
							buff <= data_rd;
							
							state <= S_WRITE_0;
			
						end
						
			S_WRITE_0:begin
			
							// Wait until kernel is done to write
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
