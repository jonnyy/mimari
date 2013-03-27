`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
//
// Create Date:   12:28:03 02/03/2013
// Design Name:   dec_para_enable
// Module Name:   L:/EE480/dec_para_enable/dec_para_enableTest.v
// Project Name:  dec_para_enable
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: dec_para_enable
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module decParamEnable_vtf;

	parameter n=2;
	reg [n:0] counter;
		// Outputs
	reg error;
	reg [((2**n)-1):0] d_tc;
	wire [((2**n)-1):0] d;

	// Instantiate the Unit Under Test (UUT)
	decParamEnable uut (
		.in(counter[(n-1):0]),
		.enable(counter[n]),
		.d(d[((2**n)-1):0])
	);

	initial begin
		// Initialize Inputs
		counter = 0;
		d_tc = 0;
		error = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always 
	begin
	#25 counter = counter+1;
	if(counter[2]) begin
		if(counter[1:0] == 2'b00)
			d_tc = 4'b0001;	
		else if(counter[1:0] == 2'b01)
			d_tc=4'b0010;
		else if(counter[1:0] == 2'b10)
			d_tc=4'b0100;
		else if(counter[1:0] == 2'b11)
			d_tc=4'b1000;
		end
	else
		d_tc=4'b0000;
		
	#1 if(d == d_tc) error=0;
		else error=1;
	end     
endmodule
