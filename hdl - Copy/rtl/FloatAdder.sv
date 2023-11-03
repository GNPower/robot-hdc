`timescale 1ns/100ps

// Reference:
// https://people.ece.cornell.edu/land/courses/ece5760/FloatingPoint/index.html
// https://people.ece.cornell.edu/land/courses/ece5760/StudentWork/ss868/fp/Reg27FP/FpAdd.v

module FloatAdder
#(
	parameter EXPONENT_WIDTH = 8,
	parameter MANTISSA_WIDTH = 23
)
(
	clk,
	
	A,
	B,
	
	Sum
);

// Input/Output signals
input logic clk;
input logic [EXPONENT_WIDTH+MANTISSA_WIDTH:0] A;
input logic [EXPONENT_WIDTH+MANTISSA_WIDTH:0] B;
output logic [EXPONENT_WIDTH+MANTISSA_WIDTH:0] Sum;

// Extract fields of A and B. Construct Sum
logic A_sign;
logic [EXPONENT_WIDTH-1:0] A_exponent;
logic [MANTISSA_WIDTH-1:0] A_mantissa;
logic B_sign;
logic [EXPONENT_WIDTH-1:0] B_exponent;
logic [MANTISSA_WIDTH-1:0] B_mantissa;
logic S_sign;
logic [EXPONENT_WIDTH-1:0] S_exponent;
logic [MANTISSA_WIDTH-1:0] S_mantissa;

assign {A_sign, A_exponent, A_mantissa} = A;
assign {B_sign, B_exponent, B_mantissa} = A;
assign Sum = {S_sign, S_exponent, S_mantissa};




endmodule
