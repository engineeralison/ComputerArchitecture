// 64x32to1 mux takes a 32x64bit input and outputs a 64bit output 
// inputs are select (to pick which in to output) and in
// output is out

`timescale 10ps/1fs
module mux64X32to1 (select, in, out);
	
	input logic [4:0] select;
	input logic [31:0][63:0] in;
	
	output logic [63:0] out;

	logic [63:0][31:0] fixed;
	
	
	// changing to fit a better array size
	int i, j;
	always_comb begin
		for (i = 0; i < 32; i=i+1)
			for (j = 0; j < 64; j=j+1)
				fixed[j][i] = in[i][j];
	end
	
	// creating 64 copies of a 32to1 mux
	genvar k;
	generate 
		for (k=0; k<64; k=k+1) begin : mux32 
			mux32to1 imdonewiththislabalready (select, fixed[k][31:0], out[k]);
		end
	endgenerate
	
endmodule

// 32to1 mux - self explanatory
module mux32to1 (select, in, out);
	
	input logic [4:0] select;
	input logic [31:0] in;
	
	output logic out;
	
	logic [1:0] muxcheck;
	
	mux16to1 a (select[3:0], in[15:0], muxcheck[0]);
	mux16to1 b (select[3:0], in[31:16], muxcheck[1]);
	mux2to1 c (select[4], muxcheck, out);
	
endmodule

// 16to1 mux - self explanatory
module mux16to1 (select, in, out); 
	
	input logic [3:0] select;
	input logic [15:0] in;
	output logic out;
	
	logic [3:0] muxcheck;
	
	mux4to1 a (select[1:0], in[3:0], muxcheck[0]);
	mux4to1 b (select[1:0], in[7:4], muxcheck[1]);
	mux4to1 c (select[1:0], in[11:8], muxcheck[2]);
	mux4to1 d (select[1:0], in[15:12], muxcheck[3]);
	mux4to1 e (select[3:2], muxcheck[3:0], out);
	
endmodule

// 4 to 1 mux - self explanatory
module mux4to1 (select, in, out);
	
	input logic [1:0] select;
	input logic [3:0] in;
	
	output logic out;
	
	logic [3:0] temp;
	logic [1:0] notselect;
	
	not #5 a (notselect[0], select[0]);
	not #5 b (notselect[1], select[1]);
	
	and #5 c (temp[0], in[0], notselect[0], notselect[1]);
	and #5 d (temp[1], in[1], select[0], notselect[1]);
	and #5 e (temp[2], in[2], notselect[0], select[1]);
	and #5 f (temp[3], in[3], select[0], select[1]);
	
	or #5 g (out, temp[0], temp[2], temp[1], temp[3]);
	
endmodule

// 2 to 1 mux - self explanatory
module mux2to1 (select, in, out);
	
	input logic select;
	input logic [1:0] in;
	
	output logic out;
	
	logic [1:0] temp;
	logic notselect;
	
	not #5 d (notselect, select);
	
	and #5 a (temp[0], notselect, in[0]);
	and #5 b (temp[1], in[1], select);
	or #5 c (out, temp[1], temp[0]);
	
endmodule

// 2 to 1 mux, except with different input
// instead of having one 2 bit input,
// this module contains 2 one bit inputs
// used in the input_register module for
module mux2to1v2 (select, in1, in2, out);
	
	input logic select, in1, in2;
	
	output logic out;
	
	logic [1:0] temp;
	logic notselect;
	
	not #5 d (notselect, select);
	
	and #5 a (temp[0], notselect, in1);
	and #5 b (temp[1], in2, select);
	or #5 c (out, temp[1], temp[0]);
	
endmodule
