`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
// 
// Create Date:    23:42:48 02/10/2013 
// Design Name: 
// Module Name:    ALU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ALU(f, cout, v, cntrl, a, b);
	parameter n = 4;
	input	[2:0] cntrl;
	input 	[n-1:0] a;
	input 	[n-1:0] b;
	output  [n-1:0] f;
	output  cout;
	output v; //Overflow status flag

	genvar i; 
	wire [n-2:0] wCout;
	
	//Generate LSB of ALU
	ALUBitSlice LSB(
		.a(a[0]),
		.b(b[0]),
		.c(cntrl),
		.cin(cntrl[0]),
		.cout(wCout[0]),
		.f(f[0])
	);
	
	generate
		for(i=0; i<n-2; i=i+1)
		begin:build
			ALUBitSlice bitSlice(
				.a(a[i+1]),
				.b(b[i+1]),
				.c(cntrl),
				.cin(wCout[i]),
				.cout(wCout[i+1]),
				.f(f[i+1])
			);
		end
	endgenerate
	
	//Generate MSB of ALU
	ALUBitSlice MSB(
		.a(a[n-1]),
		.b(b[n-1]),
		.c(cntrl),
		.cin(wCout[n-2]),
		.cout(cout),
		.f(f[n-1])
	);
	xor(v, cout, wCout[n-2]);
endmodule
