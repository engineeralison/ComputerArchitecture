
`timescale 10ps/1fs
module instruction_datapath(clk, reset, UncondBr, BrTaken, instruction, PC);
	
	input logic clk, reset, UncondBr, BrTaken;
	input logic [31:0] instruction;
	
	output logic [63:0] PC;
	
	logic [63:0] CondAddr, BrAddr, newBrAddr, shifted, nextPC, added1, added2;
	
	SE #19 condaddr19 (instruction[23:5], CondAddr);
	SE #26 Braddr26 (instruction[25:0], BrAddr);
	
	genvar i;
	generate
		for (i=0; i < 64; i=i+1) begin: uncondbrmux
			mux2to1_lab2 branchpick (UncondBr, CondAddr[i], BrAddr[i], newBrAddr[i]);
			mux2to1_lab2 nextpc1 (BrTaken, added1[i], added2[i], nextPC[i]);
			D_FF PCnew (PC[i], nextPC[i], reset, clk);
		end
	endgenerate
	
	shifter X4 (newBrAddr, 1'b0, 6'b000010, shifted);
	
	adder64bit branch (PC, shifted, added2);
	adder64bit plus4 (PC, 64'd4, added1);
	
	
endmodule

module instruction_datapath_tb ();
	
	logic clk, reset, UncondBr, BrTaken; 
	logic [31:0] instruction; 
	logic [63:0] PC;
	
	instruction_datapath dut (clk, reset, UncondBr, BrTaken, instruction, PC);
	
	initial begin
		clk =0; reset = 1; UncondBr = 0; BrTaken =0; #5000;
		#5000; clk = 1;
		#5000; clk = 0;
		#5000; clk = 1;
		reset = 0; 
		#5000; clk = 0;
		#5000; clk = 1;
		instruction = 32'hFFFFFFFF; 
		#5000; clk = 0;
		#5000; clk = 1;
		instruction = 32'h00531243;
		#5000; clk = 0;
		#5000; clk = 1;
		instruction = 32'h0847283A; 
		#5000; clk = 0;
		#5000; clk = 1;
		instruction = 32'h00531243; 
		#5000; clk = 0;
		#5000; clk = 1;
		instruction = 32'h00531343; 
		#5000; clk = 0;
		#5000; clk = 1;
		
		BrTaken = 1; instruction = 32'h000000E0; 
		#5000; clk = 0;
		#5000; clk = 1;
		
		UncondBr = 1; instruction = 32'h17FFFFFD;
		#5000; clk = 0;
		#5000; clk = 1;
		#5000; clk = 0;
		#5000; clk = 1;
		
		#5000; clk = 0;
		#5000; clk = 1;
		
		$stop;
		
	end
endmodule
