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
output reg [42:0] currState //TEMP
);

reg [42:0] /*currState,*/ nextState;
parameter
    reset = 43'h40000000000,
    intCheck = 43'h20000000000,
    fetch0 = 43'h10000000000,
    fetch1 = 43'h08000000000,
    sub0 = 43'h04000000000,
    sub1 = 43'h02000000000,
    sub2 = 43'h01000000000,
    sub3 = 43'h00800000000,
    sub4 = 43'h00400000000,
    sub5 = 43'h00200000000,
    sub6 = 43'h00100000000,
    sub7 = 43'h00080000000,
    sub8 = 43'h00040000000,
    isr = 43'h00020000000,
    alu0 = 43'h00010000000,
    aluImmed = 43'h00008000000,
    alu1 = 43'h00004000000,
    alu2 = 43'h00002000000,
    load0 = 43'h00001000000,
    loadImmed = 43'h00000800000,
    load1 = 43'h00000400000,
    load2 = 43'h00000200000,
    store0 = 43'h00000100000,
    lmask = 43'h00000080000,
    branch0 = 43'h00000040000,
    branch1 = 43'h00000020000,
    branch2 = 43'h00000010000,
    jump0 = 43'h00000008000,
    jump1 = 43'h00000004000,
    in0 = 43'h00000002000,
    in1 = 43'h00000001000,
    in2 = 43'h00000000800,
    out0 = 43'h00000000400,
    out1 = 43'h00000000200,
    out2 = 43'h00000000100,
    ret0 = 43'h00000000080,
    ret1 = 43'h00000000040,
    ret2 = 43'h00000000020,
    ret3 = 43'h00000000010,
    ret4 = 43'h00000000008,
    ret5 = 43'h00000000004,
    ret6 = 43'h00000000002,
    ret7 = 43'h00000000001;
 
	initial begin currState = reset; end
	
	// TEMP - check output of IR
	assign tmpIRout = ir;

always @(ir, intPending, dataReady, instReady, currState, inDataReady, Z, outDataSent) begin
	case(currState)
		// Starting state - reset all the things
		reset: nextState = intCheck;


		// Check for interrupts
		intCheck:
			if(intPending == 1) nextState = sub0;
			else nextState = fetch0;


		// Instruction fetch
		fetch0:
			if(instReady == 0) nextState = fetch0;
			else nextState = fetch1;
		fetch1:
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
				4'b1110: nextState = lmask;       //X
				4'b1111: nextState = sub0;         //X
				default: nextState = intCheck;     //X
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
			if(dataReady === 0) nextState = sub8;
			else nextState = intCheck;


		// Move HVPIaddr to PC
		isr: nextState = fetch0;


		// ALU operation
		alu0:
			if(ir[1:0] == 2'b00) nextState = aluImmed;
			else nextState = alu1;
		aluImmed: nextState = intCheck;
		alu1:
			if(dataReady == 0) nextState = alu1;
			else nextState = alu2;
		alu2: nextState = intCheck;


		// Load
		load0:
			if(ir[1:0] == 2'b00) nextState = loadImmed;
			else nextState = load1;
		loadImmed: nextState = intCheck;
		load1:
			if(dataReady == 0) nextState = load1;
			else nextState = load2;
		load2: nextState = intCheck;


		// Store
		store0:
			if(dataReady == 0) nextState = store0;
			else nextState = intCheck;
		

		// Load mask register
		lmask: nextState = intCheck;


		// Branch
		branch0:
			if(dataReady == 0) nextState = branch0;
			else nextState = branch1;
		branch1:
			if(Z == 0) nextState = intCheck;
			else nextState = branch2;
		branch2: nextState = intCheck;


		// Jump
		jump0:
			if(dataReady == 0) nextState = jump0;
			else nextState = jump1;
		jump1: nextState = intCheck;


		// In
		in0:
			if(inDataReady == 0) nextState = in0;
			else nextState = in1;
		in1: nextState = in2;
		in2: nextState = intCheck;


		// Out
		out0: nextState = out1;
		out1: nextState = out2;
		out2:
			if(outDataSent == 0) nextState = out2;
			else nextState = intCheck;


		// Return
		ret0:
			if(dataReady == 0) nextState = ret0;
			else nextState = ret1;
		ret1: nextState = ret2;
		ret2: 
			if(dataReady == 0) nextState = ret2;
			else nextState = ret3;
		ret3: nextState = ret4;
		ret4: 
			if(dataReady == 0) nextState = ret4;
			else nextState = ret5;
		ret5: nextState = ret6;
		ret6:
			if(dataReady == 0) nextState = ret6;
			else nextState = ret7;
		ret7: nextState = intCheck;
		default: nextState = reset;
	endcase
end

always @(posedge clk) begin
	if(restart == 1) currState <= reset;
	else currState <= nextState;
end

always @(currState, ir) begin
	case(currState)
		// Generated on 2013-04-20 23:48:54 -0400
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
			ldIntReg = 1'b1;
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
			dataCacheCtrl = 2'b10;
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
			instCacheCtrl = 2'b10;
			devACK = 1'b0;
			outDataReady = 1'b0;
		end
		fetch1: begin
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
			writeSrc = 3'b011;
			indirect = 1'b0;
			addrSrc = 1'b1;
			dataCacheCtrl = 2'b11;
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
			CCld = 1'b0;
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
			CCld = 1'b0;
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
			intDisable = 1'b0;
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
			indirect = ir[0];
			addrSrc = 1'b0;
			dataCacheCtrl = 2'b10;
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
			indirect = ir[0];
			addrSrc = 1'b0;
			dataCacheCtrl = 2'b10;
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
		jump1: begin
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
			intDisable = 1'b0;
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
			intDisable = 1'b0;
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
			MARld = 1'b1;
			MARclr = 1'b1;
			MARin = 1'b1;
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
		ret1: begin
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
		ret2: begin
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
			addrSrc = 1'b1;
			dataCacheCtrl = 2'b10;
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
		ret3: begin
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
			dataCacheCtrl = 2'b00;
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
		ret4: begin
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
			addrSrc = 1'b1;
			dataCacheCtrl = 2'b10;
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
			dataCacheCtrl = 2'b00;
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
		ret6: begin
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
			addrSrc = 1'b1;
			dataCacheCtrl = 2'b10;
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
		ret7: begin
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
			dataCacheCtrl = 2'b00;
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
			dataCacheCtrl = 2'b00;
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
    endcase
end
endmodule
