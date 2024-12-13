module SE #(parameter bitWidth) (in, out);
	
	input logic [bitWidth-1:0] in;
	output logic [63:0] out;
	
	assign out[bitWidth-1:0] = in;
	
	genvar i;
	generate 
		for (i = bitWidth; i<64; i=i+1) begin: singlebit
			assign out[i] = in[bitWidth-1];
		end
	endgenerate
endmodule



module SE_tb();
	
	logic [15:0] in;
	logic [63:0] out;
	
	SE #(16) dut (in, out);
	
	initial begin
		in = 16'h00FF; #100;
		in = 16'h800F; #100;
	end
endmodule 
