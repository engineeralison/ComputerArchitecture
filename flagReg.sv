`timescale 10ps/1fs
module flagReg (clk, reset, en, in, out);
	
	input logic clk, reset, en;
	input logic [3:0] in;
	
	output logic [3:0] out;
	
	logic [3:0] flag;
	
	genvar i;
	generate 
		for (i=0; i<4; i=i+1) begin: flags
			mux2to1_lab2 flagmux (en, out[i], in[i], flag[i]);
			D_FF dff_flag(out[i], flag[i], reset, clk);
		end
	endgenerate 
endmodule
