`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:57:39 02/12/2013 
// Design Name: 
// Module Name:    LD_ST_RegBitSlice 
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
module LD_ST_RegBitSlice(
	input slIn, LD_ST, set, clr, clk,
	output slOut
    );
	wire wMuxOut;
	
	 mux2x1 loadStore(
		.sel(LD_ST),
		.inputVal({slIn, slOut}),
		.y(wMuxOut)
	);
	
	DFlipFlop DFF(
		.clk(clk),
		.clr(clr),
		.set(set),
		.D(wMuxOut),
		.Q(slOut),
		.Qbar()
	);

endmodule
