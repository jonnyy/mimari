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
    parameter pcWidth = 16,
    parameter addrLen = 2)(
    input clrPend,                   // Clear the DFF storing the above info
    input intDisable,               // Disable any interrupts
    input clk,
    input [2**addrLen-1:0] ints,               // Interrupt flags
    input [2**addrLen-1:0] intMask,            // Interrupt masks
    input ldMask, clrMask,           // Control Mask reg
    input ldIntReg, clrIntReg,      // Control Interrupt reg
    output [pcWidth-1:0] isrAddr,   // Output ISR address
	output [3:0] test_maskReg,
	output [2:0] priEncOut,
	output [3:0] test_intReg,
	output test_wIntPending,
    output intPending);             // Tells if there's a pending interrupt
	
	wire [2**addrLen-1:0] wIntRegOut, wMaskOut, wAndOut;
	wire [addrLen-1:0] wIntAddr;
	wire wIsPend, wIntPending;
	LD_ST_Reg intReg(
		.slIn(ints),
		.LD_ST(ldIntReg),
		.slOut(wIntRegOut), //a Wire here
		.set(1'b1),
		.clr(clrIntReg),
		.clk(clk)
		);
		
		
	LD_ST_Reg maskReg(
		.slIn(intMask),
		.LD_ST(ldMask),
		.slOut(wMaskOut), //a Wire here
		.set(1'b1),
		.clr(clrMask),
		.clk(clk)
		);
		
	assign test_maskReg = wMaskOut;
	assign test_intReg = wIntRegOut;
	
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
	
	assign priEncOut = {wIntAddr,wIsPend};
	
	regArray intAddrRAM(
		.dataOut(isrAddr),
		.writeEnable(1'b0),
		.clr(1'b1), // we DO NOT want to clear these addresses 
		.dataIn(16'bZZZZZZZZZZZZZZZZ),
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
	assign test_wIntPending = wIsPend;
	and(intPending, wIntPending, ~intDisable);
endmodule
