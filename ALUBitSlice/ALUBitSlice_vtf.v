`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky 
// Engineer: Jonathan Lutz
//
// Create Date:   18:30:49 02/05/2013
// Design Name:   ALU_bit_slice
// Module Name:   L:/EE480/ALU_bit_slice/ALU_bit_slice_vtf.v
// Project Name:  ALU_bit_slice
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU_bit_slice
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALUBitSlice_vtf;

	// Inputs
	reg a, b, cin;
	reg [2:0] c;

	// Outputs
	wire cout, f;
	reg tc_cout, tc_f, error;

	// Instantiate the Unit Under Test (UUT)
	ALUBitSlice uut (
		.a(a), 
		.b(b), 
		.cin(cin), 
		.c(c), 
		.cout(cout), 
		.f(f)
	);

	initial begin
		// Initialize Inputs
		{c, cin, a, b} = 4'b0000;
		tc_cout = 0;
		tc_f = 0;
		error = 0;
		// Wait 100 ns for global reset to finish
		#100;
	end
	
	always
	begin
		#20 {c, cin, a, b} = {c, cin, a, b} + 1; //These together serve as a counter
		case(c[0])
			1'b0: tc_cout = a&b || a&cin || b&cin;
			1'b1: tc_cout = a&~b || a&cin || ~b&cin;
		endcase
		case(c)
			3'b000: tc_f = a+b+cin;
			3'b001: tc_f = a+~b+cin;
			3'b010: tc_f = a|b;// If not add or subtract we do not care about carry out
			3'b011: tc_f = a|~b;
			3'b100: tc_f = a&b;
			3'b101: tc_f = a&~b;
			3'b110: tc_f = ~a;
			3'b111: tc_f = ~b;
		endcase
		
	#1	if(f == tc_f && cout == tc_cout) error=0;
			else error = 1;
	end
endmodule
