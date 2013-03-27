`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
//
// Create Date:   17:48:10 01/29/2013
// Design Name:   mux_4x1_behav
// Module Name:   L:/EE480/mux_4x1_behav/mux_4x1_behav_Test.v
// Project Name:  mux_4x1_behav
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mux_4x1_behav
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mux4x1_vtf;

	//Inputs for testing
	reg [5:0] counter;

	// Outputs
	wire y;

	// Instantiate the Unit Under Test (UUT)
	mux4x1 uut (
		.sel(counter[5:4]), 
		.inputVal(counter[3:0]), 
		.y(y)
	);

	initial begin
		// Initialize Inputs
		counter = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always
	begin
		#50 counter = counter + 1; //Incrementing counter
	end
      
endmodule

