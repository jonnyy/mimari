`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
//
// Create Date:   21:02:25 02/11/2013
// Design Name:   DFlipFlop
// Module Name:   E:/Documents/EE480/DFlipFlop/DFlipFlop_vtf.v
// Project Name:  DFlipFlop
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DFlipFlop
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DFlipFlop_vtf;

	// Inputs
	reg clr, set, D, clk;
	reg Q_tc, Qbar_tc, error;

	// Outputs
	wire Q, Qbar;

	// Instantiate the Unit Under Test (UUT)
	DFlipFlop uut (
		.D(D),		
		.clk(clk),
		.clr(clr),
		.set(set),
		.Q(Q),
		.Qbar(Qbar)
	);

	initial begin
		// Initialize Inputs
		D = 0;
		clk = 0;
		clr = 0;
		set = 0;
		
		Q_tc = 0;
		Qbar_tc = 0;
		error = 0;
					   //in order to account for before value latches
		
		#100;
	end
	always begin
		#10 clk = ~clk;
	end
	
	// Initiation of Test Vectors
	always
	begin: testVectorLoop
		integer c;
		for (c = 0; c<16; c=c+1)
		begin: countLoop
			#20 clr <= ~((~c[3] &~c[2] & c[1] & ~c[0]) | (~c[3] & c[2] & c[1] & ~c[0]) | (~c[3] & c[2] & ~c[1] & c[0]));
			set <= ~((~c[3] &~c[2] & c[1] & ~c[0]) | (~c[3] & c[2] & c[1] & ~c[0]) | (~c[3] & ~c[2] & ~c[1] & c[0]) );
			D <= c[2];
		end
	end
	always @(posedge clk)
	begin
		case({clr, set, D})
			3'b000: {Q_tc, Qbar_tc} = 2'b01;
			3'b001: {Q_tc, Qbar_tc} = 2'b01;
			3'b010: {Q_tc, Qbar_tc} = 2'b01;
			3'b011: {Q_tc, Qbar_tc} = 2'b01;
			3'b100: {Q_tc, Qbar_tc} = 2'b10;
			3'b101: {Q_tc, Qbar_tc} = 2'b10;
			3'b110: {Q_tc, Qbar_tc} = 2'b01;
			3'b111: {Q_tc, Qbar_tc} = 2'b10;
			default: {Q_tc, Qbar_tc} = 2'bZZ;
		endcase
		
		#1 if(Q_tc == Q && Qbar_tc == Qbar) error = 0;
		else error = 1;
	end
      
endmodule

