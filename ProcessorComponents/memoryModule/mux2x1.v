`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
// 
// Create Date:    18:09:09 01/29/2013 
// Design Name: 
// Module Name:    mux2x1
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
module mux2x1 #(
	parameter size = 8)(
    input sel,
    input [size*2-1:0] inputVal,
    output reg [size-1:0] y
    );

	always @(sel, inputVal) begin
		case(sel)
			1'b0: y = inputVal[size-1:0];
			1'b1: y = inputVal[size*2-1:size];
		endcase
	end
endmodule
