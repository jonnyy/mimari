`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:25:38 04/06/2013 
// Design Name: 
// Module Name:    IncrReg 
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
module IncrReg #(
    parameter n = 8) (
    input clk,
    input [1:0] ctrl,
    input [n-1:0] in,
    output reg [n-1:0] out);
	
	initial begin
		out <= 0;
	end

    always @(negedge clk) begin
        case(ctrl)
            2'b00: out <= out;      // Store
            2'b01: out <= in;       // Load
            2'b10: out <= out + 8'd1;  // Increment by 1
            2'b11: out <= 0;        // Clear
        endcase
    end
endmodule
