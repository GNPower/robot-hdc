`timescale 1ns/100ps

`ifndef DISABLE_DEFAULT_NET
`default_nettype none
`endif

// This module emulates the simple DP_RAM device during simulation
// Data is read out in a single clock cycle
module dpRamEmulator 
#(
	parameter HV_DATA_WIDTH	= 32,
	parameter HV_ADDRESS_WIDTH = 21
)
(
	clk,
	reset_n,
	
	we_n,
	address,
	data_i,
	data_o
);

input logic clk;
input logic reset_n;
input logic we_n;
input logic [HV_ADDRESS_WIDTH-1:0] address;
input logic [HV_DATA_WIDTH-1:0] data_i;
output logic [HV_DATA_WIDTH-1:0] data_o;

localparam DPRAM_SIZE = 2**HV_ADDRESS_WIDTH; //2097152; // 2^21

logic [HV_DATA_WIDTH-1:0] DPRAM_data [DPRAM_SIZE-1:0];

integer i;

always_ff @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		data_o <= 32'd0;
		for (i = 0; i < DPRAM_SIZE; i = i + 1) 
			DPRAM_data[i] <= 32'd0;
	end else begin
		data_o <= DPRAM_data[address];
		if (!we_n) begin
			DPRAM_data[address] <= data_i;
		end
	end
end

endmodule
