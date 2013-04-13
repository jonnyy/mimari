`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:09:48 04/12/2013 
// Design Name: 
// Module Name:    paramMux 
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
module paramMux(muxOut, sel, in);
	parameter k = 2;
	input [k-1:0] sel;
	input [(2**k) - 1: 0] in;
	output reg muxOut;
	
	always@(sel, in)
	begin
		muxOut=in[sel];
	end
endmodule
