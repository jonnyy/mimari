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
	
	input clk,
	input isIndirect,
	input [addrSize-1:0] addr,
	input [ramWidth-1:0] dataIn,
	output [ramWidth-1:0] dataOut
    );
	wire [ramWidth-1:0] wDataRAM;
	wire [addrSize-1:0] wAddrRAM;
	wire [ramWidth-1:0] wRAMOut;
	wire wRAMDataReady;
	wire wIsHit, wIsClean;
	wire [1:0] wCacheCntrl;
	wire wWriteEnRAM, wReadEnRAM;
	
	DMCache cache(.cntrl(wCacheCntrl), .clk(clk), .addr(addr), .dataIn(dataIn), .dataOut(dataOut), .isHit(wIsHit), .isClean(wIsClean), .dataOutRAM(wDataRAM), .addrOutRAM(wAddrRAM));
	DataRAM RAM(.indirect(), .writeEnable(), .readEnable(), .clr(), .clk(), );

	


endmodule
