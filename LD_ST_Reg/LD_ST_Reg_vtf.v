`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
//
// Create Date:   01:49:44 02/14/2013
// Design Name:   LD_ST_Reg
// Module Name:   E:/Documents/EE480/LD_ST_Reg/LD_ST_Reg_vtf.v
// Project Name:  LD_ST_Reg
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: LD_ST_Reg
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module LD_ST_Reg_vtf;

	// Inputs
	reg [3:0] slIn;
	reg LD_ST, set, clr, clk;

	// Outputs
	wire [3:0] slOut;
	reg [3:0] slOut_tc;
	reg [3:0] prevOut;
	reg error;

	// Instantiate the Unit Under Test (UUT)
	LD_ST_Reg uut (
		.slOut(slOut), 
		.slIn(slIn), 
		.LD_ST(LD_ST), 
		.set(set), 
		.clr(clr), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		slIn = 0;
		LD_ST = 0;
		set = 0;
		clr = 0;
		clk = 0;
		prevOut = 0;
		error = 0;
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
		for(c=0; c< 64; c=c+1)
		begin: count
			#20 clr <= ~((~c[5]&~c[4]&c[3]&c[2]) | (~c[5]&c[4]&c[3]&c[2]) | (c[5]&c[4]&~c[3]&c[2]) | (~c[5]&~c[4]&~c[3]&~c[2]&c[1]&~c[0]) | (~c[5]&~c[4]&~c[3]&c[2]&c[1]&c[0]));
			set <= ~ ((~c[5]&~c[4]&c[3]&c[2]) | (~c[5]&~c[4]&c[3]&c[2]) | (c[5] &c[4]&c[3]&c[2]) | (c[5] & ~c[4] & ~c[3] & c[2])| (~c[5]&~c[4]&~c[3]&~c[2]&c[1]&c[0]));
			LD_ST <= c[4];
			slIn <= c[3:0];
		end
	end
	
	always @(posedge clk)
	begin

		case({LD_ST, clr, set})
			3'b000: slOut_tc = 4'b0000;
			3'b000: slOut_tc = 4'b0000;
			3'b001: slOut_tc = 4'b0000;
			3'b001: slOut_tc = 4'b0000;
			3'b010: slOut_tc = 4'b1111;
			3'b010: slOut_tc = 4'b1111;
			3'b011: slOut_tc = prevOut;
			3'b011: slOut_tc = prevOut;
			3'b100: slOut_tc = 4'b0000;
			3'b100: slOut_tc = 4'b0000;
			3'b101: slOut_tc = 4'b0000;
			3'b101: slOut_tc = 4'b0000;
			3'b110: slOut_tc = 4'b1111;
			3'b110: slOut_tc = 4'b1111;
			3'b111: slOut_tc = slIn;
			3'b111: slOut_tc = slIn;
			default: slOut_tc = 4'bZZZZ;
		endcase
		
		#1 if(slOut_tc == slOut) error = 0;
		else error = 1;
		#1 prevOut = slOut_tc;
	end
      
endmodule

