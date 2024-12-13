// alu1bit is the function for one bit of a full alu
// Its inputs are select (the control signal), a, b, and Cin 
// (the two inputs and the carry of the previous bit)
// the outputs are out and Cout (the carry for the next bit)

`timescale 10ps/1fs
module alu1bit (select, a, b, Cin, Cout, out);
	
	input logic [2:0] select;
	input logic a, b, Cin;
	
	output logic out, Cout;
	
	// bnot is b after it goes through a not gate
	// badd is the b that goes through the adder (changes 
	// when subtract is selected)
	logic bnot, badd;
	logic [7:0] temp;
	
	assign temp[0] = b; // b pass
	assign temp[1] = 0; // not a valid control signal
	assign temp[7] =0; // not a valid control signal
	assign temp[3] = temp[2]; // add or subtract
	
	// logic gates (other alu functions)
	not #5 f (bnot, b);
	and #5 g (temp[4], a, b); 
	or #5 h (temp[5], a, b);
	xor #5 i (temp[6], a, b);
	
	// selecting which b to use - control signal is the only difference in 
	mux2to1_lab2 d (select[0], b, bnot, badd);
	
	// calling adder
	adder e (a, badd, temp[2], Cin, Cout);
	
	// outputs of logic gates and adder go into a mux with the control signal
	mux8to1_lab2 j (select, temp, out);
	
endmodule 

module alu1bit_tb ();
	
	logic a, b, Cin, Cout, out;
	logic [2:0] select;
	
	alu1bit pls (select, a, b, Cin, Cout, out);
	
	
	initial begin
		
		// testing pass
		a=0; b=0; Cin=0; select=3'b000;
		#100;
		a=0; b=1; Cin=1; select=3'b000;
		#100;
		
		// testing add
		a=0; b=0; Cin=1; select=3'b010;
		#100;
		a=0; b=1; Cin=1; select=3'b010;
		#100;
		a=1; b=1; Cin=1; select=3'b010;
		#100;
		
		// testing subtract
		a=1; b=0; Cin=1; select=3'b011;
		#100;
		a=1; b=1; Cin=1; select=3'b011;
		#100;
		a=1; b=1; Cin=0; select=3'b011;
		#100;
		
		// testing and
		a=1; b=1; Cin=1; select=3'b100;
		#100;
		a=0; b=1; Cin=1; select=3'b100;
		#100;
		a=0; b=0; Cin=1; select=3'b100;
		#100;
		
		// testing or
		a=1; b=1; Cin=1; select=3'b101;
		#100;
		a=1; b=0; Cin=1; select=3'b101;
		#100;
		a=0; b=1; Cin=1; select=3'b101;
		#100;
		a=0; b=0; Cin=1; select=3'b101;
		#100;
		
		// testing xor
		a=1; b=1; Cin=1; select=3'b110;
		#100;
		a=0; b=1; Cin=1; select=3'b110;
		#100;
		a=1; b=0; Cin=1; select=3'b110;
		#100;
		a=0; b=0; Cin=1; select=3'b110;
		#100;
		$stop;
	
	end
	
	
endmodule