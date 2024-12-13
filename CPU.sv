`timescale 10ps/1fs

module CPU (clk, reset);
	
	input logic clk, reset;
	
	logic [63:0] PC;
	logic [31:0] instruction;
	logic [3:0] xfer_size;
	logic [2:0] ALUOp;
	logic [1:0] ALUSrc, MemToReg;
	logic Reg2Loc, RegWrite, MemWrite, BrTaken, UncondBr, SetFlag, loadB;
	logic zero, negative, overflow, carry_out, ZF, NF, OF, CoF;
	
	instruction_datapath test1 (clk, reset, UncondBr, BrTaken, instruction, PC);
	CPU_control test2 (instruction, ALUOp, Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite, BrTaken, UncondBr, xfer_size, zero, negative, overflow, carry_out, ZF, NF, OF, CoF, SetFlag, loadB);
	CPU_datapath test3(clk, reset, instruction, Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite, ALUOp, xfer_size, zero, negative, overflow, carry_out, ZF, NF, OF, CoF, SetFlag, loadB);
	
	instructmem test4(PC, instruction, clk);
endmodule

module CPU_tb();
	
	logic clk, reset;
	
	CPU dut (clk, reset);
	
	parameter clockPeriod = 10000;
	
	initial begin
		clk <= 0;
		forever #(clockPeriod/2) clk <= ~clk;
	end
	
	int i;
	initial begin
		reset = 1; @(posedge clk); @(posedge clk);
		reset = 0; @(posedge clk); @(posedge clk);
		for (i=0; i < 500; i = i+1) begin
			@(posedge clk);
		end
	end
	
endmodule
