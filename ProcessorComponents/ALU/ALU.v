`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz & Sean Karlage
// 
// Create Date:    18:18:15 03/30/2013 
// Design Name: 
// Module Name:    ALU 
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
module ALU(V, Z, out, cout, in1, in2, cntrl);
	parameter n = 8;
	input [2:0] cntrl;
	input [n-1:0] in1; // This is the side which should take ACC input
	input [n-1:0] in2;
	output reg [7:0] out;
	output reg V, Z, cout; // Overflow and Zero flags and carry out
	reg [7:0] MSBCarry; // bit 7 will contain carry in of MSB
	
	always@(cntrl, in1, in2) begin
		case(cntrl)
			3'b000: begin	// ADD
				{cout, out} = in1 + in2;
				MSBCarry = in1[n-2:0] + in2[n-2:0];
				V = cout ^ MSBCarry[7];
			end
			3'b001: begin	// SUB
				{cout, out} = in1 - in2; 	
				MSBCarry = in1[n-2:0] - in2[n-2:0];
				V = cout ^ MSBCarry[7];
			end
			3'b010: begin	// OR
				{cout, V} = 0;
				out = in1 | in2; 
			end
			3'b011: begin	// AND
				{cout, V} = 0;
				out = in1 & in2; 
			end
			3'b100: begin	// Shift Right Logical (SRL)
				{cout, out} = in1 << in2; 
				V = 0; 	
			end
			3'b101: begin	// Shift Left Logical (SLL)
				{cout, out} = in1 >> in2; 
				V = 0; 	
			end			
			3'b110: begin	// Compliment (CMPL)
				{cout, V} = 0;
				out = !in1; 
			end 			
			3'b111: begin
				{cout, V} = 0;
				out = in1; 
			end
			default: begin
				{cout, out, V} = 0;
			end
		endcase
		
		if(out == 0) Z = 1'b1; // Set zero flag
		else Z = 1'b0;
		
	end
endmodule
