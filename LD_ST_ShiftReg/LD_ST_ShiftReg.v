`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
// 
// Create Date:    22:23:15 02/16/2013 
// Design Name: 
// Module Name:    LD_ST_ShiftReg 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module LD_ST_ShiftReg(out, cntrl, inLS, inRS, set, clr, clk, in);
	parameter n=4;
	input inLS, inRS, set, clr, clk;
	input [1:0] cntrl;
	input [n-1:0] in;
	output reg [n-1:0] out;
	integer i = 0;
	
	always@ (posedge clk)
	begin
		if(~clr) out <= 0;
		else if(~set) begin
			for(i = 0; i<n; i=i+1)
			begin
				out[i] <= 1'b1;
			end			
		end
		else
		begin
			case(cntrl)
				2'b00: begin // Store
					out <= out;
				end
				2'b01: begin // Load in parallel
					out <= in;
				end
				2'b10: begin // Left shift one bit
					out <= out << 1;
					out[0] <= inLS;
				end
				2'b11: begin // Right shift one bit
					out <= out >> 1;
					out[n-1] <= inRS;
				end
			endcase
		end
	end

endmodule
