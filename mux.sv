// mux2to1 takes two inputs and produces one output
// with a control signal

`timescale 10ps/1fs
module mux2to1_lab2 (select, in1, in2, out);
	
	input logic select, in1, in2;
	
	output logic out;
	
	logic [2:0] temp;
	
	not #5 d (temp[2], select);
	and #5 a (temp[0], temp[2], in1);
	and #5 b (temp[1], in2, select);
	or #5 c (out, temp[1], temp[0]);
	
endmodule

// mux8to1 takes 8 inputs and produces one output
// with a 3 bit control signal
module mux8to1_lab2 (select, in, out);
	
	input logic [2:0] select;
	input logic [7:0] in;
	
	output logic out;
	
	logic temp[10:0];
	
	not #5 a (temp[0], select[0]);
	not #5 b (temp[1], select[1]);
	not #5 c (temp[2], select[2]);
	
	and #5 d (temp[3], temp[2], temp[1], temp[0], in[0]);
	and #5 e (temp[4], temp[2], temp[1], select[0], in[1]);
	and #5 f (temp[5], temp[2], select[1], temp[0], in[2]);
	and #5 g (temp[6], temp[2], select[1], select[0], in[3]);
	and #5 h (temp[7], select[2], temp[1], temp[0], in[4]);
	and #5 i (temp[8], select[2], temp[1], select[0], in[5]);
	and #5 j (temp[9], select[2], select[1], temp[0], in[6]);
	and #5 k (temp[10], select[2], select[1], select[0], in[7]);
	
	or #5 l (out, temp[3], temp[4], temp[5], temp[6], temp[7], temp[8], temp[9], temp[10]);
	
endmodule 