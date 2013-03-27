`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
// 
// Create Date:    011:23:44 02/03/2013 
// Design Name: 
// Module Name:    dec_para_enable 
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
module decParamEnable(in, enable, d);
	parameter n = 2;
	input [(n-1):0] in;
	input enable;
	output reg [((2**n)-1):0] d;
	integer i;
	
	always @ (in or enable)
	begin
		if(enable == 1'b0)
			for(i=0; i<2**n; i=i+1)
			begin
				d[i]=1'b0;
			end
		else
			for(i=0; i<2**n; i=i+1)
			begin
				if(in==i)
					d[i]=1;
				else
					d[i]=0;
			end
	end
endmodule
