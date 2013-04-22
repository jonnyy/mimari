`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:17:25 04/12/2013 
// Design Name: 
// Module Name:    DMCache 
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
module DMCache(cntrl, clk, addr, dataIn, dataOut, isHit, isClean, dataOutRAM, addrOutRAM, isDirtyWrite/*, hitCleanTEMP*/);
	parameter blocksize = 1;
	parameter ramWidth = 8; //These need to be used to set up reg array
	parameter addrWidth = 8;
	parameter lineSize = 14; //These need to be used to set up reg array
	parameter blockAddrBits = 4;
	
	input [1:0] cntrl;
	input clk, isDirtyWrite;
	input [ramWidth-1:0] dataIn; //Should maybe simplify to only be one thing for address instead of two kinds of addresses???
	input [addrWidth-1:0] addr;
	output reg[ramWidth-1:0] dataOut;
	output reg isHit, isClean;
	//Outputs to RAM
	output reg [ramWidth-1:0] dataOutRAM;
	output reg [addrWidth-1:0] addrOutRAM;
	//output reg [1:0] hitCleanTEMP;
	
	integer i; // Used for clearing cache
	integer j;
	reg [lineSize-1:0] regArray [(2**blockAddrBits)-1:0];
	
	initial begin
		for(i=0; i<2**blockAddrBits; i=i+1) begin
			for(j=0; j<lineSize; j=j+1) begin
				if(j==lineSize-2) regArray[i][j] = 1'b0;
				else regArray[i][j] = 1'b1;
			end
		end
	end
		

	always @(negedge(clk)) begin
		case(cntrl) 
			2'b00: begin //CLR
			for(i=0; i<2**blockAddrBits; i=i+1) begin
			for(j=0; j<lineSize; j=j+1) begin
				if(j==lineSize-2) regArray[i][j] <= 1'b0;
				else regArray[i][j] <= 1'b1;
			end
		end
			end	
			2'b01: begin //Check Status
				if((regArray[addr[blockAddrBits-1:0]][lineSize-3:ramWidth] == addr[addrWidth-1:blockAddrBits]) && (regArray[addr[blockAddrBits-1:0]][lineSize-1] != 1'b1) ) begin //HIT!!!
					isHit <= 1'b1;
				end
				else begin // MISS!!!
					isHit <= 1'b0;
				end
				isClean <= ~regArray[addr[blockAddrBits-1:0]][lineSize-2];
				addrOutRAM <= {regArray[addr[blockAddrBits-1:0]][lineSize-3:ramWidth], addr[blockAddrBits-1:0]};
				dataOutRAM <= regArray[addr[blockAddrBits-1:0]][ramWidth-1:0];
			end
			2'b10: begin //READ
				dataOut <= regArray[addr[blockAddrBits-1:0]][ramWidth-1:0];
			end
			2'b11: begin //WRITE
				regArray[addr[blockAddrBits-1:0]] <= {1'b0, isDirtyWrite, addr[addrWidth-1:blockAddrBits], dataIn};
			end
		endcase
		//hitCleanTEMP <= {isHit, isClean};
	end
endmodule
