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
module DMCache(readWrite, addr, dataIn, clk, clr, dataOut, ackRAM, dataInRAM, dataOutRAM, addrOutRAM, readWriteRAM, synRAM);
	parameter blocksize = 1;
	parameter ramWidth = 8; //These need to be used to set up reg array
	parameter addrWidth = 8;
	parameter lineSize = 13; //These need to be used to set up reg array
	parameter blockAddrBits = 4;
	
	input readWrite, clk, clr; // read if 0 write if 1
	input [ramWidth-1:0] addr, dataIn; //Should maybe simplify to only be one thing for address instead of two kinds of addresses???
	output reg[ramWidth-1:0] dataOut;
	
	//Inputs/Outputs to and from RAM
	input ackRAM;
	input [ramWidth-1:0] dataInRAM;
	output reg [ramWidth-1:0] dataOutRAM;
	output reg [addrWidth-1:0] addrOutRAM;
	output reg synRAM;
	
	integer i; // Used for clearing cache
	reg [lineSize-1:0] regArray [(2**blockAddrBits)-1:0];
	

	always @(negedge(clk))
	begin	
		if(~clr) 
		begin
			for(i=0; i<2**blockAddrBits; i=i+1)
			begin
				regArray[i] <= 0;
			end
		end				
		else if(readWrite==1'b1)
		begin
			if(regArray[addr[ramWidth-1:blockAddrBits]][lineSize-2:ramWidth] == addr[ramWidth-1:blockAddrBits]) begin //HIT!!!
				regArray[addr[ramWidth-1:blockAddrBits]] <= {1'b1, addr[addrWidth-1:blockAddrBits], dataIn}; //Address should be the same, but why not assign again to make 1 clean line
//This sets this line of the cache as dirty
			end
			else begin // MISS!!!
				if(regArray[addr[ramWidth-1:blockAddrBits]][lineSize-1] == 1'b0) begin //this means it is clean (not dirty)
					regArray[addr[ramWidth-1:blockAddrBits]] <= {1'b1, addr[addrWidth-1:blockAddrBits], dataIn}; //Makes dirty, addrCheck, and then writes the data
				end
				else begin // This is dirty
					//Implement some logic to write data out to RAM
					addrOutRAM <= {regArray[addr[addrWidth-1:blockAddrBits]][lineSize-2:ramWidth], addr[blockAddrBits-1:0]};
					dataOutRAM <= regArray[addr[addrWidth-1:blockAddrBits]][ramWidth-1:0];
					sendRAM <= 1'b1;					
					//End logic of writing data to RAM
					//FIND WAY TO LOOP UNTIL RAM SENDS ACK
					//regArray[addr[ramWidth-1:blockAddrBits]] <= {1'b1, addr[addrWidth-1:blockAddrBits], dataIn};
				end
			end
		end
		else if(readWrite==1'b0) begin
			if(regArray[addr[ramWidth-1:blockAddrBits]][lineSize-2:ramWidth] == addr[addrWidth-1:blockAddrBits]) begin //HIT!!!
				dataOut <= regArray[addr[addrWidth-1:blockAddrBits]][ramWidth-1:0];
			end
			else begin // MISS!!!
				if(regArray[addr[addrWidth-1:blockAddrBits]][lineSize-1] == 1'b0) begin //this means it is clean (not dirty)
					//implement logic to retrieve data from RAM to this line of the cache
					dataOut <= regArray[addr[addrWidth-1:blockAddrBits]][ramWidth-1:0];
				end
				else begin // This is dirty
					//Implement some logic to write data out to RAM
					readWriteRAM <= 1'b1;
					addrOutRAM <= addr;
					dataOutRAM <= regArray[addr[addrWidth-1:blockAddrBits]][ramWidth-1:0];
					sendRAM <= 1'b1;					
					//End logic of writing data to RAM
					//Implement some logic to write data out to RAM and then load data from RAM to this place of cache
					dataOut <= regArray[addr[addrWidth-1:blockAddrBits]][ramWidth-1:0];
				end
			end			
		end
	end
endmodule


