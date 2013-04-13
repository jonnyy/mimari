`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:04:21 04/12/2013 
// Design Name: 
// Module Name:    nBitShifter 
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
module nBitShifter(shifterOut, Fout, c);
	parameter n=4;
	parameter k = 2; //makes 4x1 mux
	input [1:0] c;
	input [n-1:0] Fout;
	output reg [n-1:0] shifterOut;
	genvar i;
	
	paramMux MSBShifter(.in({1'b0, 1'b0, Fout[n-1], Fout[n-2]}), .sel(c), .muxOut(shifterOut[n-1]));
	
	generate  
		for(i=1; i<n-2; i=i+1)
		begin: genMux
			paramMux genMuxShifter(.in({1'b0, Fout[i+1], Fout[i], Fout[i-1]}), .sel(c), .muxOut(shifterOut[i]));
		end
	endgenerate
	paramMux LSBShifter (.in({1'b0, Fout[1], Fout[0], 1'b0}), .sel(c), .muxOut(shifterOut[0]));
endmodule
