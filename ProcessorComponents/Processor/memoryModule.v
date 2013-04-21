`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:20:26 04/14/2013 
// Design Name: 
// Module Name:    memoryModule 
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
module memoryModule #(
	parameter ramWidth = 8,
	parameter addrSize = 8) (
	
	input clk, clrRAM, isIndirect,
	input [1:0] cntrl,
	input [addrSize-1:0] addr,
	input [ramWidth-1:0] dataIn,
	output [ramWidth-1:0] dataOut,
	output dataReady,
	output [18:0] tmpCacheState,
	output [7:0] tmpCacheAddr
	//output [18:0] TEMPstateTEMP,
	//output [1:0] hitCleanTEMP,
	//wire [addrSize-1:0] wCacheAddr
    );
	wire [ramWidth-1:0] wDataRAM;
	wire [addrSize-1:0] wAddrRAM,  wAddr;
	wire [ramWidth-1:0] wRAMOut;
	wire [ramWidth-1:0] wCacheDataIn;
	wire [ramWidth-1:0] wLockedDataIn;
	wire wRAMDataReady;
	wire wIsHit, wIsClean;
	wire [1:0] wCacheCntrl;
	wire wWriteEnRAM, wReadEnRAM;
	wire wDataInSel;
	wire [addrSize-1:0] wCacheAddr;
	
	assign tmpCacheAddr = wCacheAddr;

	DMCache #(.blocksize(1), .ramWidth(ramWidth), .addrWidth(addrSize), .lineSize(ramWidth+5), .blockAddrBits(4)) cache(  
		.cntrl(wCacheCntrl),
		.clk(clk), 
		.addr(wCacheAddr), 
		.dataIn(wCacheDataIn), 
		.dataOut(dataOut), 
		.isHit(wIsHit), 
		.isClean(wIsClean), 
		.dataOutRAM(wDataRAM), 
		.addrOutRAM(wAddrRAM)
		//.hitCleanTEMP(hitCleanTEMP)
	);
					
	DataRAM #(.width(ramWidth), .length(addrSize)) RAM(
		.indirect(isIndirect), 
		.writeEnable(wWriteEnRAM), 
		.readEnable(wReadEnRAM), 
		.clr(clrRAM), 
		.clk(clk), 
		.addr(wAddrRAM), 
		.writeData(wDataRAM), 
		.dataReady(wRAMDataReady), 
		.readData(wRAMOut)
	);
	
	CacheController #(.ramWidth(ramWidth), .addrSize(addrSize)) controller(	
		.dataIn(dataIn),
		.dataReady(wRAMDataReady),
		.ctrl(cntrl),
		.clk(clk),
		.isClean(wIsClean),
		.isHit(wIsHit),
		.indirect(isIndirect),
		.addr(wAddr),
		.dataInSel(wDataInSel),
		.RAMreadEnable(wReadEnRAM),
		.RAMwriteEnable(wWriteEnRAM),
		.cacheIn(wCacheCntrl),
		.outputReady(dataReady),
		.cacheAddr(wCacheAddr),
		//.TEMPstateTEMP(TEMPstateTEMP),
		.addrSel(wAddrInSel),
		.lockedDataIn(wLockedDataIn),
		.currState(tmpCacheState)
	);
								
	mux2x1 #ramWidth dataInSelector (
		.sel(wDataInSel),
		.inputVal({wLockedDataIn, wRAMOut}),
		.y(wCacheDataIn)
	);
									 
	mux2x1 #addrSize addrSelector (
		.sel(wAddrInSel),
		.inputVal({dataOut[addrSize-1:0], addr}),
		.y(wAddr)
	);

endmodule
