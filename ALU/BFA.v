`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
// 
// Create Date:    18:55:48 01/29/2013 
// Design Name: 
// Module Name:    BFA Gated coding
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
module BFA(
    input [1:0] I,
    input ci,
    output so,
    output co
    );
	 
	 wire wxor0, wand0, wand1, wand2;
	 
	 xor X0(wxor0, I[1], I[0]);
	 xor X1(so, wxor0, ci);
	 and A0(wand0, I[0], ci);
	 and A1(wand1, I[1], ci);
	 and A2(wand2, I[0], I[1]);
	 or(co, wand0, wand1, wand2);
	 
endmodule
