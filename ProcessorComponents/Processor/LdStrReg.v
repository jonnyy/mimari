`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:48:49 04/05/2013 
// Design Name: 
// Module Name:    LdStrReg 
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
module LdStrReg #(
    parameter n = 8) (
    input [n-1:0] in,
    input clr, clk, load,
    output reg [n-1:0] out);

    always @(negedge clk) begin
        // Active-low clr, has highest priority
        if(clr == 0) out <= 0;

        // Load/Store
        else begin
            // Store
            if(load == 0) out <= out;

            //Load
            else out <= in;
        end
    end
endmodule
