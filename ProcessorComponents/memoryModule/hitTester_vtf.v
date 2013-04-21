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

module hitTester_vtf;

	// Inputs
	reg [21:0] counter;
	reg clk;
	reg clrRAM;
	reg isIndirect;

	reg [1:0] cntrl;
	reg [7:0] addr;
	reg [7:0] lockAddr;
	reg [15:0] dataIn;

	// Outputs
	wire [15:0] dataOut;
	reg [15:0] dataOut_tc;
	wire dataReady;
	wire [18:0] TEMPstateTEMP;
	wire [1:0] hitCleanTEMP;
	wire [7:0] wCacheAddr;

	reg error;

	// Instantiate the Unit Under Test (UUT)
	memoryModule uut (
		.clk(clk), 
		.clrRAM(clrRAM), 
		.isIndirect(isIndirect), 
		.cntrl(cntrl), 
		.addr(addr), 
		.dataIn(dataIn), 
		.dataOut(dataOut),
		.dataReady(dataReady),
		.TEMPstateTEMP(TEMPstateTEMP),
		.hitCleanTEMP(hitCleanTEMP),
		.wCacheAddr(wCacheAddr)
	);

	initial begin
		// Initialize Inputs
		counter = 0;
		clk = 0;
		clrRAM = 0;
		isIndirect = 0;
		cntrl = 0;
		addr = 0;
		dataIn = 0;
		dataOut_tc = 0;
		error = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
		//write sequence
		#5 counter <= counter + 1;
		clrRAM <= ~counter[17];
		isIndirect <= counter[16];
		cntrl <= ~counter[15:14];
		addr[7:4] <= counter[13:9];
		addr[3:0] <= counter[7:4];
		dataIn <= ~{counter[13:9],counter[7:4]};		
		clk <= counter[0];
	end
	
	//always @(posedge clk) begin
		//if (state == 19'b1000000000000000000)
		//	lockAddr = addr;
	//end
	always @(negedge clk) begin
		if (TEMPstateTEMP == 19'b1000000000000000000)
			lockAddr = addr;
		if(dataReady == 1'b1 && isIndirect == 1'b0)
			dataOut_tc = ~lockAddr; // This is for pseudo automation do not be alarmed if you see error high, just investigate further
		else if(dataReady == 1'b1 && isIndirect == 1'b1)
			dataOut_tc = lockAddr;
		#5 if(dataReady == 1'b1 && dataOut_tc != dataOut) error = 1;
		else error = 0;
	end
	
endmodule

