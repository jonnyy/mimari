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
module paramMux #(
	parameter muxType = 4,
	parameter selLines = 2,
	parameter size = 8)(
    input [selLines-1:0] sel,
    input [size*4-1:0] inputVal,
    output reg [size-1:0] y
    );

	always @(sel, inputVal) begin
		y = inputVal[(size*(sel+1))-1:(size*sel)];
	end
endmodule
