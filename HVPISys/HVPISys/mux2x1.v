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
module mux2x1(
    input sel,
    input [1:0] inputVal,
    output y
    );

	assign y = (!sel && inputVal[0]) || (sel && inputVal[1]);

endmodule
