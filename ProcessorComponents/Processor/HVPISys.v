`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineers: Jonathan Lutz & Sean Karlage
// 
// Create Date:    16:53:26 03/20/2013 
// Design Name: 
// Module Name:    HPVISys 
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
module HVPISys #(
    parameter pcWidth = 8,
    parameter addrLen = 2) (
    input clrPend,                  // Clear the DFF storing whether there's a pending interrupt
    input intDisable,               // Disable any interrupts
    input clk,
    input [2**addrLen-1:0] ints,    // Interrupt flags
    input [2**addrLen-1:0] intMask, // Interrupt masks
    input ldMask, clrMask,          // Control Mask reg
    input ldIntReg, clrIntReg,      // Control Interrupt reg
    output [pcWidth-1:0] isrAddr,   // Output ISR address
    output intPending);             // Tells if there's a pending interrupt
	
	wire [2**addrLen-1:0] wIntRegOut, wMaskOut, wAndOut;
	wire [addrLen-1:0] wIntAddr;
	wire wIsPend, wIntPending;
	LdStrReg #(.n(4)) intReg(
		.in(ints),
		.load(ldIntReg),
		.out(wIntRegOut), //a Wire here
		.clr(clrIntReg),
		.clk(clk)
	);
		
		
	LdStrReg #(.n(4)) maskReg(
		.in(intMask),
		.load(ldMask),
		.out(wMaskOut), //a Wire here
		.clr(clrMask),
		.clk(clk)
	);
		
	//assign test_maskReg = wMaskOut;
	//assign test_intReg = wIntRegOut;
	
	assign wAndOut[0] = wMaskOut[0] & wIntRegOut[0];
	assign wAndOut[1] = wMaskOut[1] & wIntRegOut[1] & ~(wMaskOut[0] & wIntRegOut[0]);
	assign wAndOut[2] = wMaskOut[2] & wIntRegOut[2] & ~(wMaskOut[1] & wIntRegOut[1] & ~(wMaskOut[0] & wIntRegOut[0]));
	assign wAndOut[3] = wMaskOut[3] & wIntRegOut[3] & ~(wMaskOut[2] & wIntRegOut[2] & ~(wMaskOut[1] & wIntRegOut[1] & ~(wMaskOut[0] & wIntRegOut[0])));

	// Interrupt 0 has highest priority.
	priorityEncoder4bit addrEncode(
		.i({wAndOut[0],wAndOut[1],wAndOut[2],wAndOut[3]}),
		.enable(~intDisable),
		.out(wIntAddr),
		.noSig(wIsPend)
	);
	
	//assign priEncOut = {wIntAddr,wIsPend};
	
	regArray #(.n(8), .m(2)) intAddrRAM(
		.dataOut(isrAddr),
		.writeEnable(1'b0),
		.clr(1'b1), // we DO NOT want to clear these addresses 
		.dataIn(8'bZZZZZZZZ),
		.readAddr(wIntAddr),
		.writeAddr(wIntAddr), // NEVER used
		.clk(clk)
	);
	
	DFlipFlop DFF(
		.D(~wIsPend),
		.clk(clk), 
		.clr(clrPend), 
		.set(1'b1),
		.Q(wIntPending),
		.Qbar()	
	);
	//assign test_wIntPending = wIsPend;
	and(intPending, wIntPending, ~intDisable);
endmodule
