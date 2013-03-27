`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
// 
// Create Date:    19:55:17 02/19/2013 
// Design Name: 
// Module Name:    PC 
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
module PC(out, clr, clk, loadIn, cntrl);
	parameter n = 4;
	parameter inc = 2;
	input clr, clk;
	input [n-1:0] loadIn;
	input [1:0] cntrl;
	output reg [n-1:0] out;

	always @(posedge clk)
	begin
		if(~clr) out<=0;
		else begin
			case(cntrl)
				2'b00: out <= out;
				2'b01: out <= loadIn;
				2'b10: out <= out + 1;
				2'b11: out <= out + inc;
			endcase
		end
	end
endmodule
