`timescale 10ps/1fs
module adder64bit (in1, in2, out);
	
	input logic [63:0] in1, in2;
	
	output logic [63:0] out; 
	
	logic [63:0] Cout;
	
	adder firstbit (in1[0], in2[0], out[0], 1'b0, Cout[0]);
	
	genvar i;
	generate
		for (i = 1; i<64; i=i+1) begin: adder1
			adder bits (in1[i], in2[i], out[i], Cout[i-1], Cout[i]);
		end
	endgenerate 
	
	
endmodule

module adder64bit_tb ();
	
	logic [63:0] in1, in2, out;
	
	adder64bit dut (in1, in2, out);
	
	initial begin
		in1 = 64'h0000123FAAAA0009; in2 = 64'h0001123412341234; #100; // out should be 00012473BCDE123D
		in1 = 64'h000000000000FFFF; in2 = 64'h000000000000FFFF; #100; //out should be 000000000001FFFE
	end
endmodule 