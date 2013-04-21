`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
// 
// Create Date:    18:09:09 01/29/2013 
// Design Name: 
// Module Name:    mux8x1
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
module mux8x1 #(
	parameter size = 8)(
    input [2:0] sel,
    input [size*8-1:0] inputVal,
    output reg [size-1:0] y
    );

	always @(sel, inputVal) begin
		case(sel)
			3'b000: y = inputVal[size-1:0];
			3'b001: y = inputVal[(size*2)-1:size];
			3'b010: y = inputVal[(size*3)-1:(size*2)];
			3'b011: y = inputVal[(size*4)-1:(size*3)];
			3'b100: y = inputVal[(size*5)-1:(size*4)];
			3'b101: y = inputVal[(size*6)-1:(size*5)];
			3'b110: y = inputVal[(size*7)-1:(size*6)];
			3'b111: y = inputVal[(size*8)-1:(size*7)];
		endcase
	end
endmodule
