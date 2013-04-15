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
	
	input clk, clrRAM, isIndirect, start,
	input [1:0] cntrl,
	input [addrSize-1:0] addr,
	input [ramWidth-1:0] dataIn,
	output [ramWidth-1:0] dataOut
    );
	wire [ramWidth-1:0] wDataRAM;
	wire [addrSize-1:0] wAddrRAM;
	wire [ramWidth-1:0] wRAMOut;
	wire [ramWidth-1:0] wCacheDataIn;
	wire wRAMDataReady;
	wire wIsHit, wIsClean;
	wire [1:0] wCacheCntrl;
	wire wWriteEnRAM, wReadEnRAM;
	wire wDataInSel;
	
	DMCache cache(  .cntrl(wCacheCntrl),
					.clk(clk), 
					.addr(addr), 
					.dataIn(wCacheDataIn), 
					.dataOut(dataOut), 
					.isHit(wIsHit), 
					.isClean(wIsClean), 
					.dataOutRAM(wDataRAM), 
					.addrOutRAM(wAddrRAM));
					
	DataRAM RAM(.indirect(isIndirect), 
				.writeEnable(wWriteEnRAM), 
				.readEnable(wReadEnRAM), 
				.clr(clrRAM), 
				.clk(clk), 
				.addr(wAddrRAM), 
				.writeData(wDataRAM), 
				.dataReady(wRAMDataReady), 
				.readData(wRAMOut));
	
	CacheController controller(	.dataReady(wRAMDataReady),
								.ctrl(cntrl),
								.commence(start),
								.clk(clk),
								.isClean(wIsClean),
								.isHit(wIsHit),
								.indirect(isIndirect),
								.dataInSel(wDataInSel),
								.RAMreadEnable(wReadEnRAM),
								.RAMwriteEnable(wWriteEnRAM),
								.cacheIn(wCacheCntrl));
								
	mux2x1 #ramWidth dataInSelector (.sel(wDataInSel),
									 .inputVal({dataIn, wRAMOut}),
									 .y(wCacheDataIn));

endmodule
