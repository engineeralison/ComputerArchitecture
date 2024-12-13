`timescale 10ps/1fs
module mux4to1_tb ();

	logic [3:0] in;
	logic [1:0] select;
	logic out;
	
	mux4to1 test16to1 (select, in, out);
	
	initial begin
		in = 4'b1110; select = 2'b00; #50;
		in = 4'b1110; select = 2'b01; #50;
		in = 4'b1110; select = 2'b10; #50;
		in = 4'b1110; select = 2'b11; #50;

		in = 4'b1010; select = 2'b00; #50;
		in = 4'b1010; select = 2'b01; #50;
		in = 4'b1010; select = 2'b10; #50;
		in = 4'b1010; select = 2'b11; #50;	
	
		in = 4'b0110; select = 2'b00; #50;
		in = 4'b0110; select = 2'b01; #50;
		in = 4'b0110; select = 2'b10; #50;
		in = 4'b0110; select = 2'b11; #50;	

		in = 4'b0001; select = 2'b00; #50;
		in = 4'b0001; select = 2'b01; #50;
		in = 4'b0001; select = 2'b10; #50;
		in = 4'b0001; select = 2'b11; #50;
	end

endmodule

module mux16to1_tb();

	logic [15:0] in;
	logic [3:0] select;
	logic out;
	
	mux16to1 test (select, in, out);
	
	initial begin
		int i;
		in = 16'd343;
		for(i = 0; i < 16; i++) 
		begin
			select = i;
			#50;
		end
		
		in = 16'd4123;
		for(i = 0; i < 16; i++) 
		begin
			select = i;
			#50;
		end
	end
endmodule

module mux64x32to1_tb();	

	logic [31:0][63:0] in;
	logic [4:0] select;
	logic [63:0] out;
	
	mux64X32to1 pls (select, in, out);
	
	initial begin
		int i, j;
		for (i = 0; i < 32;i++)	begin
			in[i][63:0] = 64'd155 + i;
		end
		for (j = 0; j < 32; j++) begin
			select = j;
			#50;
		end
	end
endmodule
