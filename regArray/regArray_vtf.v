`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
//
// Create Date:   19:03:27 02/24/2013
// Design Name:   regArray
// Module Name:   E:/Documents/EE480/regArray/regArray_vtf.v
// Project Name:  regArray
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: regArray
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module regArray_vtf;
	// Inputs
	reg writeEnable, clr, clk;
	reg [3:0] dataIn;
	reg [3:0] readAddr, writeAddr;

	// Outputs
	wire [3:0] dataOut;
	
	reg [9:0] counter;
	reg error;
	reg [3:0] dataOut_tc;

	// Instantiate the Unit Under Test (UUT)
	regArray uut (
		.dataOut(dataOut), 
		.writeEnable(writeEnable), 
		.clr(clr), 
		.dataIn(dataIn), 
		.readAddr(readAddr), 
		.writeAddr(writeAddr), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		{writeEnable, dataIn, readAddr, writeAddr, clk} = 0;
		{counter, error, dataOut_tc} = 0;		
		// Wait 100 ns for global reset to finish
		#100;
	end
	
	always begin
		#5 clk = ~clk;
	end
	
	always begin
		#10 counter = counter+1;
		clr <= ~counter[9]; //Begin clr as 1 in order to avoid prewritten data above
		writeEnable<= ~counter[8]; //begin with write enabled
		writeAddr <= counter[3:0];
		readAddr <= counter[7:4];
		//dataIn <= counter[3:0];
		if(~counter[8]) begin // will write the memory addr into corresponding memory when write is enabled
			dataIn <= counter[3:0];
		end
		else //Test that write is not successful when write is not enabled
			dataIn <= 1;
	end

	always @(negedge clk) begin
		case(clr)
			1'b0: #1 dataOut_tc = 0;
			1'b1: #1 dataOut_tc = readAddr; //If data successfully ran
		endcase		
		
		#1 if(dataOut_tc == dataOut) error=0;
		else error = 1;
	end
endmodule

