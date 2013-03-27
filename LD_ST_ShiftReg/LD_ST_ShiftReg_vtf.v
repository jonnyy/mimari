`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
//
// Create Date:   23:18:51 02/16/2013
// Design Name:   LD_ST_ShiftReg
// Module Name:   E:/Documents/EE480/LD_ST_ShiftReg/LD_ST_ShiftReg_vtf.v
// Project Name:  LD_ST_ShiftReg
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: LD_ST_ShiftReg
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module LD_ST_ShiftReg_vtf;

	// Inputs
	reg [1:0] cntrl;
	reg inLS;
	reg inRS;
	reg set;
	reg clr;
	reg clk;
	reg [3:0] in;

	// Outputs
	wire [3:0] out;
	
	reg [3:0] out_tc;
	reg error;
	reg [10:0] counter;
	
	//I used these variables to be more confident in my shifting assignment
	//that variables would not have weird temporary states between calculation
	reg [4:0] t_LSCalc; // This are temp varibles to calculate ls expected out
	reg [4:0] t_RSCalc; // This are temp varibles to calculate rs expected out

	// Instantiate the Unit Under Test (UUT)
	LD_ST_ShiftReg uut (
		.out(out), 
		.cntrl(cntrl), 
		.inLS(inLS), 
		.inRS(inRS), 
		.set(set), 
		.clr(clr), 
		.clk(clk), 
		.in(in)
	);

	initial begin
		// Initialize Inputs
		counter = 0;
		clr = 0;
		set = 0;
		cntrl = 0;
		inLS = 0;
		inRS = 0;
		in = 0;
		clk = 0;
		out_tc = 0;
		error = 0;
		t_LSCalc = 0;
		t_RSCalc = 0;
		// Wait 100 ns for global reset to finish
		#100;
	end
	
	always
	begin
		#5 clk = ~clk;
	end
	
	always
	begin: countAssign
		#10 counter = counter+1;
		clr <= ~counter[9];
		set <= ~counter[8];
		cntrl <= counter[7:6];
		inLS <= counter[5];
		inRS <= counter[4];
		in <= counter[3:0];
	end
	
	always @(posedge clk)
	begin
		#1 t_LSCalc = {out_tc, inLS};
		t_RSCalc = {inRS, out_tc};
		case ({clr, set, cntrl})
			4'b0000: out_tc = 4'b0000;
			4'b0001: out_tc = 4'b0000;
			4'b0010: out_tc = 4'b0000;
			4'b0011: out_tc = 4'b0000;
			4'b0100: out_tc = 4'b0000;
			4'b0101: out_tc = 4'b0000;
			4'b0110: out_tc = 4'b0000; 
			4'b0111: out_tc = 4'b0000;
			4'b1000: out_tc = 4'b1111;
			4'b1001: out_tc = 4'b1111;
			4'b1010: out_tc = 4'b1111;
			4'b1011: out_tc = 4'b1111;
			4'b1100: out_tc = out_tc;
			4'b1101: out_tc = in;
			4'b1110: out_tc = t_LSCalc[3:0];
			4'b1111: out_tc = t_RSCalc[4:1]; 
			default: out_tc = 4'bZZZZ;
		endcase
		#1 if(out_tc == out) error = 0;
		else error = 1;
	end
      
endmodule
