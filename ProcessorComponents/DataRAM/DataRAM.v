`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:08:08 04/06/2013 
// Design Name: 
// Module Name:    DataRAM 
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
module DataRAM #(
    parameter width = 8,
    parameter length = 8) (
    input indirect, writeEnable, readEnable, clr, clk,
    input [length-1:0] addr
    input [width-1:0] writeData,
    output reg dataReady
    output reg [width-1:0] readData);

    reg [width-1:0] regArray [2**length-1:0];

    always @(posedge clk) begin
        // Clear everything in data RAM
        if(clr == 0) begin:clear
            integer i;
            for(i=0; i<2**length; i=i+1)
                regArray[i] <= 0;
        end

        // Write to RAM
        else if(writeEnable == 1)
            regArray[addr] <= writeData;

        // Read from RAM
        else if(readEnable == 1) begin
            // Check for indirect read
            if(indirect == 1) begin
                readData <= #10 regArray[regArray[addr]]
                dataReady <= 1;
            end
            // Direct read
            else begin
                readData <= #10 regArray[addr];
                dataReady <= 1;
            end
        end

        // Maintain same output if not reading/writing
        else begin
            readData <= readData
            dataReady <= 0;
        end
    end
endmodule
