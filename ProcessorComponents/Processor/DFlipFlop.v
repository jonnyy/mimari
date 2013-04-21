`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
// 
// Create Date:    20:59:23 02/11/2013 
// Design Name: 
// Module Name:    DFlipFlop 
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
module DFlipFlop(
	input D, clk, clr, set,
	output reg Q,
	output Qbar
    );
	
	always @(posedge clk) begin
		if(clr == 0) Q <= 0;
		else if(set == 0) Q <= 1;
		else Q <= D;
	end
	
	assign Qbar = ~Q;
endmodule
