`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
//
// Create Date:   19:02:59 01/29/2013
// Design Name:   BFA_Gated
// Module Name:   L:/EE480/BFA_Gated/BFA_Gated_test.v
// Project Name:  BFA_Gated
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: BFA_Gated
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module BFA_vtf;

	// Inputs
	reg [2:0] counter;

	// Outputs
	wire so;
	wire co;

	// Instantiate the Unit Under Test (UUT)
	BFA uut (
		.I(counter[1:0]), 
		.ci(counter[2]), 
		.so(so), 
		.co(co)
	);

	initial begin
		// Initialize Inputs
		counter = 0;
		// Wait 100 ns for global reset to finish
		#100;
	end
	always
		begin
			#50 counter = counter + 1;
		end
      
endmodule

