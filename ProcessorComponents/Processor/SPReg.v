`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:51:08 04/19/2013 
// Design Name: 
// Module Name:    SPReg 
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
module SPReg #(
    parameter n = 8) (
    input clk,
    input [1:0] ctrl,
    output reg [n-1:0] out);

    always @(posedge clk) begin
        case(ctrl)
           2'b00: out <= out;     	// Store
           2'b01: out <= 0;       	// Clear
           2'b10: out <= out + 1;  // Increment by 1
           2'b11: out <= out - 1;  // Decrement by 1
        endcase
    end
endmodule 