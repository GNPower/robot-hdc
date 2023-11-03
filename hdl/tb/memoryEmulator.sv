`timescale 1ns/100ps

`ifndef DISABLE_DEFAULT_NET
`default_nettype none
`endif

// This module emulates the simple DP_RAM device during simulation
// Data is read out in a single clock cycle
module dpRamEmulator (
	clk,
	reset_n,
	
	we_n,
	waddress,
	data_i,
	
	raddress,
	data_o
);

input logic clk;
input logic reset_n;
input logic we_n;
input logic [20:0] waddress;
input logic [31:0] data_i;
input logic [20:0] raddress;
output logic [31:0] data_o;

localparam DPRAM_SIZE = 2097152; // 2^21

logic [31:0] DPRAM_data [DPRAM_SIZE-1:0];

integer i;

always_ff @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		data_o <= 32'd0;
		for (i = 0; i < DPRAM_SIZE; i = i + 1) 
			DPRAM_data[i] <= 32'd0;
	end else begin
		data_o <= DPRAM_data[raddress];
		if (!we_n) begin
			DPRAM_data[waddress] <= data_i;
		end
	end
end

endmodule
