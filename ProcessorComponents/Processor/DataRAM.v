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
    input writeEnable, readEnable, clr, clk,
    input [length-1:0] addr, readAddr,
    input [width-1:0] writeData,
    output reg dataReady,
    output reg [width-1:0] readData
	);

    reg [width-1:0] regArray [2**length-1:0];
	integer i, j;

	initial begin
		if(width == 8) begin
			for(i=0; i<2**length; i=i+1) begin
				for(j=0; j<width; j=j+1) begin
					regArray[i][j] = 1'b1; 
				end
			end
		end
		else begin
			regArray[0]  = 16'b0010100000001100; //LD #12
			regArray[1]  = 16'b0010111000001000; //ST 8
			regArray[2]  = 16'b0010100000000011; //LD #3
			regArray[3]  = 16'b0000000000000011; //ADD #3
			regArray[4]  = 16'b0010111000000101; //ST 5
			regArray[5]  = 16'b0010100000001000; //LD #8
			regArray[6]  = 16'b0010111000000110; //ST 6
			regArray[7]  = 16'b0010101000000101; //LD 5
			regArray[8]  = 16'b0000010000000001; //SUB #1
			regArray[9]  = 16'b0001111000001000; //brz 8
			regArray[10] = 16'b0010001000000110; //jmp 6
			regArray[11] = 16'b0010100000001101; //LD #13
			regArray[12] = 16'b0000000000000011; //ADD #3
			regArray[13] = 16'b0010111000000101; //Store to address 0
			regArray[14] = 16'b0000000000000000; //ADD #0
			regArray[15] = 16'b0010001000000110; //jmp
			for(i=16; i<2**length; i=i+1) begin
				for(j=0; j<width; j=j+1) begin
					regArray[i][j] = 1'b1; 
				end
			end
		end
	end
    always @(negedge clk) begin
        // Clear everything in data RAM
        if(clr == 0) begin:clear
            for(i=0; i<2**length; i=i+1)
                regArray[i] <= 0;
        end

        // Write to RAM
        else if(writeEnable == 1)
            regArray[addr] <= writeData;

        // Read from RAM
        else if(readEnable == 1) begin
            readData <= #10 regArray[readAddr];
            dataReady <= 1;
        end

        // Maintain same output if not reading/writing
        else begin
            readData <= readData;
            dataReady <= 0;
        end
    end
endmodule
