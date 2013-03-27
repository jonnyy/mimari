`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
// 
// Create Date:    00:56:26 02/12/2013 
// Design Name: 
// Module Name:    LD_ST_Reg 
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
module LD_ST_Reg(slOut, slIn, LD_ST, set, clr, clk);
	parameter n = 4;
	genvar i;
	input [n-1:0] slIn;
	input LD_ST, set, clr, clk;
	output [n-1:0] slOut;
	
	generate
	for(i=0; i<=n-1; i=i+1)
	begin:build
		LD_ST_RegBitSlice bitSlice(
			.clk(clk),
			.clr(clr),
			.set(set),
			.LD_ST(LD_ST),
			.slIn(slIn[i]),
			.slOut(slOut[i])
		);
	end
	endgenerate


endmodule
