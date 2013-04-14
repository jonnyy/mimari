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
    input clk, clr, clean, hit, isClean, isHit, indirect);

    reg isIndirect

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
endmodule
