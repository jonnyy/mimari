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
	output reg Q, Qbar
    );
	
	always @(posedge clk)
	begin
		if(~clr) begin Q <= 1'b0; Qbar <= 1'b1; end 
		else if(~set) begin Q <= 1'b1; Qbar <= 1'b0; end
		else begin Q <= D; Qbar <= ~D; end
	end
endmodule
