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
module DMCache(readWrite, readAddr, writeAddr, dataIn, clk, clr, dataOut);
	parameter blocksize = 1;
	parameter ramWidth = 8; //These need to be used to set up reg array
	parameter lineSize = 13; //These need to be used to set up reg array
	parameter blockAddrBits = 4;
	input readWrite, clk, clr; // read if 0 write if 1
	input [ramWidth-1:0] readAddr, writeAddr, dataIn; //Should maybe simplify to only be one thing for address instead of two kinds of addresses???
	
	output [ramWidth-1:0] dataOut;
	
	integer i; // Used for clearing cache

	reg [lineSize-1:0] regArray [(2**blockAddrBits)-1:0];
	

	always @(negedge(clk))
	begin	
		if(~clr) 
		begin
			for(i=0; i<2**blockAddrBits; i=i+1)
			begin
				regArray[i] = 0;
			end
		end				
		else if(readWrite==1'b1)
		begin
			if(regArray[writeAddr[ramWidth-1:blockAddrBits]][lineSize-2:ramWidth] == writeAddr[ramWidth-1:blockAddrBits]) begin //HIT!!!
				regArray[writeAddr[ramWidth-1:blockAddrBits]] = dataIn;
			end
			else begin // MISS!!!
				if(regArray[writeAddr[ramWidth-1:blockAddrBits]][lineSize-1] == 1'b0) begin //this means it is clean (not dirty)
					regArray[writeAddr[ramWidth-1:blockAddrBits]] = dataIn;
				end
				else begin // This is dirty
					//Implement some logic to write data out to RAM
					regArray[writeAddr[ramWidth-1:blockAddrBits]] = dataIn;
				end
			end
		end
		else if(readWrite==1'b0) begin
			if(regArray[writeAddr[ramWidth-1:blockAddrBits]][lineSize-2:ramWidth] == writeAddr[ramWidth-1:blockAddrBits]) begin //HIT!!!
				dataOut = regArray[writeAddr[ramWidth-1:blockAddrBits]];
			end
			else begin // MISS!!!
				if(regArray[writeAddr[ramWidth-1:blockAddrBits]][lineSize-1] == 1'b0) begin //this means it is clean (not dirty)
					//implement logic to retrieve data from RAM to this line of the cache
					dataOut = regArray[writeAddr[ramWidth-1:blockAddrBits]];
				end
				else begin // This is dirty
					//Implement some logic to write data out to RAM and then load data from RAM to this place of cache
					dataOut = regArray[writeAddr[ramWidth-1:blockAddrBits]];
				end
			end			
		end
	end
	assign dataOut = regArray[readAddr];
endmodule


