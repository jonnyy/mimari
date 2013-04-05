`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
// 
// Create Date:    00:56:26 02/12/2013 
// Design Name: 
// Module Name:    LD_ST_Reg 
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
    input ldStr, set, clr, clk,
    output reg [n-1:0] out);

    integer i;

    always @(posedge clk) begin
        // Active-low clr, takes precedence over set or store
        if(clr == 0) out <= 0;

        // Active-low set
        else if(set == 0) begin
            for(i=0; i<n; i=i+1) begin
                out[i] <= 1;
            end
        end

        // Store
        else out <= in;
    end
endmodule
