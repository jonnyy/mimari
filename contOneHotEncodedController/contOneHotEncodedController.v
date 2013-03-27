`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Kentucky
// Engineer: Jonathan Lutz
// 
// Create Date:    22:18:02 03/19/2013 
// Design Name: 
// Module Name:    contOneHotEncodedController 
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

// State Assign			State Table
//						x				Output
// abcdef	presSt		00	01	11	10	cp[4]..cp[0]
// 1000000	   a		a	c	d	g	00110
// 0100000	   b		d	a	a	f	10101
// 0010000	   c		b	c	d	e	01110
// 0001000	   d		f	g	a	f	11001
// 0000100	   e		b	e	b	g	01101
// 0000010	   f		a	b	e	d	01000
// 0000001	   g		g	f	e	c	10001

module contOneHotEncodedController(cp, V, Z, start, clr, clk, presState);
	parameter a=7'b1000000, b=7'b0100000, c=7'b0010000, d=7'b0001000, 
			  e=7'b0000100, f=7'b0000010, g=7'b0000001;
	input clk, start, clr;
	input V,Z;
	
	output reg[4:0] cp;
	output reg [6:0] presState; //After testing this should only be reg
	reg [6:0] nextState;
	
	always @ (V or Z or presState)//To determine Next state
	begin
		case (presState)
			a:	case({V, Z})
					2'b00: nextState = a;
					2'b01: nextState = c;
					2'b10: nextState = g;
					2'b11: nextState = d;
					default: nextState = a;
				endcase
			b:	case({V, Z})
					2'b00: nextState = d;
					2'b01: nextState = a;
					2'b10: nextState = f;
					2'b11: nextState = a;
					default: nextState = a;
				endcase
			c:	case({V, Z})
					2'b00: nextState = b;
					2'b01: nextState = c;
					2'b10: nextState = e;
					2'b11: nextState = d;
					default: nextState = a;
				endcase
			d:	case({V, Z})
					2'b00: nextState = f;
					2'b01: nextState = g;
					2'b10: nextState = f;
					2'b11: nextState = a;
					default: nextState = a;
				endcase
			e:	case({V, Z})
					2'b00: nextState = b;
					2'b01: nextState = e;
					2'b10: nextState = g;
					2'b11: nextState = b;
					default: nextState = a;
				endcase
			f:	case({V, Z})
					2'b00: nextState = a;
					2'b01: nextState = b;
					2'b10: nextState = d;
					2'b11: nextState = e;
					default: nextState = a;
				endcase
			g:	case({V, Z})
					2'b00: nextState = g;
					2'b01: nextState = f;
					2'b10: nextState = c;
					2'b11: nextState = e;
					default: nextState = a;
				endcase
			default: nextState = a;
		endcase
	end
	
	always @(posedge clk) //Synch state change (clear, reset, state transition)
	begin
		if(clr == 1'b0) presState = 7'b0000000;
		else if(start == 1'b1) presState = a;
		else presState = nextState;
	end
	
	always @ (presState) // For the output process
	begin
		case(presState)
			a: cp = 5'b00110;
			b: cp = 5'b10101;
			c: cp = 5'b01110;
			d: cp = 5'b11001;
			e: cp = 5'b01101;
			f: cp = 5'b01000;
			g: cp = 5'b10001;
			default: cp=5'b00000;
		endcase
	end
endmodule
