`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:05:37 04/06/2013 
// Design Name: 
// Module Name:    ControllerSeq 
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
module ControllerSeq (
input [5:0] ir,
input intPending, clk, dataReady, instReady, inDataReady, restart, Z, outDataSent,
output reg ACCld, ACCclr, IRld, IRclr, IRin, MARin, MARclr, MARld, CCld, CCclr,
	   CCin, indirect, addrSrc, ldMask, clrMask, ldIntReg, clrIntReg, intDisable,
	   clrPend, DRAMclr, IRAMclr, devACK, outDataReady, ALUsrc,
output reg [1:0] ACCin, PCctrl, SPctrl, dataCacheCtrl, instCacheCtrl, PCin,
output reg [2:0] writeSrc, ALUctrl,
output reg [51:0] currState //TEMP
);

reg [51:0] /*currState,*/ nextState;
parameter
    reset = 52'h8000000000000,
    intLoad = 52'h4000000000000,
    intCheck = 52'h2000000000000,
    fetch0 = 52'h1000000000000,
    fetch1 = 52'h0800000000000,
    fetch2 = 52'h0400000000000,
    sub0 = 52'h0200000000000,
    sub1 = 52'h0100000000000,
    sub2 = 52'h0080000000000,
    sub3 = 52'h0040000000000,
    sub4 = 52'h0020000000000,
    sub5 = 52'h0010000000000,
    sub6 = 52'h0008000000000,
    sub7 = 52'h0004000000000,
    sub8 = 52'h0002000000000,
    isr = 52'h0001000000000,
    alu0 = 52'h0000800000000,
    aluImmed = 52'h0000400000000,
    alu1 = 52'h0000200000000,
    alu2 = 52'h0000100000000,
    load0 = 52'h0000080000000,
    loadImmed = 52'h0000040000000,
    load1 = 52'h0000020000000,
    load2 = 52'h0000010000000,
    store0 = 52'h0000008000000,
    lmask = 52'h0000004000000,
    branch0 = 52'h0000002000000,
    branchImmed = 52'h0000001000000,
    branch1 = 52'h0000000800000,
    branch2 = 52'h0000000400000,
    jump0 = 52'h0000000200000,
    jumpImmed = 52'h0000000100000,
    jump1 = 52'h0000000080000,
    jump2 = 52'h0000000040000,
    in0 = 52'h0000000020000,
    in1 = 52'h0000000010000,
    in2 = 52'h0000000008000,
    out0 = 52'h0000000004000,
    out1 = 52'h0000000002000,
    out2 = 52'h0000000001000,
    ret0 = 52'h0000000000800,
    ret1 = 52'h0000000000400,
    ret2 = 52'h0000000000200,
    ret3 = 52'h0000000000100,
    ret4 = 52'h0000000000080,
    ret5 = 52'h0000000000040,
    ret6 = 52'h0000000000020,
    ret7 = 52'h0000000000010,
    ret8 = 52'h0000000000008,
    ret9 = 52'h0000000000004,
    ret10 = 52'h0000000000002,
    ret11 = 52'h0000000000001;


 
	initial begin currState = reset; end
	
always @(ir, intPending, dataReady, instReady, currState, inDataReady, Z, outDataSent) begin
	case(currState)
		// Starting state - reset all the things
		reset: nextState = intLoad;

		// Load interrupt register
		intLoad: nextState = intCheck;

		// Check for interrupts
		intCheck:
			if(intPending == 1) nextState = sub0;
			else nextState = fetch0;


		// Instruction fetch
		fetch0:
			if(instReady == 0) nextState = fetch0;
			else nextState = fetch1;
		fetch1: nextState = fetch2;
		fetch2:
			case(ir[5:2])
				4'b0000: nextState = alu0;         //X
				4'b0001: nextState = alu0;         //X
				4'b0010: nextState = alu0;         //X
				4'b0011: nextState = alu0;         //X
				4'b0100: nextState = alu0;         //X
				4'b0101: nextState = alu0;         //X
				4'b0110: nextState = alu0;         //X
				4'b0111: nextState = branch0;      //X
				4'b1000: nextState = jump0;        //X
				4'b1001: nextState = ret0;         //X
				4'b1010: nextState = load0;        //X
				4'b1011: nextState = store0;       //X
				4'b1100: nextState = in0;          //X
				4'b1101: nextState = out0;         //X
				4'b1110: nextState = lmask;        //X
				4'b1111: nextState = sub0;         //X
				default: nextState = intLoad;     //X
			endcase
				

		// Launching a subroutine/handling interrupt
		sub0: nextState = sub1;
		sub1: 
			if(dataReady == 0) nextState = sub1;
			else nextState = sub2;
		sub2: nextState = sub3;
		sub3:
			if(dataReady == 0) nextState = sub3;
			else nextState = sub4;
		sub4: nextState = sub5;
		sub5:
			if(dataReady == 0) nextState = sub5;
			else nextState = sub6;
		sub6: nextState = sub7;
		sub7:
			if(dataReady == 0) nextState = sub7;
			else if(intPending == 1)  nextState = isr;
			else nextState = sub8;
		sub8:
			nextState = intLoad;
			//if(dataReady === 0) nextState = sub8;
			//else nextState = intLoad;


		// Move HVPIaddr to PC
		isr: nextState = fetch0;


		// ALU operation
		alu0:
			if(ir[1:0] == 2'b00) nextState = aluImmed;
			else nextState = alu1;
		aluImmed: nextState = intLoad;
		alu1:
			if(dataReady == 0) nextState = alu1;
			else nextState = alu2;
		alu2: nextState = intLoad;


		// Load
		load0:
			if(ir[1:0] == 2'b00) nextState = loadImmed;
			else nextState = load1;
		loadImmed: nextState = intLoad;
		load1:
			if(dataReady == 0) nextState = load1;
			else nextState = load2;
		load2: nextState = intLoad;


		// Store
		store0:
			if(dataReady == 0) nextState = store0;
			else nextState = intLoad;
		

		// Load mask register
		lmask: nextState = intLoad;


		// Branch

		branch0:
			if(Z == 0) nextState = intLoad;
			else begin
				if(ir[1:0] == 2'b00) nextState = branchImmed;
				else nextState = branch1;		
			end
		branchImmed: nextState = intLoad;
		branch1:
			if(dataReady == 0) nextState = branch1;
			else nextState = branch2;
		branch2: nextState = intLoad;


		// Jump
		jump0:if(ir[1:0] == 2'b00) nextState = jumpImmed;
			else nextState = jump1;	
		jumpImmed: nextState = intLoad;
		jump1:
			if(dataReady == 0) nextState = jump1;
			else nextState = jump2;
		jump2: nextState = intLoad;


		// In
		in0:
			if(inDataReady == 0) nextState = in0;
			else nextState = in1;
		in1: nextState = in2;
		in2: nextState = intLoad;


		// Out
		out0: nextState = out1;
		out1: nextState = out2;
		out2:
			if(outDataSent == 0) nextState = out2;
			else nextState = intLoad;


		// Return
		ret0:
			if(dataReady == 0) nextState = ret0;
			else nextState = ret1;
		ret1: nextState = ret2;
		ret2: nextState = ret3;
		ret3:
			if(dataReady == 0) nextState = ret3;
			else nextState = ret4;
		ret4: nextState = ret5;
		ret5: nextState = ret6;
		ret6: 
			if(dataReady == 0) nextState = ret6;
			else nextState = ret7;
		ret7: nextState = ret8;
		ret8: nextState = ret9;
		ret9:
			if(dataReady == 0) nextState = ret9;
			else nextState = ret10;
		ret10: nextState = ret11;
		ret11: nextState = intLoad;
		default: nextState = reset;
	endcase
end

always @(posedge clk) begin
	if(restart == 1) currState <= reset;
	else currState <= nextState;
end

always @(currState, ir, intDisable) begin
	case(currState)
		// Generated on 2013-04-22 16:21:17 -0400
		reset: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b0;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b11;
			 SPctrl = 2'b01;
			 IRld = 1'b0;
			 IRclr = 1'b0;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b0;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b0;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b00;
			 ldMask = 1'b0;
			 clrMask = 1'b0;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b0;
			 intDisable = 1'b0;
			 clrPend = 1'b0;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b00;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		intLoad: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b1;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		intCheck: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		fetch0: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b10;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		fetch1: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b1;
			 IRclr = 1'b1;
			 IRin = 1'b1;
			 MARld = 1'b1;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		fetch2: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b10;
			 SPctrl = 2'b00;
			 IRld = 1'b1;
			 IRclr = 1'b1;
			 IRin = 1'b1;
			 MARld = 1'b1;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		sub0: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b10;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		sub1: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b1;
			 dataCacheCtrl = 2'b11;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		sub2: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b10;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		sub3: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b001;
			 indirect = 1'b0;
			 addrSrc = 1'b1;
			 dataCacheCtrl = 2'b11;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		sub4: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b10;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		sub5: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b011;
			 indirect = 1'b0;
			 addrSrc = 1'b1;
			 dataCacheCtrl = 2'b11;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		sub6: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b10;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		sub7: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b100;
			 indirect = 1'b0;
			 addrSrc = 1'b1;
			 dataCacheCtrl = 2'b11;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		sub8: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b10;
			 PCctrl = 2'b01;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b100;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		isr: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b01;
			 PCctrl = 2'b01;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b0;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = 1'b1;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		alu0: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		aluImmed: begin
			 ACCld = 1'b1;
			 ACCclr = 1'b1;
			 ACCin = 2'b10;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b1;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		alu1: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = ir[0];
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b10;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		alu2: begin
			 ACCld = 1'b1;
			 ACCclr = 1'b1;
			 ACCin = 2'b10;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b1;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b1;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		load0: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		loadImmed: begin
			 ACCld = 1'b1;
			 ACCclr = 1'b1;
			 ACCin = 2'b11;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		load1: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = ir[0];
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b10;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		load2: begin
			 ACCld = 1'b1;
			 ACCclr = 1'b1;
			 ACCin = 2'b01;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		store0: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = ir[0];
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b11;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		lmask: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b1;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		branch0: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		branchImmed: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b10;
			 PCctrl = 2'b01;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		branch1: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = ir[0];
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b10;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		branch2: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b01;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		jump0: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		jumpImmed: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b10;
			 PCctrl = 2'b01;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		jump1: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = ir[0];
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b10;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		jump2: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b01;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		in0: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		in1: begin
			 ACCld = 1'b1;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		in2: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b1;
			 outDataReady = 1'b0;
		end
		out0: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b1;
		end
		out1: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		out2: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		ret0: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b1;
			 dataCacheCtrl = 2'b10;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		ret1: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b1;
			 MARclr = 1'b1;
			 MARin = 1'b1;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		ret2: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b11;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		ret3: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b1;
			 dataCacheCtrl = 2'b10;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		ret4: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b1;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b1;
			 CCclr = 1'b1;
			 CCin = 1'b1;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		ret5: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b11;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		ret6: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b1;
			 dataCacheCtrl = 2'b10;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		ret7: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b01;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		ret8: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b11;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		ret9: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b1;
			 dataCacheCtrl = 2'b10;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		ret10: begin
			 ACCld = 1'b1;
			 ACCclr = 1'b1;
			 ACCin = 2'b01;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		ret11: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b11;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = 1'b0;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end
		default: begin
			 ACCld = 1'b0;
			 ACCclr = 1'b1;
			 ACCin = 2'b00;
			 PCin = 2'b00;
			 PCctrl = 2'b00;
			 SPctrl = 2'b00;
			 IRld = 1'b0;
			 IRclr = 1'b1;
			 IRin = 1'b0;
			 MARld = 1'b0;
			 MARclr = 1'b1;
			 MARin = 1'b0;
			 CCld = 1'b0;
			 CCclr = 1'b1;
			 CCin = 1'b0;
			 writeSrc = 3'b000;
			 indirect = 1'b0;
			 addrSrc = 1'b0;
			 dataCacheCtrl = 2'b01;
			 ldMask = 1'b0;
			 clrMask = 1'b1;
			 ldIntReg = 1'b0;
			 clrIntReg = 1'b1;
			 intDisable = intDisable;
			 clrPend = 1'b1;
			 ALUctrl = ir[4:2];
			 ALUsrc = 1'b0;
			 DRAMclr = 1'b1;
			 IRAMclr = 1'b1;
			 instCacheCtrl = 2'b01;
			 devACK = 1'b0;
			 outDataReady = 1'b0;
		end


    endcase
end
endmodule
