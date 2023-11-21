`timescale 1ns/100ps

`ifndef DISABLE_DEFAULT_NET
`default_nettype none
`endif

// This module emulates the simple DP_RAM device during simulation
// Data is read out in a single clock cycle
module dpRamEmulatorInfPorts
#(
	parameter HV_DATA_WIDTH	= 32,
	parameter HV_ADDRESS_WIDTH = 21,
	
	parameter NUM_PORTS = 1
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
input logic [NUM_PORTS-1:0] we_n;
input logic [HV_ADDRESS_WIDTH-1:0] address [0:NUM_PORTS-1];
input logic [HV_DATA_WIDTH-1:0] data_i [0:NUM_PORTS-1];
output logic [HV_DATA_WIDTH-1:0] data_o [0:NUM_PORTS-1];

localparam DPRAM_SIZE = 2**HV_ADDRESS_WIDTH; //2097152; // 2^21

logic [HV_DATA_WIDTH-1:0] DPRAM_data [DPRAM_SIZE-1:0];

integer i, k;

always_ff @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		for (k = 0; k < NUM_PORTS; k = k + 1) 
			data_o[k] <= 32'd0;
		for (i = 0; i < DPRAM_SIZE; i = i + 1) 
			DPRAM_data[i] <= 32'd0;
	end else begin
		for (k = 0; k < NUM_PORTS; k = k + 1) begin
			data_o[k] <= DPRAM_data[address[k]];
			if (!we_n[k]) begin
				DPRAM_data[address[k]] <= data_i[k];
			end
		end
	end
end

endmodule
