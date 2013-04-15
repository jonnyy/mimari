`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:25:38 04/06/2013 
// Design Name: 
// Module Name:    CacheController
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
module CacheController (
    input clk, isClean, isHit, indirect,
    output reg dataInSel, RAMreadEnable, RAMwriteEnable,
    output reg [1:0] cacheIn);
    
    parameter start            = 13'b1000000000000,
              clrState         = 13'b0100000000000,
              read             = 13'b0010000000000,
              checkReadStatus  = 13'b0001000000000,
              r_writeRAM       = 13'b0000100000000,
              r_fetchRAM       = 13'b0000010000000,
              cacheRead        = 13'b0000001000000,
              indReadCheck     = 13'b0000000100000,
              write            = 13'b0000000010000,
              checkWriteStatus = 13'b0000000001000,
              w_writeRAM       = 13'b0000000000100,
              cacheWrite       = 13'b0000000000010,
              indWriteCheck    = 13'b0000000000001;

    reg isIndirect
    reg [12:0] currState, nextState;

    always @(currState, ramWidth) begin
        case(currState)
            start:
                isIndirect = indirect;
                case(ctrl)
                    2'b00: nextState = clrState;
                    2'b10: nextState = read;
                    2'b11: nextState = write;
                endcase

            // CACHE CLEAR
            clrState: nextState = start;

            // CACHE READ
            read: nextState = checkReadStatus;
            checkReadStatus:
                case({isHit,isClean})
                    2'b00: nextState = r_writeRAM;
                    2'b01: nextState = r_fetchRAM;
                    2'b10: nextState = cacheRead;
                    2'b11: nextState = cacheRead;
                endcase
            r_writeRAM: nextState = r_fetchRAM;
            r_fetchRAM: nextState = cacheRead;
            cacheRead: nextState = indReadCheck;
            indReadCheck:
                if(isIndirect == 1) nextState <= read;
                else nextState <= start;

            // CACHE WRITE
            write: nextState = checkWriteStatus;
            checkWriteStatus:
                case({isHit,isClean})
                    2'b00: nextState = w_writeRAM;
                    2'b01: nextState = cacheWrite;
                    2'b10: nextState = cacheWrite;
                    2'b11: nextState = cacheWrite;
                endcase
            w_writeRAM: nextState =  cacheWrite;
            cacheWrite: nextState = indWriteCheck;
            indWriteCheck:
                if(isIndirect == 1) nextState <= write;
                else nextState <= start;
        endcase
    end

    always @(posedge clk) begin
        if(clr == 0) presState <= start;
        else currState <= nextState;
    end

    always @(currState) begin
        case(currState)
            start: begin
                cacheIn = 2'b10;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
            end
            clrState: begin
                cacheIn = 2'b00;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
            end
            read: begin
                cacheIn = 2'b01;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
            end
            checkReadStatus: begin
                cacheIn = 2'b10;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
            end
            r_writeRAM: begin
                cacheIn = 2'b10;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b1;
            end
            r_fetchRAM: begin
                cacheIn = 2'b10;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b1;
                RAMwriteEnable = 1'b0;
            end
            cacheRead: begin
                cacheIn = 2'b10;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
            end
            write: begin
                cacheIn = 2'b01;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
            end
            checkWriteStatus: begin
                cacheIn = 2'b10;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
            end
            w_writeRAM: begin
                cacheIn = 2'b10;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b1;
            end
            cacheWrite: begin
                cacheIn = 2'b11;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
            end
            default: begin
                cacheIn = 2'b10;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
            end
        endcase
    end
endmodule
