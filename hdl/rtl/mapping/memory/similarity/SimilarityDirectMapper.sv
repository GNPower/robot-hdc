`timescale 1ns/100ps

`include "SimilarityDirectMapper_State.h"

module SimilarityDirectMapper
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
	hv_start,
	hv_end,
	
	// dpram signals
	we_n,
	address,
	data_rd,
	
	// output control signals
	done,
	AA_out,
	BB_out,
	AB_out,
	
	//////////////////////////////
	// SIGNALS TO BUNDLE KERNEL
	//////////////////////////////
	
	// address control signals
	k_valid,
	k_first,
	k_last,
	
	// data
	k_data_in,
	k_AA_out,
	k_BB_out,
	k_AB_out,
	
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
input logic [HV_ADDRESS_WIDTH-1:0] hv_start;
input logic [HV_ADDRESS_WIDTH-1:0] hv_end;

output logic we_n;
output logic [HV_ADDRESS_WIDTH-1:0] address;
input logic [HV_DATA_WIDTH-1:0] data_rd;

output logic [HV_DATA_WIDTH-1:0] AA_out;
output logic [HV_DATA_WIDTH-1:0] BB_out;
output logic [HV_DATA_WIDTH-1:0] AB_out;

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
input logic [HV_DATA_WIDTH-1:0] k_AA_out;
input logic [HV_DATA_WIDTH-1:0] k_BB_out;
input logic [HV_DATA_WIDTH-1:0] k_AB_out;

// output control signals
input logic k_ready;
input logic k_done;


assign we_n = 1'b1;
assign AA_out = k_AA_out;
assign BB_out = k_BB_out;
assign AB_out = k_AB_out;

logic [HV_DATA_WIDTH-1:0] buff;
logic buff_loaded;

logic [HV_ADDRESS_WIDTH-1:0] addr_counter;
logic [HV_ADDRESS_WIDTH-1:0] hva_addr;
logic [HV_ADDRESS_WIDTH-1:0] hvb_addr;
logic [HV_ADDRESS_WIDTH-1:0] hvb_last;

assign hva_addr = hva + hv_start + addr_counter;
assign hvb_addr = hvb + hv_start + addr_counter;
assign hvb_last = hvb + hv_end;


MapperSimilarityDirect_State_t state;


assign k_valid = ((
						(state == S_MAPA_2) |
						(state == S_MAPA_3) |
						(state == S_MAPA_4)) & k_ready
						) ? 1'b1 : 1'b0;
assign k_first = ((state == S_MAPA_2) & ~|addr_counter) ? 1'b1 : 1'b0;
assign k_last = ((state == S_MAPA_4) & (hvb_addr == hvb_last)) ? 1'b1 : 1'b0;
assign k_data_in = buff_loaded ? buff : data_rd;


always_ff @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		// module state
		state <= S_IDLE;
		// output
		done <= 1'b1;
		address <= {HV_ADDRESS_WIDTH{1'b1}};
		// internal registers
		buff <= {HV_DATA_WIDTH{1'b0}};
		buff_loaded <= 1'b0;
		addr_counter <= {HV_ADDRESS_WIDTH{1'b0}};
	end else begin
	
		case (state)
		
			S_IDLE:	begin
							done <= 1'b1;
							addr_counter <= {HV_ADDRESS_WIDTH{1'b0}};
							buff_loaded <= 1'b0;
							
							if (valid & k_ready) begin
								done <= 1'b0;
								// request the first address from memory (HVA[offset])
								address <= hva_addr;								
								// advance to the next mode
								state <= S_MAPA_1;
							end else begin
								state <= S_IDLE;
							end
							
						end
						
			S_MAPA_0:begin
			
							// request the next address A from memory (HVA[offset]+i)
							address <= hva_addr;							
							state <= S_MAPA_1;
							
						end
						
			S_MAPA_1:begin
			
							// request the next address B from memory (HVB[offset]+i)
							address <= hvb_addr;
							state <= S_MAPA_2;														
			
						end
						
			S_MAPA_2:begin										
							
							// Kernel is ready and HVA[offset] is being read this cycle
							if (k_valid) begin
								// No need to buffer HVA since it will be used directly
								state <= S_MAPA_4;
							end else begin
								// (HVA[offset]) is ready, buffer it
								buff <= data_rd;
								buff_loaded <= 1'b1;
								state <= S_MAPA_3;
							end
			
						end
						
			S_MAPA_3:begin
			
							// Kernel is ready and HVA[offset] is being read this cycle
							if (k_valid) begin																
								// Advance to the next state
								buff_loaded <= 1'b0;
								state <= S_MAPA_4;
							end else begin
								state <= S_MAPA_3;
							end
			
						end
						
			S_MAPA_4:begin
							
							// Kernel is ready and HVB[offset] is being read this cycle
							if (k_valid) begin
								if (hvb_addr == hvb_last) begin
									state <= S_DATA_WAIT_0;
								end else begin
									addr_counter <= addr_counter + 1'b1;
									state <= S_MAPA_0;
								end
							end else begin
								state <= S_MAPA_4;
							end
			
						end
						
			S_DATA_WAIT_0:	begin
			
							if (k_done) begin
								done <= 1'b1;
								state <= S_IDLE;
							end else begin
								state <= S_DATA_WAIT_0;
							end
			
						end
						
		endcase
	
	end
end

endmodule
