`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:13:49 03/26/2013
// Design Name:   HVPISys
// Module Name:   E:/Documents/EE480/HVPISys/HVPISys/HVPISys_vtf.v
// Project Name:  HVPISys
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: HVPISys
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module HVPISys_vtf;

	reg [3:0] tc_intReg, tc_maskReg;
	reg [13:0] counter;
	// Inputs
	reg clk;
	reg clrIntReg;
	reg clrMask;
	reg clrPend;
	reg intDisable;
	reg ldMask;
	reg ldIntReg;
	reg [3:0] ints;
	reg [3:0] intMask;
	wire [3:0] test_maskReg;
	wire [2:0] priEncOut;
	wire [3:0] test_intReg;
	wire test_wIntPending;

	// Outputs
	wire [15:0] isrAddr;
	reg [15:0] tc_isrAddr;
	wire intPending;
	reg tc_intPending;
	
	// Theoretically correct outputs
	reg error;

	// Instantiate the Unit Under Test (UUT)
	HVPISys uut (
		.clrPend(clrPend), 
		.intDisable(intDisable), 
		.clk(clk), 
		.ints(ints), 
		.intMask(intMask), 
		.ldMask(ldMask), 
		.clrMask(clrMask), 
		.ldIntReg(ldIntReg), 
		.clrIntReg(clrIntReg), 
		.isrAddr(isrAddr), 
		.intPending(intPending),
		.test_maskReg(test_maskReg),
		.priEncOut(priEncOut),
		.test_intReg(test_intReg),
		.test_wIntPending(test_wIntPending)
	);

	initial begin
		// Initialize Inputs
		clrPend = 0;
		intDisable = 0;
		clk = 0;
		ints = 0;
		intMask = 0;
		ldMask = 0;
		clrMask = 0;
		ldIntReg = 0;
		clrIntReg = 0;
		tc_isrAddr = 0;
		tc_intPending = 0;
		tc_maskReg = 0;
		tc_intReg = 0;
		counter = 0;
		error = 0;

		// Wait 100 ns for global reset to finish
		#100;
	end
	
	// Clock generation
	always begin
		#5 clk = ~clk;
	end
	
	// Generation of tc outputs
	always begin
		#10 counter <= counter + 1;
		clrIntReg   <= ~counter[13];
		clrMask		<= ~counter[12];
		clrPend     <= ~counter[11];
		intMask     <= counter[10:7];
		intDisable  <= counter[6];
		ints        <= counter[5:2];
		ldMask      <= counter[1];
		ldIntReg    <= counter[0];
	end
	
	always begin
		#5 if((ldMask || ldIntReg) && (clrIntReg || clrMask)) begin
			if(ldMask)
				tc_maskReg <= intMask;
			if(ldIntReg)
				tc_intReg <= ints;
		end
		if(~clrIntReg || ~clrMask) begin
			tc_intPending <= 0;
			tc_isrAddr <= 1;
			if(~clrIntReg)
				tc_intReg <= 0;
			if(~clrMask)
				tc_maskReg <= 0;
		end
		else if(intDisable == 1) begin
			tc_intPending <= 0;
			tc_isrAddr <= 1;
		end
		else if(clrPend == 0) begin
			tc_intPending <= 0;
			if(tc_intReg[0] && tc_maskReg[0])
				tc_isrAddr <= 1;
			else if(tc_intReg[1] && tc_maskReg[1])
				tc_isrAddr <= 2;
			else if(tc_intReg[2] && tc_maskReg[2])
				tc_isrAddr <= 3;
			else if(tc_intReg[3] && tc_maskReg[3])
				tc_isrAddr <= 4;
			else 
				tc_isrAddr <= 1;
		end
		else begin
			if(tc_intReg[0] && tc_maskReg[0]) begin
				tc_isrAddr <= 1;
				tc_intPending <= 1;
			end
			else if(tc_intReg[1] && tc_maskReg[1]) begin 
				tc_isrAddr <= 2;
				tc_intPending <= 1;
			end
			else if(tc_intReg[2] && tc_maskReg[2]) begin
				tc_isrAddr <= 3;
				tc_intPending <= 1;
			end
			else if(tc_intReg[3] && tc_maskReg[3]) begin
				tc_isrAddr <= 4;
				tc_intPending <= 1;
			end
			else begin
				tc_isrAddr <= 1;
				tc_intPending <= 0;
			end
		end
		
		#5 if(tc_isrAddr != isrAddr || tc_intPending != intPending) error <= 1;
		else error <= 0;
			
	end
endmodule

