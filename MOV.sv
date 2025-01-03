`timescale 10ps/1fs
module MOVZ (Imm16, Shamt, out);
	
	input logic [15:0] Imm16;
	input logic [1:0] Shamt;
	
	output logic [63:0] out; 
	
	logic [63:0] shamt1, shamt2, shamt3, shamt4;
	
	SE #17 test({1'b0, Imm16}, shamt1);
	shifter X16 (shamt1, 1'b0, 6'd16, shamt2);
	shifter X32 (shamt1, 1'b0, 6'd32, shamt3);
	shifter X48 (shamt1, 1'b0, 6'd48, shamt4);
	
	genvar i;
	generate 
		for (i = 0; i < 64; i=i+1) begin: mux
			mux4to1 shamt_all (Shamt, {shamt4[i], shamt3[i], shamt2[i], shamt1[i]}, out[i]);
		end
	endgenerate 
endmodule

module MOVK (Db, Imm16, Shamt, out);
	
	input logic [63:0] Db;
	input logic [15:0] Imm16;
	input logic [1:0] Shamt;
	
	output logic [63:0] out; 
	
	logic [63:0] shamt1, shamt2, shamt3, shamt4;
	
	assign shamt1[15:0] = Imm16;
	assign shamt1[63:16] = Db[63:16];
	
	assign shamt2[15:0] = Db[15:0];
	assign shamt2[31:16] = Imm16;
	assign shamt2[63:32] = Db[63:32];
	
	assign shamt3[31:0] = Db[31:0];
	assign shamt3[47:32] = Imm16;
	assign shamt3[63:48] = Db[63:48];
	
	assign shamt4[47:0] = Db[47:0];
	assign shamt4[63:48] = Imm16;
	
	genvar i;
	generate 
		for (i = 0; i < 64; i=i+1) begin: mux
			mux4to1 shamt_all (Shamt, {shamt4[i], shamt3[i], shamt2[i], shamt1[i]}, out[i]);
		end
	endgenerate 
	
endmodule

module MOVZ_tb();

	logic [15:0] Imm16;
	logic [1:0] Shamt;
	logic [63:0] out; 
	
	MOVZ dut (Imm16, Shamt, out);
	
	initial begin
		Imm16 = 16'hFFFF; Shamt = 0; 
		#1000;
		Imm16 = 16'hFFFF; Shamt = 1; 
		#1000;
		Imm16 = 16'hFFFF; Shamt = 2; 
		#1000;
		Imm16 = 16'hFFFF; Shamt = 3; 
		#1000;
	end
endmodule

module MOVK_tb();

	logic [15:0] Imm16;
	logic [1:0] Shamt;
	logic [63:0] out, Db; 
	
	MOVK dut (Db, Imm16, Shamt, out);
	
	initial begin
		Db=64'b0; Imm16 = 16'hFFFF; Shamt = 0; 
		#1000;
		Imm16 = 16'hFFFF; Shamt = 1; 
		#1000;
		Imm16 = 16'hFFFF; Shamt = 2; 
		#1000;
		Imm16 = 16'hFFFF; Shamt = 3; 
		#1000;
	end
endmodule
