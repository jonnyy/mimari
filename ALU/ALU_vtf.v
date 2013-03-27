`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
//
// Create Date:   00:19:38 02/11/2013
// Design Name:   ALU
// Module Name:   E:/Documents/EE480/ALU/ALU_vtf.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_vtf;

	// Inputs
	reg [2:0] cntrl;
	reg [3:0] a;
	reg [3:0] b;
	reg [3:0] bBar;
	reg [3:0] f_tc;
	reg [3:0] f_temp;
	reg error, cout_tc, v_tc;

	// Outputs
	wire [3:0] f;
	wire cout, v;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.f(f), 
		.cout(cout), 
		.v(v),
		.cntrl(cntrl), 
		.a(a), 
		.b(b) 
	);

	initial begin
		// Initialize Inputs
		cntrl = 0;
		a = 0;
		b = 0;
		bBar = 0;
		f_tc = 0;
		f_temp = 0;
		cout_tc = 0;
		v_tc = 0;
		error = 0;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always
	begin
		#2 {cntrl, a, b} = {cntrl, a, b} + 1;
		#1 bBar = ~b[3:0];
		
		case(cntrl)
			3'b000: begin
				{cout_tc, f_tc} = a+b;
				#1 v_tc = (a[3] & b[3] & ~f_tc[3]) | (~a[3] & bBar[3] & f_tc[3]);
			end
			3'b001: begin
				{cout_tc, f_tc} = a+bBar+1; 
				#1 v_tc = (a[3] & bBar[3] & ~f_tc[3]) | (~a[3] & b[3] & f_tc[3]);
			end
			3'b010: begin
				{cout_tc, f_temp} = a+b;
				f_tc=a|b;
				#1 v_tc = (a[3] & b[3] & ~f_temp[3]) | (~a[3] & ~b[3] & f_temp[3]);
			end
			3'b011: begin
				{cout_tc, f_temp} = a+bBar+1; 
				f_tc=a|~b;
				#1 v_tc = (a[3] & bBar[3] & ~f_temp[3]) | (~a[3] & b[3] & f_temp[3]);
			end
			3'b100: begin
				{cout_tc, f_temp} = a+b;
				f_tc=a&b;
				#1 v_tc = (a[3] & b[3] & ~f_temp[3]) | (~a[3] & bBar[3] & f_temp[3]);
			end
			3'b101: begin
				{cout_tc, f_temp} = a+bBar+1;
				f_tc=a&~b;
				#1 v_tc = (a[3] & bBar[3] & ~f_temp[3]) | (~a[3] & b[3] & f_temp[3]);
			end
			3'b110: begin
				{cout_tc, f_temp} = a+b;
				f_tc=~a[3:0];
				#1 v_tc = (a[3] & b[3] & ~f_temp[3]) | (~a[3] & bBar[3] & f_temp[3]);
			end
			3'b111: begin
				{cout_tc, f_temp} = a+bBar+1; 
				f_tc=bBar;
				#1 v_tc = (a[3] & bBar[3] & ~f_temp[3]) | (~a[3] & b[3] & f_temp[3]);
			end
		endcase	
		
		#1 if(f == f_tc && cout == cout_tc && v_tc == v) error = 0;
		else error = 1;
	end
      
endmodule

