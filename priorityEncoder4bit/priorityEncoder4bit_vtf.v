`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky	 
// Engineer: Jonathan Lutz
//
// Create Date:   12:23:47 02/02/2013
// Design Name:   Priority_Encoder_4Input
// Module Name:   L:/EE480/Priority_Encoder_4Input/Priority_Encoder_4InputTest.v
// Project Name:  Priority_Encoder_4Input
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Priority_Encoder_4Input
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module priorityEncoder4bit_vtf;
	// Inputs
	reg [4:0] counter;
	reg error;
	reg [2:0] out_tc;
    reg out_noSig;

	// Outputs
	wire [2:0] out;
    wire noSig;

	// Instantiate the Unit Under Test (UUT)
	priorityEncoder4bit uut (
		.i(counter[3:0]), 
		.enable(counter[4]), 
        .noSig(noSig),
		.out(out)
	);

	initial begin
		// Initialize Inputs
		counter = 0;
		error = 1;
		out_tc = 0;
		// Wait 100 ns for global reset to finish
		#100;
	end
	
	always
	begin
		#25 counter = counter + 1;
		
		case(counter)
			5'b00000:out_tc=0;
			5'b00001:out_tc=0;
			5'b00010:out_tc=0;
			5'b00011:out_tc=0;
			5'b00100:out_tc=0;
			5'b00101:out_tc=0;
			5'b00110:out_tc=0;
			5'b00111:out_tc=0;
			5'b01000:out_tc=0;
			5'b01001:out_tc=0;
			5'b01010:out_tc=0;
			5'b01011:out_tc=0;
			5'b01100:out_tc=0;
			5'b01101:out_tc=0;
			5'b01110:out_tc=0;
			5'b01111:out_tc=0;
			5'b10000:out_tc=0;
			5'b10001:out_tc=4;
			5'b10010:out_tc=5;
			5'b10011:out_tc=5;
			5'b10100:out_tc=6;
			5'b10101:out_tc=6;
			5'b10110:out_tc=6;
			5'b10111:out_tc=6;
			5'b11000:out_tc=7;
			5'b11001:out_tc=7;
			5'b11010:out_tc=7;
			5'b11011:out_tc=7;
			5'b11100:out_tc=7;
			5'b11101:out_tc=7;
			5'b11110:out_tc=7;
			5'b11111:out_tc=7;
			
		endcase
		#1 if(out == out_tc) error = 0;
		else error=1;
	end 
endmodule
