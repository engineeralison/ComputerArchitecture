`timescale 10ps/1fs
module CPU_datapath (clk, reset, instruction, Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite, ALUOp, xfer_size, zero, negative, overflow, carry_out, ZF, NF, OF, CoF, SetFlag, loadB);
	
	input logic clk, reset, Reg2Loc, RegWrite, MemWrite, SetFlag, loadB;
	input logic [1:0] ALUSrc, MemToReg;
	input logic [2:0] ALUOp;
	input logic [3:0] xfer_size;
	input logic [31:0] instruction;
	
	output logic zero, negative, overflow, carry_out, ZF, NF, OF, CoF;
	
	logic [63:0] Da, Db, Dw, ALUB, ALU_result, Dout, Daddr64, Imm12ZE, MOVZ64, MOVK64, byte64, Dout2;
	logic [15:0] Imm16;
	logic [11:0] Imm12;
	logic [8:0] DAddr9;
	logic [7:0] byte1;
	logic [4:0] Ab, Aa, Aw;
	
	assign Aa = instruction[9:5];
	assign Aw = instruction[4:0];
	assign DAddr9 = instruction[20:12];
	assign Imm12 = instruction[21:10];
	assign Imm16 = instruction[20:5];
	assign byte1 = Dout[7:0];
	
	regfile reg32 (Da, Db, Dw, Aa, Ab, Aw, RegWrite, clk);
	
	genvar i;
	generate 
		for (i = 0; i < 5; i=i+1) begin: addresses
			mux2to1_lab2 reg2locmux (Reg2Loc, instruction[i], instruction[i+16], Ab[i]);
		end
	endgenerate
	
	genvar j;
	generate 
		for (j=0; j<64; j=j+1) begin: data64bit
			//mux4to1 memtoregmux (MemToReg, {ALU_result[j], Dout[j], MOVZ64[j], MOVK64[j]}, Dw[j]);
			mux4to1 memtoregmux (MemToReg, {MOVK64[j], MOVZ64[j], Dout2[j], ALU_result[j]}, Dw[j]);
			//mux4to1 alusrcmux (ALUSrc, {Db[j], Daddr64[j], Imm12ZE[j], 1'b0}, ALUB[j]);
			mux4to1 alusrcmux (ALUSrc, {1'b0, Imm12ZE[j], Daddr64[j], Db[j]}, ALUB[j]);
			mux2to1_lab2 loadbytepls (loadB, Dout[j], byte64[j], Dout2[j]);
		end
	endgenerate 
	
	SE #13 imm12 ({1'b0, Imm12}, Imm12ZE);
	SE #9 daddr9se (DAddr9, Daddr64);
	SE #9 loadbyte ({1'b0, byte1}, byte64);
	alu ALUP (Da, ALUB, ALUOp, ALU_result, negative, zero, overflow, carry_out);
	
	datamem MEMORY (ALU_result, MemWrite, 1'b1, Db, clk, xfer_size, Dout);
	
	MOVZ movz1 (Imm16, instruction[22:21], MOVZ64);
	MOVK movk1 (Db, Imm16, instruction [22:21], MOVK64);
	
	flagReg updateflag (clk, reset, SetFlag, {zero, negative, overflow, carry_out}, {ZF, NF, OF, CoF});
	
endmodule

module CPU_datapath_tb();
	
	logic clk, reset, Reg2Loc, RegWrite, MemWrite, SetFlag, zero, negative, overflow, carry_out, ZF, NF, OF, CoF;
	logic [1:0] ALUSrc, MemToReg;
	logic [2:0] ALUOp;
	logic [3:0] xfer_size;
	logic [31:0] instruction;
	
	CPU_datapath dut (clk, reset, instruction, Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite, ALUOp, xfer_size, zero, negative, overflow, carry_out, ZF, NF, OF, CoF, SetFlag);
	
	parameter ClockDelay = 10000;
	
	initial begin
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	
	initial begin
		#1000; 
	end
	
endmodule
