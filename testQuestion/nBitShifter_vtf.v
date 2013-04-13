`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:19:21 04/12/2013
// Design Name:   nBitShifter
// Module Name:   E:/Documents/EE480/ProcessorComponents/testQuestion/nBitShifter_vtf.v
// Project Name:  testQuestion
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: nBitShifter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module nBitShifter_vtf;

	// Inputs
	reg [3:0] Fout;
	reg [1:0] c;

	// Outputs
	wire [3:0] shifterOut;
	reg [3:0] shifterOut_tc;
	reg error;

	// Instantiate the Unit Under Test (UUT)
	nBitShifter uut (
		.shifterOut(shifterOut), 
		.Fout(Fout), 
		.c(c)
	);

	initial begin
		// Initialize Inputs
		Fout = 0;
		c = 0;
		error = 0;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin 
		#5 {c, Fout} = {c, Fout} + 1;
		case(c)
			2'b00: shifterOut_tc = Fout << 1;
			2'b01: shifterOut_tc = Fout;
			2'b10: shifterOut_tc = Fout >> 1;
			2'b11: shifterOut_tc = 0;
		endcase
		
		#1 if(shifterOut == shifterOut_tc) error = 0;
		else error = 1;  
	end
endmodule

