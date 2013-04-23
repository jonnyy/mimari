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
					regArray[i][j] = 1'b0; 
				end
			end
		end
		else begin
			//regArray[0]  = 16'b0010100000001100; //LD #12
			//regArray[1]  = 16'b0010111000001000; //ST 8
			//regArray[2]  = 16'b0010100000000011; //LD #3
			//regArray[3]  = 16'b0000000000000011; //ADD #3
			//regArray[4]  = 16'b0010111000000101; //ST 5
			//regArray[5]  = 16'b0010100000001000; //LD #8
			//regArray[6]  = 16'b0010111000000110; //ST 6
			//regArray[7]  = 16'b0010101000000101; //LD 5
			//regArray[8]  = 16'b0000010000000001; //SUB #1
			//regArray[9]  = 16'b0001110000001100; //brz #12
			//regArray[10] = 16'b0010001000000110; //jmp 6
			//regArray[11] = 16'b0010100000001101; //LD #13
			//regArray[12] = 16'b0000000000000011; //ADD #3
			//regArray[13] = 16'b0010111000000101; //Store to address 0
			//regArray[14] = 16'b0010000000001110; //jmp #14
			
				regArray[0] = 16'b0011100000001111;
				regArray[1] = 16'b0010100010000000;
				regArray[2] = 16'b0000000010000000;
				regArray[3] = 16'b0010100000000001;
				regArray[4] = 16'b0010111000101000;
				regArray[5] = 16'b0010100000101000;
				regArray[6] = 16'b0010111000000000;
				regArray[7] = 16'b0010100001111111;
				regArray[8] = 16'b0000001100000000;
				regArray[9] = 16'b0010101100000000;
				regArray[10] = 16'b0010111000000000;
				regArray[11] = 16'b0010000000001011;

/*
				regArray[0] = 16'b0010100001100100;
				regArray[1] = 16'b0000000000000001;
				regArray[2] = 16'b0010111000110010;
				regArray[3] = 16'b0011110000000110;
				regArray[4] = 16'b0000000000000001;
				regArray[5] = 16'b0010000000000101;
				regArray[6] = 16'b0010101000110010;
				regArray[7] = 16'b0000000000000001;
				regArray[8] = 16'b0010111000110010;
				regArray[9] = 16'b0010011000000000;
*/

/*			for(i=12; i<240; i=i+1) begin
				for(j=0; j<width; j=j+1) begin
					regArray[i][j] = 1'b1; 
				end
			end
*/			// Interrupt 0 (VZ)
			regArray[240] = 16'b0001110011110010;
			regArray[241] = 16'b0010000011110011;
			regArray[242] = 16'b0000000000000001;
			regArray[243] = 16'b0010010100000000;
			
			// Interrupt 1 (V)
			regArray[244] = 16'b0010100000000000;
			regArray[245] = 16'b0000000000000001;
			regArray[246] = 16'b0010111010000000;
			regArray[247] = 16'b0010010100000000;

			// Interrupt 2 (IN)
			regArray[248] = 16'b0011000100000000;
			regArray[249] = 16'b0010111001111000;
			regArray[250] = 16'b0010101001111000;
			regArray[251] = 16'b0010010100000000;

			// Interrupt 3 (OUT)
			regArray[252] = 16'b0010101001111000;
			regArray[253] = 16'b0000000000000001;
			regArray[254] = 16'b0010111001111000;
			regArray[255] = 16'b0010010100000000;

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
