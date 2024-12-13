// Matthew Nochi
// 10/12/2023
// ECE 469 
// Lab 1 

// This is a 32 by 64bit register file made with a 5 to 32 decoder, 32 64bit registers and a 64x32to1 mux.

// The inputs are clk (the system clock), RegWrite (the signal to enable writing a register)
// ReadRegister1 and ReadRegister2 - a 5 bit signal used to select which register to read from
// writeRegister - a 5 bit signal used to select which register to write to, 
// write data - a 64 bit input to the register of choice 

// The outputs are ReadData1 and ReadData2 - these are 64 bit outputs that read the contents of the registers
`timescale 10ps/1fs

module regfile (ReadData1, ReadData2, WriteData, ReadRegister1, ReadRegister2, WriteRegister, RegWrite, clk);
	input logic clk, RegWrite;
	input logic [4:0] ReadRegister1, ReadRegister2, WriteRegister;
	input logic [63:0] WriteData;
	
	output logic [63:0] ReadData1, ReadData2;
	
	logic [31:0][63:0] regdata;
	logic [31:0] register;
	
	// set register 31 to always be 0
	assign regdata [31][63:0] = 64'b0;
	
	// 5 to 32 decoder
	decoder decode (RegWrite, WriteRegister, register);
	
	
	// setting up 32 registers made up of 64 d flipflips
	genvar i;
	generate 
		for (i = 0; i < 31; i++) begin : inputToReg
			input_register pls (WriteData[63:0], regdata[i][63:0], register[i], clk);
		end
	endgenerate
	
	// two output muxs for reading register data
	mux64X32to1 mux1 (ReadRegister1, regdata, ReadData1);
	mux64X32to1 mux2 (ReadRegister2, regdata, ReadData2);
	
	
	
endmodule



// 5 to 32 decoder - inputs are enable (to enable the decoder)
// in - a 5 bit input
// the outputs are select the 32 bit output that selects 
// which register to use
module decoder (enable, in, select);

	input logic enable;
	input logic [4:0] in;
	
	output logic [31:0] select;
	
	logic[3:0] decoder_select;
	
	decode2to4 a (enable, in[4:3], decoder_select);
	
	decode3to8 b (decoder_select[0], in[2:0], select[7:0]);
	decode3to8 c (decoder_select[1], in[2:0], select[15:8]);
	decode3to8 d (decoder_select[2], in[2:0], select[23:16]);
	decode3to8 e (decoder_select[3], in[2:0], select[31:24]);
	
endmodule

// used to help the 5 to 32 decoder
module decode2to4 (en, in, out);
	
	input logic [1:0] in;
	input logic en;
	
	output logic [3:0] out;
	
	logic [1:0] notin;
	
	not #5 a (notin[0], in[0]);
	not #5 b (notin[1], in[1]);
	
	and #5 c (out[0], en, notin[0], notin[1]);
	and #5 d (out[1], en, notin[1], in[0]);
	and #5 e (out[2], en, notin[0], in[1]);
	and #5 f (out[3], en, in[1], in[0]);
	
endmodule

// used to help the 5 to 32 decoder
module decode3to8 (en, in, out);
	
	input logic [2:0] in;
	input logic en;
	
	output logic [7:0] out;
	
	logic [2:0] notin;
	
	not #5 a (notin[0], in[0]);
	not #5 b (notin[1], in[1]);
	not #5 c (notin[2], in[2]);
	
	and #5 d (out[0], en, notin[2], notin[1], notin[0]);
	and #5 e (out[1], en, notin[2], notin[1], in[0]);
	and #5 f (out[2], en, notin[2], in[1], notin[0]);
	and #5 g (out[3], en, notin[2], in[1], in[0]);
	and #5 h (out[4], en, in[2], notin[1], notin[0]);
	and #5 i (out[5], en, in[2], notin[1], in[0]);
	and #5 j (out[6], en, in[2], in[1], notin[0]);
	and #5 k (out[7], en, in[2], in[1], in[0]);
	
endmodule

// module for each individual register 
// stores data and can have new data inputed 
// inputs are data - new data to be inputed (64 bits)
// select - to determine which register is picked
// clk - clk
// output is stored - current 64 bits register is holding,
module input_register (data, stored, select, clk);

	input logic  [63:0] data;
	input logic  select, clk;
	
	output logic [63:0] stored;
	
	logic [63:0] temp;
	
	genvar i;
	generate
		for(i=0; i<64; i++) begin: eachDff
			mux2to1v2 TheMux (select, stored[i], data[i], temp[i]); 																			
			D_FF theDFF (stored[i], temp[i], 1'b0, clk);
		end
		
	endgenerate
	
endmodule

