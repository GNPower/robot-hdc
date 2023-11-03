//`timescale 1ns/100ps
//
//module CosineSimilarity_U
//#(
//	parameter ELEMENT_WIDTH = 64,
//	parameter NUM_ELEMENTS = 10
//)
//(
//	clk,
//	reset_n,
//	
//	valid,
//	A,
//	B,
//	
//	done,
//	SmodA,
//	SmodB,
//	Sdot
//);
//
//input logic clk;
//input logic reset_n;
//
//input logic valid;
//input logic [] A;
//input logic [] B;
//
//output logic done;
//output logic [] SmodA;
//output logic [] SmodB;
//output logic [] Sdot;
//
//always_ff @(poesdge clk or negedge reset_n) begin
//	if(!reset_n) begin
//		done <= 1'b0;
//		SmodA <= {{1'b0}};
//		SmodB <= {{1'b0}};
//		Sdot <= {{1'b0}};
//	end else begin
//		
//	end
//end
//
//endmodule
