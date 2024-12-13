`timescale 10ps/1fs
//testbench for decoder module 
module decoder_tb ();

	// define signals
	logic enable;
	logic [4:0] in;
	logic [31:0] select;
	
	// instantiate module
	decoder decode_test (enable, in, select);
	
	
	initial begin
		enable=0;
		in=0;
		#10
		
		// checking output for every combination of 5 bit in input
		for (int i=0; i < 32; i = i+1) begin
			enable = 1;
			in = i;
			#10;
		end
		
		// check enable works for every combination of in input
		for (int i=32; i > 0; i = i-1) begin
			enable = 0;
			in = i;
			#4;
		end
		$stop;
		
	end
endmodule
