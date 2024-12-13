// test_zero takes a 64 bit input and output a 1 if all 64 bits are zero
// if not it outputs a 0

`timescale 10ps/1fs
module test_zero (in, out);
	
	input logic [63:0] in;
	output logic out;
	
	logic [8:0] temp;
	
	or #5 a (temp[0], in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7]);
	or #5 b (temp[1], in[8], in[9], in[10], in[11], in[12], in[13], in[14], in[15]);
	or #5 c (temp[2], in[16], in[17], in[18], in[19], in[20], in[21], in[22], in[23]);
	or #5 d (temp[3], in[24], in[25], in[26], in[27], in[28], in[29], in[30], in[31]);
	or #5 e (temp[4], in[32], in[33], in[34], in[35], in[36], in[37], in[38], in[39]);
	or #5 f (temp[5], in[40], in[41], in[42], in[43], in[44], in[45], in[46], in[47]);
	or #5 g (temp[6], in[48], in[49], in[50], in[51], in[52], in[53], in[54], in[55]);
	or #5 h (temp[7], in[56], in[57], in[58], in[59], in[60], in[61], in[62], in[63]);
	
	or #5 i (temp[8], temp[0], temp[1], temp[2], temp[3], temp[4], temp[5], temp[6], temp[7]);
	not #5 j (out, temp[8]);
	
endmodule

