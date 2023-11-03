`timescale 1ns/100ps

module hdl 
(
clk,

C,
max,
//min,
out
);

input logic [31:0] C;
input logic [31:0] max;
//input logic [31:0] min;
//output logic [31:0] out;

output logic out;
assign out = $signed(C) > $signed(max);

//always_comb begin
//
//	if ($signed(C) > $signed(max)) begin
//		out <= max;
////	end else if ($signed(C) < $signed(min)) begin
////		out <= min;
//	end else begin
//		out <= C;
//	end
//
//end


endmodule
