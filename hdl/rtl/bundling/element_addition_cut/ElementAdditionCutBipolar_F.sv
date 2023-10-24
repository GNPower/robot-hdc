`timescale 1ns/100ps

module ElementAdditionCutBiploar_F
#(
	parameter EXPONENT_WIDTH = 8,
	parameter MANTISSA_WIDTH = 23,
	
	parameter CUT_ABS = 1
)
(
	clk,
	reset_n,
	
	valid,
	elem_in,
	
	elem_out
);

input logic clk;
input logic reset_n;

input logic valid;
input logic [EXPONENT_WIDTH+MANTISSA_WIDTH:0] elem_in;

output logic [EXPONENT_WIDTH+MANTISSA_WIDTH:0] elem_out;


logic sign_in;
logic [EXPONENT_WIDTH-1:0] exponent_in;
logic [MANTISSA_WIDTH-1:0] mantissa_in;

logic sign_out;
logic [EXPONENT_WIDTH-1:0] exponent_out;
logic [MANTISSA_WIDTH-1:0] mantissa_out;

assign {sign_in, exponent_in, mantissa_in} = elem_in;
assign elem_out = {sign_out, exponent_out, mantissa_out};


always_ff @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		sign_out = 1'b0;
		exponent_out = {EXPONENT_WIDTH{1'b0}};
		mantissa_out = {MANTISSA_WIDTH{1'b0}};
	end else begin
	
	end
end

endmodule
