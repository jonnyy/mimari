`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
//
// Create Date:   18:19:14 01/29/2013
// Design Name:   mux_2x1_rtl
// Module Name:   L:/EE480/mux_2x1_rtl/mux_2x2_rtl_test.v
// Project Name:  mux_2x1_rtl
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mux_2x1_rtl
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mux2x1_vtf;//This should have been named 2x1

	reg [2:0] counter;
	// Outputs
	wire y;

	// Instantiate the Unit Under Test (UUT)
	mux2x1 uut (
		.sel(counter[2]), 
		.inputVal(counter[1:0]), 
		.y(y)
	);

	initial begin
		// Initialize Inputs
		counter = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
		#50 counter = counter + 1;
	end
      
endmodule

