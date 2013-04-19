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
                case(ir[3:0])
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
                    4'b1110: nextState = lmask0;       //X
                    4'b1111: nextState = sub0;         //X
                    default: nextState = intCheck;     //X
                endcase
                    

            // Launching a subroutine/handling interrupt
            sub0: nextState = sub1;
            sub1: 
                if(dataReady = 0) nextState = sub1;
                else nextState = sub2;
            sub2: nextState = sub3;
            sub3:
                if(dataReady = 0) nextState = sub3;
                else nextState = sub4;
            sub4: nextState = sub5;
            sub5:
                if(dataReady = 0) nextState = sub5;
                else nextState = sub6;
            sub6: nextState = sub7;
            sub7:
                if(dataReady = 0) nextState = sub7;
                else if(intPending == 1)  nextState = isr;
                else nextState = sub8;
            sub8:
                if(dataReady == 0) nextState = sub8;
                else nextState = intCheck;


            // Move HVPIaddr to PC
            isr: nextState = fetch0;


            // ALU operation
            alu0:
                if(ir[5:4] == 2'b00) nextState = aluImmed;
                else nextState = alu1;
            aluImmed: nextState = intCheck;
            alu1:
                if(dataReady == 0) nextState = alu1;
                else nextState = alu2;
            alu2: nextState = intCheck;


            // Load
            load0:
                if(ir[5:4] == 2'b00) nextState = loadImmed;
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
                else nextState = jmp1;
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
        endcase
    end
endmodule
