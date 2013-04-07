`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:51:34 04/05/2013
// Design Name:   LdStrReg
// Module Name:   Z:/Documents/ee480/minari/ProcessorComponents/LdStrReg/LdStrReg_vtf.v
// Project Name:  LdStrReg
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: LdStrReg
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module LdStrReg_vtf;
	// Inputs
	reg [7:0] in;
	reg clr;
	reg clk;
    reg load;

	// Outputs
	wire [7:0] out;

    // Theoretically correct outputs
    reg [7:0] tc_out;
    reg error;

	// Instantiate the Unit Under Test (UUT)
	LdStrReg uut (
		.in(in), 
		.clr(clr), 
		.clk(clk), 
		.out(out),
        .load(load)
	);

	initial begin
		// Initialize Inputs
		in = 0;
		clr = 0;
		clk = 0;
        error = 0;
        tc_out = 0;
        load = 0;
	end

    // Clk generation
    always begin
        #5 clk = ~clk;
    end

    // Counter
    always @(posedge clk) begin:counter
        integer i;
        for(i=0; i<2**10; i=i+1) begin
            #12 {clr,load,in} <= i;
        end
    end

    // Generation of tc output
    always @(posedge clk) begin
        case({clr,load})
            3'b00: tc_out <= 8'b00000000;
            3'b01: tc_out <= 8'b00000000;
            3'b10: tc_out <= tc_out;
            3'b11: tc_out <= in;
        endcase

        // Error signal
        #1 if(tc_out == out) error <= 0;
        else error <= 1;
    end
endmodule
