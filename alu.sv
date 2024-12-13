// Matthew Nochi
// 10/26/2023
// ECE 469 
// Lab 2

// This is an alu that takes 2 64 bit inputs and a control signal
// and outputs a resulting alu function based on the control signal

// the inputs are A and B (64 bit inputs), cntrl (control signal), 
// and the outputs are results (64 bit output), negative (whether 
// the output is negative), zero (if the output is zero), overflow 
// (if there is overflow) and carry_out (the resulting carry of an add 
// or subtract)

`timescale 10ps/1fs
module alu (A, B, cntrl, result, negative, zero, overflow, carry_out);
	
	input logic [63:0] A, B;
	input logic [2:0] cntrl;
	
	output logic [63:0] result;
	output logic negative, zero, overflow, carry_out;
	
	// logic for every carry bit
	logic [63:0] alu_carry;
	
	assign negative = result[63];
	assign carry_out = alu_carry[63];
	
	// first bit is different because the previous carry comes from 
	// the control signal
	alu1bit firstbit (cntrl, A[0], B[0], cntrl[0], alu_carry[0], result[0]);
	
	genvar i;
	generate 
		for (i = 1; i<64; i=i+1) begin: alubits
			alu1bit plswork (cntrl, A[i], B[i], alu_carry[i-1], alu_carry[i], result[i]);
		end
	endgenerate
	
	// overflow found by comparing the last two carries
	xor #5 overflo (overflow, carry_out, alu_carry[62]);
	
	// checking for zeros
	test_zero test00 (result, zero);
	
endmodule 


