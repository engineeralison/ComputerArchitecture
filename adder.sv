// adder takes two one bit inputs and a carry and adds them 
// all together. It produces an output and a carry 

`timescale 10ps/1fs
module adder (a, b, out, Cin, Cout);
	
	input logic a, b, Cin;
	output logic Cout, out;
	
	logic [2:0] temp;
	
	xor #5 ab (temp[0], a, b);
	and #5 cd (temp[1], a, b);
	xor #5 ef (out, Cin, temp[0]);
	and #5 gh (temp[2], Cin, temp[0]);
	or #5 ij (Cout, temp[2], temp[1]);
	
endmodule

module adder_tb();
	
	logic a, b, out, Cin, Cout;
	
	adder test (a, b, out, Cin, Cout);
	
	integer i;
	
	initial begin
		
		for (i=0; i<10; i=i+1) begin
			a=i; b=(i-1); Cin=i; 
			#30;
		end
		$stop;
	end
endmodule 