`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:29:05 04/20/2013
// Design Name:   Processor
// Module Name:   E:/Documents/EE480/ProcessorComponents/Processor/runProcessor.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Processor
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module runProcessor;

	// Inputs
	reg [7:0] in;
	reg clk;
	reg reset;
	reg inDataReady;
	reg outACK;

	// Outputs
	wire [7:0] out;
	wire outDataReady;
	wire inACK;
	wire [43:0] currState; //TEMP
	wire [7:0] tmpACCout; //TEMP
	wire [5:0] tmpIRout; //TEMP
	wire [7:0] tmpPCout; //TEMP
	wire [7:0] tmpMARout; //TEMP
	wire [1:0] tmpCCout; //TEMP
	wire [7:0] tmpSPout; //TEMP
	wire tmpDataReady; //TEMP
	wire [15:0] tmpIRAMout; //TEMP
	wire [18:0] tmpIRAMState; //TEMP
	wire [7:0] tmpIRAMCacheAddr; //TEMP
	wire [7:0] addrInRAMTEMP;  //TEMP
	wire [1:0] cacheCntrlTEMP; //TEMP
	wire [1:0] tmpAddrMode; //TEMP
	wire [1:0] tmpIRAMctrl; //TEMP


	// Instantiate the Unit Under Test (UUT)
	Processor uut (
		.in(in), 
		.clk(clk), 
		.reset(reset), 
		.inDataReady(inDataReady), 
		.outACK(outACK), 
		.out(out), 
		.outDataReady(outDataReady), 
		.inACK(inACK),
		.currState(currState),
		.addrMode(tmpAddrMode),
		.ACCout(tmpACCout),
		.IRout(tmpIRout),
		.PCout(tmpPCout),
		.MARout(tmpMARout),
		.CCout(tmpCCout),
		.SPout(tmpSPout),
		.IRAMDataReady(tmpDataReady),
		.IRAMout(tmpIRAMout),
		.IRAMctrl(tmpIRAMctrl),
		.InstMemState(tmpIRAMState),
		.IRAMCacheAddr(tmpIRAMCacheAddr),
		.cacheCntrlTEMP(cacheCntrlTEMP)
	);

	initial begin
		// Initialize Inputs
		in = 0;
		clk = 0;
		reset = 0;
		inDataReady = 0;
		outACK = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
		#10 clk = ~clk;
	end
      
endmodule
