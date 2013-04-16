`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:50:32 04/14/2013
// Design Name:   memoryModule
// Module Name:   E:/Documents/EE480/ProcessorComponents/memoryModule/memoryModule_vtf.v
// Project Name:  memoryModule
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: memoryModule
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module memoryModule_vtf;

	// Inputs
	reg [21:0] counter;
	reg clk;
	reg clrRAM;
	reg start;
	reg isIndirect;

	reg [1:0] cntrl;
	reg [7:0] addr;
	reg [7:0] dataIn;

	// Outputs
	wire [7:0] dataOut;
	wire dataReady;
	wire [12:0] TEMPstateTEMP;
	wire [1:0] hitCleanTEMP;

	// Instantiate the Unit Under Test (UUT)
	memoryModule uut (
		.clk(clk), 
		.clrRAM(clrRAM), 
		.isIndirect(isIndirect), 
		.start(start), 
		.cntrl(cntrl), 
		.addr(addr), 
		.dataIn(dataIn), 
		.dataOut(dataOut),
		.dataReady(dataReady),
		.TEMPstateTEMP(TEMPstateTEMP),
		.hitCleanTEMP(hitCleanTEMP)
	);

	initial begin
		// Initialize Inputs
		counter = 0;
		clk = 0;
		clrRAM = 0;
		isIndirect = 0;
		start = 0;
		cntrl = 0;
		addr = 0;
		dataIn = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
		//write sequence
		#5 counter = counter + 1;
		clrRAM = ~counter[21];
		start = ~counter[20];
		isIndirect = counter[19];
		cntrl = ~counter[11:10];
		addr = counter[9:1];
		dataIn = counter[9:1];		
		clk = counter[0];
	end
      
endmodule

