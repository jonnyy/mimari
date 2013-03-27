`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
// 
// Create Date:    17:27:41 02/05/2013 
// Design Name: 
// Module Name:    ALU_bit_slice 
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
module ALUBitSlice(
    input a, b, cin,
    input [2:0] c,
    output cout, f
    );
	wire wMuxBOut, wInvOut, wAndOut, wOrOut, wAddOut;

	mux2x1 muxB(
		.sel(c[0]),
		.inputVal({~b, b}),
		.y(wMuxBOut)
	);
	
	mux2x1 inverter_mux(
		.sel(c[0]),
		.inputVal({~b, ~a}),
		.y(wInvOut)
	);
	
	and (wAndOut, a, wMuxBOut);
	or (wOrOut, a, wMuxBOut);

	BFA adder(
		.I({wMuxBOut, a}),
		.ci(cin),
		.so(wAddOut),
		.co(cout)
	);
	
	mux4x1 mux_4x1(
		.sel(c[2:1]),
		.inputVal({wInvOut, wAndOut, wOrOut, wAddOut}),
		.y(f)	
	);
endmodule
