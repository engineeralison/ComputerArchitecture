`timescale 10ps/1fs
//testbench for input_register module 
module input_register_tb ();
	
	// define signals
	logic clk, select;
	logic [63:0] data;
	logic [63:0] stored;
	
	// instantiate module
	input_register input_reg_test (data, stored, select, clk);
	
	// set the clock
	initial begin
		forever #2 clk= ~clk;
	end
	
	initial begin
		clk = 0; select=0; data=0; 
		#12;
		#4;
		select=1;
		data=64'hABFE000000000000;
		#20;
		data=64'h0BFE000000000000;
		#20;
		data=64'h00FE000000000000;
		#20;
		
		select=0;
		data=64'hABFE000000000000;
		#20;
		data=64'h0BFE000000000000;
		#20;
		data=64'h00FE000000000000;
		#20;
		
		select=1;
		data=64'hABFE000000000000;
		#20;
		data=64'h0BFE000000000000;
		#20;
		data=64'h00FE000000000000;
		#20;
		
		select=0;
		data=64'hABFE000000000000;
		#20;
		data=64'h0BFE000000000000;
		#20;
		data=64'h00FE000000000000;
		#20;
		$stop;
		
	end
	
	
endmodule


//testbench for indv_register module 
module indv_register_tb ();

	// define signals
	logic clk, reset, select;
	logic [63:0] in;
	logic [63:0] out;
	
	// instantiate module
	indv_register register_test(clk, reset, select, in, out);
	
	// set the clock
	initial begin
		forever #2 clk= ~clk;
	end
	
	
	initial begin
		clk=0; reset=0; select=0; in=0; out=0;
		#4;
		
		// testing out with different in input
		reset=1;
		#12;
		reset=0;
		#12;
		select = 1;
		in = 64'hABFE000000000000;
		#12;
		in = 64'h0BFE000000000000;
		#12;
		in = 64'h00FE000000000000;
		#12;
		
		// testing whether out will change if select is 0
		select = 0;
		in = 64'hABFE000000000000;
		#12;
		in = 64'h0BFE000000000000;
		#12;
		in = 64'h00FE000000000000;
		#12;
		$stop;
		
	end
endmodule


