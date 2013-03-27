`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky	
// Engineer: Jonathan Lutz
//
// Create Date:   23:50:14 03/19/2013
// Design Name:   contOneHotEncodedController
// Module Name:   E:/Documents/EE480/contOneHotEncodedController/contOneHotEncodedController_vtf.v
// Project Name:  contOneHotEncodedController
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: contOneHotEncodedController
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module contOneHotEncodedController_vtf;

	parameter stateA = 7'b1000000, stateB = 7'b0100000, stateC = 7'b0010000,
			  stateD = 7'b0001000, stateE = 7'b0000100, stateF = 7'b0000010, 
			  stateG = 7'b0000001;
					
	parameter cpA = 5'b00110, cpB = 5'b10101, cpC = 5'b01110, cpD = 5'b11001,
			  cpE = 5'b01101, cpF = 5'b01000, cpG = 5'b10001;
					
	// Inputs
	reg V, Z, start, clr, clk;

	// Outputs
	wire [4:0] cp;
	wire [6:0] presState;
	reg  [4:0] cp_tc;
	reg  [6:0] presState_tc;
	reg  [10:0] counter;
	reg error;

	// Instantiate the Unit Under Test (UUT)
	contOneHotEncodedController uut (
		.cp(cp), 
		.V(V),
		.Z(Z),
		.start(start), 
		.clr(clr), 
		.clk(clk), 
		.presState(presState)
	);

	initial begin
		// Initialize Inputs
		V = 0;
		Z = 0;
		error = 0;
		start = 0;
		clr = 1'b1;
		clk = 0;
		cp_tc = 0;
		presState_tc = 0;
		counter = 0;

		// Wait 100 ns for global reset to finish
		#100;
    end
	  
	always begin
		#5 clk = ~clk;
	end
	  
	always begin
		#10 counter = counter+1;
		clr = ~counter[10];
		if(counter <= 1) start = 1'b1;
		else start = 0;
		V = counter[1];
		Z = counter[0];
	end
	
	always@(posedge clk)
	begin
		if(clr == 1'b0) begin
			presState_tc = 7'b0000000;
			cp_tc = 5'b00000;
		end
		else if(start == 1'b1)
		begin
			presState_tc = stateA;
			cp_tc = cpA;
		end
		else
		begin
			if(presState_tc == stateA)
			begin
				if({V,Z} == 2'b00)
				begin
					presState_tc = stateA;
					cp_tc = cpA;
				end
				else if({V,Z} == 2'b01)
				begin
					presState_tc = stateC;
					cp_tc =  cpC;
				end
				else if({V,Z} == 2'b10)
				begin
					presState_tc = stateG;
					cp_tc = cpG;
				end
				else if({V,Z} == 2'b11)
				begin
					presState_tc = stateD;
					cp_tc =  cpD;
				end
				else
				begin
					presState_tc = 0;
					cp_tc = 0;
				end
			end
			
			else if(presState_tc == stateB)
			begin
				if({V,Z} == 2'b00)
				begin
					presState_tc = stateD;
					cp_tc = cpD;
				end
				else if({V,Z} == 2'b01)
				begin
					presState_tc = stateA;
					cp_tc =  cpA;
				end
				else if({V,Z} == 2'b10)
				begin
					presState_tc = stateF;
					cp_tc = cpF;
				end
				else if({V,Z} == 2'b11)
				begin
					presState_tc = stateA;
					cp_tc =  cpA;
				end
				else
				begin
					presState_tc = 0;
					cp_tc = 0;
				end
			end
			
			else if(presState_tc == stateC)
			begin
				if({V,Z} == 2'b00)
				begin
					presState_tc = stateB;
					cp_tc = cpB;
				end
				else if({V,Z} == 2'b01)
				begin
					presState_tc = stateC;
					cp_tc =  cpC;
				end
				else if({V,Z} == 2'b10)
				begin
					presState_tc = stateE;
					cp_tc = cpE;
				end
				else if({V,Z} == 2'b11)
				begin
					presState_tc = stateD;
					cp_tc =  cpD;
				end
				else
				begin
					presState_tc = 0;
					cp_tc = 0;
				end
			end
			
			else if(presState_tc == stateD)
			begin
				if({V,Z} == 2'b00)
				begin
					presState_tc = stateF;
					cp_tc = cpF;
				end
				else if({V,Z} == 2'b01)
				begin
					presState_tc = stateG;
					cp_tc =  cpG;
				end
				else if({V,Z} == 2'b10)
				begin
					presState_tc = stateF;
					cp_tc = cpF;
				end
				else if({V,Z} == 2'b11)
				begin
					presState_tc = stateA;
					cp_tc =  cpA;
				end
				else
				begin
					presState_tc = 0;
					cp_tc = 0;
				end
			end
			
			else if (presState_tc == stateE)
			begin
				if({V,Z} == 2'b00)
				begin
					presState_tc = stateB;
					cp_tc = cpB;
				end
				else if({V,Z} == 2'b01)
				begin
					presState_tc = stateE;
					cp_tc =  cpE;
				end
				else if({V,Z} == 2'b10)
				begin
					presState_tc = stateG;
					cp_tc = cpG;
				end
				else if({V,Z} == 2'b11)
				begin
					presState_tc = stateB;
					cp_tc =  cpB;
				end
				else
				begin
					presState_tc = 0;
					cp_tc = 0;
				end
			end
			
			else if(presState_tc == stateF)
			begin
				if({V,Z} == 2'b00)
				begin
					presState_tc = stateA;
					cp_tc = cpA;
				end
				else if({V,Z} == 2'b01)
				begin
					presState_tc = stateB;
					cp_tc =  cpB;
				end
				else if({V,Z} == 2'b10)
				begin
					presState_tc = stateD;
					cp_tc = cpD;
				end
				else if({V,Z} == 2'b11)
				begin
					presState_tc = stateE;
					cp_tc =  cpE;
				end
				else
				begin
					presState_tc = 0;
					cp_tc = 0;
				end
			end
			
			else if(presState_tc == stateG)
			begin
				if({V,Z} == 2'b00)
				begin
					presState_tc = stateG;
					cp_tc = cpG;
				end
				else if({V,Z} == 2'b01)
				begin
					presState_tc = stateF;
					cp_tc =  cpF;
				end
				else if({V,Z} == 2'b10)
				begin
					presState_tc = stateC;
					cp_tc = cpC;
				end
				else if({V,Z} == 2'b11)
				begin
					presState_tc = stateE;
					cp_tc =  cpE;
				end
				else
				begin
					presState_tc = 0;
					cp_tc = 0;
				end
			end
			
			else
			begin
				presState_tc = 0;
				cp_tc = 0;
			end
			
			#1 if(presState_tc == presState && cp_tc == cp) error = 0;
			else error = 1;		
		end
	end        
endmodule

