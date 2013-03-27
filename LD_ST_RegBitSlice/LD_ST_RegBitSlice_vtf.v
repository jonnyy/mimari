`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:18:41 02/12/2013
// Design Name:   LD_ST_RegBitSlice
// Module Name:   E:/Documents/EE480/LD_ST_RegBitSlice/LD_ST_RegBitSlice_vtf.v
// Project Name:  LD_ST_RegBitSlice
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: LD_ST_RegBitSlice
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module LD_ST_RegBitSlice_vtf;

	// Inputs
	reg LD_ST, clr, set, slIn, clk, slOut_tc, prevOut, error;

	// Outputs
	wire slOut;

	// Instantiate the Unit Under Test (UUT)
	LD_ST_RegBitSlice uut (
		.slIn(slIn), 
		.LD_ST(LD_ST), 
		.set(set), 
		.clr(clr), 
		.clk(clk), 
		.slOut(slOut)
	);

	initial begin
		// Initialize Inputs
		slIn = 0;
		LD_ST = 0;
		set = 0;
		clr = 0;
		clk = 0;
		error=0;
		
		slOut_tc = 0;
		prevOut = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
	end
	
	always
	begin
		#10 clk = ~clk;
	end
	
	always
	begin: vectorize
		integer c;
		for(c=0; c< 32; c=c+1)
		begin: count
			#20 clr <= ~((~c[4]&~c[3]&c[2]&c[1]) | (~c[4]&c[3]&c[2]&c[1]) | (c[4]&c[3]&~c[2]&c[0]));
			set <= ~ ((~c[4]&~c[3]&c[2]&c[1]) | (~c[4]&~c[3]&c[2]&c[1]) | (c[4] &c[3]&c[2]&c[1]) | (c[4] & ~c[3] & ~c[2] & c[1]));
			LD_ST <= c[3];
			slIn <= c[2];
		end
	end
	
	always @(posedge clk)
	begin

		case({LD_ST, clr, set, slIn})
			4'b0000: slOut_tc = 1'b0;
			4'b0001: slOut_tc = 1'b0;
			4'b0010: slOut_tc = 1'b0;
			4'b0011: slOut_tc = 1'b0;
			4'b0100: slOut_tc = 1'b1;
			4'b0101: slOut_tc = 1'b1;
			4'b0110: slOut_tc = prevOut;
			4'b0111: slOut_tc = prevOut;
			4'b1000: slOut_tc = 1'b0;
			4'b1001: slOut_tc = 1'b0;
			4'b1010: slOut_tc = 1'b0;
			4'b1011: slOut_tc = 1'b0;
			4'b1100: slOut_tc = 1'b1;
			4'b1101: slOut_tc = 1'b1;
			4'b1110: slOut_tc = 1'b0;
			4'b1111: slOut_tc = 1'b1;
			default: slOut_tc = 1'bZ;
		endcase
		
		#1 if(slOut_tc == slOut) error = 0;
		else error = 1;
		#1 prevOut = slOut_tc;
	end
      
endmodule

