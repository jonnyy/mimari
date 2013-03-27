`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz 
// 
// Create Date:    12:10:43 02/02/2013 
// Design Name: 
// Module Name:    Priority_Encoder_4Input 
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
module priorityEncoder4bit(
		input [3:0] i,
		input enable,
		output reg [2:0] out
    );
	 
	 always @ (enable or i)
	 begin
		if(enable)
			if(i[3] == 1)
				out = 3'b111;
			else if(i[2] == 1)
				out = 3'b110;
			else if(i[1] == 1)
				out = 3'b101;
			else if(i[0] == 1)
				out = 3'b100;
			else
				out = 3'b000; //Represents all off
		 else
			out = 3'b000;
		end
endmodule
