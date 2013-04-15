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
            // From start, switch on instruction type
            //      -ALU type        X
            //      -branch/jump
            //      -subroutine      X
            //      -load
            //      -store
            //      -input
            //      -output
            //      -return
            //      -load mask

            // Starting state - reset all the things
            start: nextState <= intCheck;

            // Check for interrupts
            interruptCheck:
                if(intPending == 1) nextState <= sub0;
                else nextState <= fetch0;

            // Instruction fetch
            fetch0:
                if(instReady == 0) nextState <= fetch0;
                else nextState <= fetch1;
            fetch1:
                case(ir[3:0])
                    4'b0000: nextState <= alu0;         //X
                    4'b0001: nextState <= alu0;         //X
                    4'b0010: nextState <= alu0;         //X
                    4'b0011: nextState <= alu0;         //X
                    4'b0100: nextState <= alu0;         //X
                    4'b0101: nextState <= alu0;         //X
                    4'b0110: nextState <= alu0;         //X
                    4'b0111: nextState <= branch0;
                    4'b1000: nextState <= jump0
                    4'b1001: nextState <= return0;
                    4'b1010: nextState <= load0;        //X
                    4'b1011: nextState <= store0;       //X
                    4'b1100: nextState <= in0;
                    4'b1101: nextState <= out0;
                    4'b1110: nextState <= lmask0;       //X
                    4'b1111: nextState <= sub0;         //X
                    default: nextState <= intCheck;     //X
                endcase
                    
            // Launching a subroutine/handling interrupt
            sub0: nextState <= sub1;
            sub1: nextState <= sub2;
            sub2: nextState <= sub3;
            sub3: nextState <= sub4;
            sub4: nextState <= sub5;
            sub5: nextState <= sub6;
            sub6: nextState <= sub7;
            sub7:
                if(intPending == 1) nextState <= isr;
                else nextState <= sub8;
            sub8:
                if(dataReady == 0) nextState <= sub8;
                else nextState <= intCheck;

            // ALU operation
            alu0:
                if(ir[5:4] == 2'b00) nextState <= aluImmed;
                else nextState <= alu1;
            aluImmed: nextState <= intCheck;
            alu1:
                if(dataReady == 0) nextState <= alu1;
                else nextState <= intCheck;

            // Load
            load0:
                if(ir[5:4] == 2'b00) nextState <= intCheck;
                else nextState <= load1;
            loadInd:
                if(dataReady == 0) nextState <= loadInd;
                else nextState <= intCheck;

            // Store
            store0:
                if(ir[5:4] == 2'b11) nextState <= storeInd;
                else nextState <= storeDir;
            storeDir: nextState <= intCheck;
            storeInd0:
                if(dataReady == 0) nextState <= storeInd0;
                else nextState <= storeInd1;
            storeInd1: nextState <= intCheck;

            // Load mask register
            lmask: nextState <= intCheck;

            // Branch
            branch0:
                if(dataReady == 0) nextState <= branch0;
                else nextState <= branch1;
            branch1: if(ir[5:4] == 2'b11) nextState <= 
        endcase
    end
endmodule
