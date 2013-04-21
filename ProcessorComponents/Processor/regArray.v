`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
// 
// Create Date:    17:34:47 02/24/2013 
// Design Name: 
// Module Name:    regArray 
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
module regArray #(
	parameter m = 2,
	parameter n = 8 )(
	input writeEnable, clr, clk,
	input [m-1:0] readAddr,
	input [m-1:0] writeAddr,
	input [n-1:0] dataIn,

	output [n-1:0] dataOut
	);
	integer i;

	reg [n-1:0] regArray [(2**m)-1:0];
	
	initial begin
		regArray[0] = 8'b11110000;
		regArray[1] = 8'b11110100;
		regArray[2] = 8'b11111000;
		regArray[3] = 8'b11111100;
	end
		
	always @(negedge(clk))
	begin	
		if(~clr) 
		begin
			for(i=0; i<2**m; i=i+1)
			begin
				regArray[i] = 0;
			end
		end				
		else if(writeEnable==1'b1)
		begin
			regArray [writeAddr] = dataIn;
		end
	end
	assign dataOut = regArray[readAddr];
endmodule
