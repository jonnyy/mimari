`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
// 
// Create Date:    18:09:09 01/29/2013 
// Design Name: 
// Module Name:    mux4x1
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
module mux4x1 #(
	parameter size = 8)(
    input [1:0] sel,
    input [size*4-1:0] inputVal,
    output reg [size-1:0] y
    );

	always @(sel, inputVal) begin
		case(sel)
			2'b00: y = inputVal[size-1:0];
			2'b01: y = inputVal[(size*2)-1:size];
			2'b10: y = inputVal[(size*3)-1:(size*2)];
			2'b11: y = inputVal[(size*4)-1:(size*3)];
		endcase                        
	end
endmodule
