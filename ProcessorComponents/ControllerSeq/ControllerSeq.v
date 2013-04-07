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
    input intPending, clk, dataReady, instReady, ALUdone,
    output ACCld, ACCclr, PCin, IRld, IRclr, IRin, MARld, MARclr, CCld, CCclr,
           CCin, addrSrc, MASKld, MASKclr, INTld, INTclr, intDisable, clrPend,
           DRAMclr, DRAMwriteEnable, IRAMclr, IRAMwriteEnable, indirect
    output [1:0] ACCin, PCctrl, SPctrl, MARin,
    output [2:0] ALUctrl, writeSrc);

    reg [n:0] currState, nextState;

    always @(ir, intPending, dataReady, instReady, currState) begin
        case(currState)
            // Launching a subroutine/handling interrupt
            sub0: nextState <= sub1;
            sub1: nextState <= sub2;
            sub2: nextState <= sub3;
            sub3: nextState <= sub4;
            sub4: nextState <= sub5;
            sub5: nextState <= sub6;
            sub6: nextState <= sub7;
            sub7: if(intPending == 1) nextState <= isr;
                  else nextState <= sub8;
            sub8: if(dataReady == 0) nextState <= sub8;
                  else nextState <= start;

            // Handling an interrupt
            isr: nextState <= start;

            // ALU operation
            ALUop: case(ir[5:4])
                   2'b00: nextState <= ALUimmed;
                   2'b10: nextState <= ALUdir;
                   2'b11: nextState <= ALUind;
                   2'b01: nextState <= ALUother;
                   endcase
            ALUimmed: nextState <= start;
            ALUdir: if(dataReady == 0) nextState <= ALUdir;
                    else nextState <= start;
            ALUind: if(dataReady == 0) nextState <= ALUind;
                    else nextState <= start;

            // 
        endcase
    end
endmodule
