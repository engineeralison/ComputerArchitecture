module CPU_control (instruction, ALUOp, Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite, BrTaken, UncondBr, xfer_size, zero, negative, overflow, carry_out, ZF, NF, OF, CoF, SetFlag, loadB);
	
	input logic [31:0] instruction;
	input logic zero, negative, overflow, carry_out, ZF, NF, OF, CoF;
	
	output logic [1:0] ALUSrc, MemToReg;
	output logic [2:0] ALUOp;
	output logic [3:0] xfer_size;
	output logic Reg2Loc, RegWrite, MemWrite, BrTaken, UncondBr, SetFlag, loadB;
	
	enum logic [10:0] {
				ADDI = 11'b1001000100X,
				ADDS = 11'b10101011000,
				B = 11'b000101XXXXX,
				BLT = 11'b01010100XXX,
				CBZ = 11'b10110100XXX,
				LDUR = 11'b11111000010,
				LDURB = 11'b00111000010,
				MOVK = 11'b111100101XX,
				MOVZ = 11'b110100101XX,
				STUR = 11'b11111000000,
				STURB = 11'b00111000000,
				SUBS = 11'b11101011000
				} OpCode;
	
	always_comb begin
		casex (instruction[31:21])
			ADDI: begin
				Reg2Loc = 1'bX;
				ALUSrc = 2'b10;
				MemToReg = 0;
				RegWrite = 1;
				MemWrite = 0;
				BrTaken = 0;
				UncondBr = 1'bX;
				ALUOp = 3'b010;
				xfer_size = 4'd8;
				SetFlag = 0;
				loadB = 0;
			end
			
			ADDS: begin
				Reg2Loc = 1;
				ALUSrc = 0;
				MemToReg = 0;
				RegWrite = 1;
				MemWrite = 0;
				BrTaken = 0;
				UncondBr = 1'bX;
				ALUOp = 3'b010;
				xfer_size = 4'd8;
				SetFlag = 1;
				loadB = 0;
			end
			
			B: begin
				Reg2Loc = 1'bX;
				ALUSrc = 2'bXX;
				MemToReg = 2'bXX;
				RegWrite = 0;
				MemWrite = 0;
				BrTaken = 1;
				UncondBr = 1;
				SetFlag = 0;
				xfer_size = 4'd8;
				ALUOp = 3'bXXX;
				loadB = 0;
			end
			
			BLT: begin
				Reg2Loc = 0;
				ALUSrc = 0;
				MemToReg = 2'bXX;
				RegWrite = 0;
				MemWrite = 0;
				BrTaken = (NF ^ OF);
				UncondBr = 0;
				ALUOp = 3'bXXX;
				xfer_size = 4'd8;
				SetFlag = 0;
				loadB = 0;
			end 
		
			CBZ: begin
				Reg2Loc = 0;
				ALUSrc = 0;
				MemToReg = 2'bXX;
				RegWrite = 0;
				MemWrite = 0;
				BrTaken = zero;
				UncondBr = 0;
				ALUOp = 3'b000;
				xfer_size = 4'd8;
				SetFlag = 0;
				loadB = 0;
			end 
			
			LDUR: begin
				Reg2Loc = 1'bX;
				ALUSrc = 1;
				MemToReg = 1;
				RegWrite = 1;
				MemWrite = 0;
				BrTaken = 0;
				UncondBr = 1'bX;
				ALUOp = 3'b010;
				xfer_size = 4'd8;
				SetFlag = 0;
				loadB = 0;
			end 
			
			LDURB: begin
				Reg2Loc = 1'bX;
				ALUSrc = 1;
				MemToReg = 1;
				RegWrite = 1;
				MemWrite = 0;
				BrTaken = 0;
				UncondBr = 1'bX;
				ALUOp = 3'b010;
				xfer_size = 4'd1;
				SetFlag = 0;
				loadB = 1;
			end 
			
			MOVK: begin
				Reg2Loc = 0;
				ALUSrc = 2'bXX;
				MemToReg = 3;
				RegWrite = 1;
				MemWrite = 0;
				BrTaken = 0;
				UncondBr= 1'bX;
				ALUOp = 3'bXXX;
				xfer_size = 4'd8;
				SetFlag = 0;
				loadB = 0;
			end 
			
			MOVZ: begin
				Reg2Loc = 0;
				ALUSrc = 2'bXX;
				MemToReg = 2;
				RegWrite = 1;
				MemWrite = 0;
				BrTaken = 0;
				UncondBr = 1'bX;
				ALUOp = 3'bXXX;
				xfer_size = 4'd8;
				SetFlag = 0;
				loadB = 0;
			end 
			
			STUR: begin 
				Reg2Loc = 0;
				ALUSrc = 1;
				MemToReg = 2'bXX;
				RegWrite = 0;
				MemWrite = 1;
				BrTaken = 0;
				UncondBr = 1'bX;
				ALUOp = 3'b010;
				xfer_size = 4'd8;
				SetFlag = 0;
				loadB = 0;
			end 
			
			STURB: begin
				Reg2Loc = 0;
				ALUSrc = 1;
				MemToReg = 2'bXX;
				RegWrite = 0;
				MemWrite = 1;
				BrTaken = 0;
				UncondBr = 1'bX;
				ALUOp = 3'b010;
				xfer_size = 4'd1;
				SetFlag =0;
				loadB = 0;
			end 
			
			SUBS: begin
				Reg2Loc = 1;
				ALUSrc = 0;
				MemToReg = 0;
				RegWrite = 1;
				MemWrite = 0;
				BrTaken = 0;
				UncondBr = 1'bX;
				ALUOp = 3'b011;
				xfer_size = 4'd8;
				SetFlag = 1;
				loadB = 0;
			end
			
			default: begin 
				Reg2Loc = 1'bX;
				ALUSrc = 2'bXX;
				MemToReg = 2'bXX;
				BrTaken = 1'bX;
				ALUOp = 3'bXXX;
				UncondBr = 1'bX;
				xfer_size = 4'd8;
				RegWrite = 0;
				MemWrite = 0;
				SetFlag = 0;
				loadB = 0;
			end
		endcase 
	end
					
endmodule
