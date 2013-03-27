`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
// 
// Create Date:    17:43:57 01/29/2013 
// Design Name: 
// Module Name:    mux_4x1_behav 
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
module mux4x1(
    input [1:0] sel,
    input [3:0] inputVal,
    output reg y
    );
	 
	 always@(sel, inputVal)
	 begin
	 
	 case(sel)
		2'b00:y=inputVal[0];
		2'b01:y=inputVal[1];
		2'b10:y=inputVal[2];
		2'b11:y=inputVal[3];
		default: y=1'bZ; //High impedance state
	 endcase
	 end
endmodule
