`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:00:04 02/19/2013
// Design Name:   PC
// Module Name:   E:/Documents/EE480/PC/PC_vtf.v
// Project Name:  PC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PC_vtf;
	integer incVal = 2; //This specifies the increment feature to test for increment of 4

	// Inputs
	reg clr;
	reg clk;
	reg [3:0] loadIn;
	reg [1:0] cntrl;

	// Outputs
	wire [3:0] out;
	
	reg [3:0] out_tc;
	reg error;
	reg [6:0] counter;

	// Instantiate the Unit Under Test (UUT)
	PC uut (
		.out(out), 
		.clr(clr), 
		.clk(clk), 
		.loadIn(loadIn), 
		.cntrl(cntrl)
	);

	initial begin
		// Initialize Inputs
		clr = 0;
		clk = 0;
		loadIn = 0;
		cntrl = 0;
		counter = 0;
		error = 0;
		out_tc = 0;
		// Wait 100 ns for global reset to finish
		#100;
	end
	
	always begin
		#5 clk = ~clk;
	end
	always begin: countAssign
		#10 counter = counter +1;
		clr <= ~counter[6];
		cntrl <= counter[5:4];
		loadIn <= counter[3:0];
	end		
	
	always @(posedge clk) begin
		case({clr, cntrl})
			3'b000: out_tc = 0;
			3'b001: out_tc = 0;
			3'b010: out_tc = 0;
			3'b011: out_tc = 0;
			3'b100: out_tc = out_tc;
			3'b101: out_tc = loadIn;
			3'b110: out_tc = out_tc + 1;
			3'b111: out_tc = out_tc + incVal;
			default: out_tc <= 4'bZZZZ;
		endcase
		#1 if(out_tc == out) error = 0;
		else error = 1;
	end
endmodule

