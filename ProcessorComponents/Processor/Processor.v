`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jonathan Lutz & Sean Karlage
// 
// Create Date:    01:22:53 04/19/2013 
// Design Name: 
// Module Name:    Processor 
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
module Processor #(
	parameter dummyVal = 8'b11111111,
	parameter DRamWidth = 8,
	parameter addrSize = 8,
	parameter IRamWidth = 16,
	parameter IRWidth = 6,
	parameter ccWidth = 2) (
	input [DRamWidth-1:0] in,
	input clk, reset, inDataReady, outACK,
	output [DRamWidth-1:0] out,
	output outDataReady, inACK,
	output [42:0] currState, //TEMP
	output [DRamWidth-1:0] tmpACCout, //TEMP
	output [5:0] tmpIRout, // TEMP
	output [8:0] tmpPCout, //TEMP
	output tmpDataReady, //TEMP
	output [15:0] tmpIRAMout, //TEMP
	output [1:0] IRAMcntrlTEMP, //TEMP
	output [18:0] tmpIRAMState, //TEMP
	output [7:0] tmpIRAMCacheAddr //TEMP
    );
	
	// TEMP wires
	wire [18:0] wIRAMState, wDRAMState;
	
	//Register Basics
	wire wIRclr, wACCclr, wCCclr, wMARclr; //Clear flags
	wire wMARload, wACCload, wCCload; //Load flags for regs
	wire [DRamWidth-1:0] wACCout, wMARout; //Register/Memory output
	//PC, SP
	wire wSPsel;
	wire [1:0] wSPctrl, wPCctrl, wPCsel;
	wire [addrSize-1:0] wPCDataIn, wSPDataIn, wSPout, wPCout;
	//IR
	wire [IRWidth-1:0] wIRout;
	wire [IRWidth+1:0]  wIRDataIn;
	wire wIRsel, wIRload;
	//ACC
	wire [DRamWidth-1:0] wACCDataIn;
	wire [1:0] wACCsel;
	//MAR
	wire wMARsel;
	wire [addrSize-1:0] wMARDataIn;
	//CC
	wire [ccWidth-1:0] wCCDataIn, wCCout;
	wire wCCsel;
	
	//Controller to RAM
	wire wIRAMclr, wDRAMclr, wDaddrSel, wIsIndirect; 
	wire [1:0] wDMemCtrl, wIMemCtrl; 
	//RAM to Controller
	wire wDRAMDataReady, wIRAMDataReady; 
	//DRAM inputs
	wire [DRamWidth-1:0] wDRAMDataIn;
	wire [addrSize-1:0] wDaddrIn;
	wire [2:0] wWriteSrc;
	
	//Memory output
	wire [IRamWidth-1:0] wIRAMout;
	wire [DRamWidth-1:0] wDRAMout;
	
	//ALU
	wire [2:0] wALUctrl;
	wire [DRamWidth-1:0] wALUin2, wALUout;
	wire wALUsrc;
	//ALU to Controller
	wire wZ, wV;
	
	//HVPI
	wire wIntPending, wLdMask, wLdIntReg, wIntRegclr, wMaskclr, wIntDisable, wPendclr;
	wire [addrSize-1:0] wIsrAddr;
	//FIGURE OUT COMMENCE DATA VARIABLES...
	//Does IR into controller come from IR or directly from read?
	assign tmpIRout = wIRAMout[IRamWidth-3:IRamWidth-IRWidth-2];
	assign tmpPCout = wPCout;
	assign tmpDataReady = wIRAMDataReady;
	assign tmpIRAMout = wIRAMout;
	assign IRAMcntrlTEMP = wIMemCtrl;
	assign tmpIRAMState = wIRAMState;

	ControllerSeq theController(
		.ir(wIRAMout[IRamWidth-3:IRamWidth-IRWidth-2]),//13:8 {opcode,addrMode}
		.intPending(wIntPending),
		.clk(clk), 
		.dataReady(wDRAMDataReady), 
		.instReady(wIRAMDataReady), 
		.inDataReady(inDataReady), 
		.restart(reset), 
		.Z(wZ), 
		.outDataSent(outACK),//END of inputs
		.ACCld(wACCload), //Begin single bit outputs 
		.ACCclr(wACCclr), 
		.IRld(wIRload), 
		.IRclr(wIRclr), 
		.IRin(wIRsel), 
		.MARin(wMARsel),
		.MARclr(wMARclr), 
		.MARld(wMARload), 
		.CCld(wCCload), 
		.CCclr(wCCclr),
	    .CCin(wCCsel), 
		.indirect(wIsIndirect), 
		.addrSrc(wDaddrSel), 
		.ldMask(wLdMask), 
		.clrMask(wMaskclr), 
		.ldIntReg(wLdIntReg), 
		.clrIntReg(wIntRegclr), 
		.intDisable(wIntDisable),
	    .clrPend(wPendclr), 
		.DRAMclr(wDRAMclr), 
		.IRAMclr(wIRAMclr), 
		.devACK(inACK), 
		.outDataReady(outDataReady), 
		.ALUsrc(wALUsrc), // End of single bit outputs
		.ACCin(wACCsel), //Begin 2 bit outputs
		.PCctrl(wPCctrl), 
		.SPctrl(wSPctrl), 
		.dataCacheCtrl(wDMemCtrl), 
		.instCacheCtrl(wIMemCtrl), 
		.PCin(wPCsel), //End of 2 bit outputs
		.writeSrc(wWriteSrc), //Begin 3 bit outputs 
		.ALUctrl(wALUctrl),
		.currState(currState)
	);
	
	
	memoryModule #(.addrSize(addrSize), .ramWidth(IRamWidth)) InstructionRAM(
		.clk(clk), //1 bit inputs 
		.clrRAM(/*wIRAMclr*/1'b1), 
		.isIndirect(1'b0), 
		.cntrl(2'b10/*wIMemCtrl*/), // 2 bit input
		.addr(8'b00000000/*wPCout*/), //addrSize input
		.dataIn({dummyVal, dummyVal}), //ramSize input
		.dataOut(wIRAMout), //ramSize output
		.dataReady(wIRAMDataReady), // 1 bit output
		.tmpCacheState(wIRAMState),
		.tmpCacheAddr(tmpIRAMCacheAddr)
	);	
	
	memoryModule #(.addrSize(addrSize), .ramWidth(DRamWidth)) DataRAM(
		.clk(clk), //1 bit inputs 
		.clrRAM(wDRAMclr), 
		.isIndirect(wIsIndirect), 
		.cntrl(wDMemCtrl), // 2 bit input
		.addr(wDaddrIn), //addrSize input
		.dataIn(wDRAMDataIn), //ramSize input
		.dataOut(wDRAMout), //ramSize output
		.dataReady(wDRAMDataReady), // 1 bit output
		.tmpCacheState(wDRAMState),
		.tmpCacheAddr(tmpDRAMCacheAddr)
	);
	
	mux2x1 #(.size(DRamWidth)) dAddrMux(
		.sel(wDaddrSel),
		.inputVal({wSPout, wMARout}), //size *2 input (1 selects MSB input)
		.y(wDaddrIn) //output of size
	);
	
	mux8x1 #(.size(DRamWidth)) DRAMDataInMux(
		.sel(wWriteSrc),
		.inputVal({dummyVal, dummyVal, dummyVal, wMARout, {wCCout, wIRout}, wSPout, wPCout, wACCout}), //size *8 input ({111, 110, 101, 100, 011, 010, 001, 000})
		.y(wDRAMDataIn) //output of size
	);
	
	
	LdStrReg #(.n(IRWidth)) IR(
		.in(wIRDataIn[IRWidth-1:0]), //n size input
		.clr(wIRclr), //1 bit input 
		.clk(clk), //1 bit input
		.load(wIRload),//1 bit input
		.out(wIRout) //n bit size output
	);

	mux2x1 #(.size(IRWidth+2)) IRInMux(
		.sel(wIRsel),
		.inputVal({wIRAMout[IRamWidth-1:IRamWidth-(IRWidth+2)], wDRAMout[IRWidth+1:0]}), //Added 2 bits to mux input width for extra unused 2 bits of opcode
		.y(wIRDataIn) //output of size
	);

		
	LdStrReg #(.n(addrSize)) MAR(
		.in(wMARDataIn), //n size input
		.clr(wMARclr), //1 bit input 
		.clk(clk), //1 bit input
		.load(wMARload),//1 bit input
		.out(wMARout) //n bit size output
	);
	
	mux2x1 #(.size(addrSize)) MARinMux(
		.sel(wMARsel),
		.inputVal({wDRAMout, wIRAMout[addrSize-1:0]}), //size *2 input ({1, 0})
		.y(wMARDataIn) //output of size
	);
	
	
	ALU #(.n(DRamWidth)) ALU(
		.cntrl(wALUctrl), //3 bit input
		.in1(wACCout),// n bit input in1 is the side which should take ACC input
		.in2(wALUin2), //n bit input
		.out(wALUout), //n bit output
		.V(wV), //1 bit output begin
		.Z(wZ), 
		.cout() //1 bit output end	
	);
	
	mux2x1 #(.size(DRamWidth)) ALUInMux(
		.sel(wALUsrc),
		.inputVal({wDRAMout, wMARout}), //size *2 input (1 selects MSB input)
		.y(wALUin2) //output of size
	);
	
	
	LdStrReg #(.n(DRamWidth)) ACC(
		.in(wACCDataIn), //n size input
		.clr(wACCclr), //1 bit input 
		.clk(clk), //1 bit input
		.load(wACCload),//1 bit input
		.out(wACCout) //n bit size output
	);
	
	// TEMP
	assign tmpACCout = wACCout;
	
	mux4x1 #(.size(DRamWidth)) ACCinMux(
		.sel(wACCsel),
		.inputVal({wMARout, wALUout, wDRAMout, in}), //size *2 input ({11, 10, 01, 00})
		.y(wACCDataIn) //output of size
	);
	
	
	LdStrReg #(.n(ccWidth)) CC(
		.in(wCCDataIn), //n size input
		.clr(wCCclr), //1 bit input 
		.clk(clk), //1 bit input
		.load(wCCload),//1 bit input
		.out(wCCout) //n bit size output
	);
	
	mux2x1 #(.size(ccWidth)) CCinMux(
		.sel(wCCsel),
		.inputVal({wDRAMout[DRamWidth-1:DRamWidth-ccWidth], wV, wZ}), //size *2 input (1 selects MSB input)
		.y(wCCDataIn) //output of size
	);
	
	IncrReg #(.n(addrSize)) PC(
		.in(wPCDataIn), //n size input
		.clk(clk), //1 bit input
		.ctrl(wPCctrl),//2 bit input
		.out(wPCout) //n bit size output
	); 
	
	mux4x1 #(.size(addrSize)) PCinMux(
		.sel(wPCsel),
		.inputVal({dummyVal, wMARout, wIsrAddr, wDRAMout}), //size *2 input ({11, 10, 01, 00})
		.y(wPCDataIn) //output of size
	);
	
	
	SPReg #(.n(addrSize)) SP(
		.clk(clk), //1 bit input
		.ctrl(wSPctrl),//2 bit input
		.out(wSPout) //n bit size output
	);
	

	HVPISys #(.pcWidth(8), .addrLen(2)) HVPI(
		.clrPend(wPendclr),         // Clear the DFF storing whether there's a pending interrupt
		.intDisable(wIntDisable),   // Disable any interrupts
		.clk(clk),
		.ints(4'b0000),    				// Interrupt flags 2**addrLen
		.intMask(wDRAMout[3:0]), 				// Interrupt masks 2**addrLen
		.ldMask(wLdMask),
		.clrMask(wMaskclr),         // Control Mask reg
		.ldIntReg(wLdIntReg), 
		.clrIntReg(wIntRegclr),     // Control Interrupt reg
		.isrAddr(wIsrAddr),   		// Output ISR address PC width
		.intPending(wIntPending)
	); 

endmodule 