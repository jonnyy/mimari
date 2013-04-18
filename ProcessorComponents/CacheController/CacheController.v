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
    input clk, isClean, isHit, indirect, commence, dataReady,
	input [1:0] ctrl,
    output reg dataInSel, RAMreadEnable, RAMwriteEnable, outputReady,
    output reg [1:0] cacheIn,
	output reg [12:0] TEMPstateTEMP);
    
    parameter start            = 18'b100000000000000000,
              clrState         = 18'b010000000000000000,
              read             = 18'b001000000000000000,
              checkReadStatus  = 18'b000100000000000000,
              r_writeRAM       = 18'b000010000000000000,
              r_fetchRAM       = 18'b000001000000000000,
              r_cacheWrite     = 18'b000000100000000000,
              cacheRead        = 18'b000000010000000000,
              write            = 18'b000000001000000000,
              checkWriteStatus = 18'b000000000100000000,
              w_writeRAM       = 18'b000000000010000000,
              cacheWrite       = 18'b000000000001000000,
              indCheckStatus   = 18'b000000000000100000,
              indWriteCache    = 18'b000000000000010000,
              indWriteRAM      = 18'b000000000000001000,
              indReadRAM       = 18'b000000000000000100,
              indRead          = 18'b000000000000000010,
              indirectCheck    = 18'b000000000000000001;


    reg [12:0] currState, nextState;

    always @(currState, isClean, isHit, indirect, ctrl, dataReady) begin
        case(currState)
            start: begin
                case(ctrl)
                    2'b00: nextState = clrState;
					2'b01: nextState = start;
                    2'b10: nextState = indirectCheck;
                    2'b11: nextState = indirectCheck;
					default: nextState = start;
                endcase
			end

            // Check for indirect request
            indirectCheck:
                if(indirect == 1) nextState = indCheckStatus;
                else
                    case(ctrl)
                        2'b00: nextState = clrState;
                        2'b01: nextState = start;
                        2'b10: nextState = read;
                        2'b11: nextState = write;
                    endcase

            // Perform primary read for indirect read/write, then jump to read
            // or write leg of the state machine for actual indirect
            // read/write.
            indCheckStatus:
                case({isHit,isClean})
                    2'b00: nextState = indWriteRAM;
                    2'b01: nextState = indReadRAM;
                    2'b10: nextState = indCacheRead;
                    2'b11: nextState = indCacheRead;
					default: nextState = start;
                endcase
            indWriteRAM: nextState = indReadRAM;
            indReadRAM: nextState = indWriteCache;
            indWriteCache: nextState = indRead;
            indRead:
                case(ctrl)
                    2'b00: nextState = clrState;
                    2'b01: nextState = start;
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
					default: nextState = start;
                endcase
            r_writeRAM: nextState = r_fetchRAM;
            r_fetchRAM:
                if(dataReady == 0) nextState = r_fetchRAM;
			    else nextState = r_cacheWrite;
            r_cacheWrite: nextState <= cacheRead;
            cacheRead: nextState = indReadCheck;
            indReadCheck:
                if(indirect == 1) nextState = indRead;
                else begin nextState = start; end

            // CACHE WRITE
            write: nextState = checkWriteStatus;
            checkWriteStatus:begin
                case({isHit,isClean})
                    2'b00: nextState = w_writeRAM;
                    2'b01: nextState = cacheWrite;
                    2'b10: nextState = cacheWrite;
                    2'b11: nextState = cacheWrite;
					default: nextState = start;
                endcase
			end
            w_writeRAM: nextState = cacheWrite;
            cacheWrite: nextState = indWriteCheck;
			default: nextState = start;
        endcase
    end

    always @(posedge clk) begin
        if(commence == 0) currState <= start;
        else currState <= nextState;
    end

    always @(currState) begin
        case(currState)
            start: begin
                cacheIn = 2'b10;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
				outputReady = 1'b0;

            end
            clrState: begin
                cacheIn = 2'b00;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
				outputReady = 1'b0;
            end
            indirectCheck: begin
                cacheIn = 2'b01;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
				outputReady = 1'b0;
            end
            read: begin
                cacheIn = 2'b01;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
				outputReady = 1'b0;
            end
            checkReadStatus: begin
                cacheIn = 2'b10;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
				outputReady = 1'b0;
            end
            r_writeRAM: begin
                cacheIn = 2'b10;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b1;
				outputReady = 1'b0;
            end
            r_fetchRAM: begin
                cacheIn = 2'b10;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b1;
                RAMwriteEnable = 1'b0;
				outputReady = 1'b0;
            end
            r_cacheWrite: begin
                cacheIn = 2'b11;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
                outputReady = 1'b0;
            end
            cacheRead: begin
                cacheIn = 2'b10;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
				outputReady = 1'b1;
            end
            write: begin
                cacheIn = 2'b01;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
				outputReady = 1'b0;
            end
            checkWriteStatus: begin
                cacheIn = 2'b10;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
				outputReady = 1'b0;
            end
            w_writeRAM: begin
                cacheIn = 2'b10;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b1;
				outputReady = 1'b0;
            end
            cacheWrite: begin
                cacheIn = 2'b11;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
				outputReady = 1'b1;
            end
            indCheckStatus: begin
                cacheIn = 2'b10;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
				outputReady = 1'b0;
            end
            indWriteRAM: begin
                cacheIn = 2'b10;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b1;
				outputReady = 1'b0;
            end
            indReadRAM: begin
                cacheIn = 2'b10;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b1;
                RAMwriteEnable = 1'b0;
				outputReady = 1'b0;
            end
            indCacheWrite: begin
                cacheIn = 2'b11;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
                outputReady = 1'b0;
            end
            indRead: begin
                cacheIn = 2'b10;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
				outputReady = 1'b1;
            end
            default: begin
                cacheIn = 2'b10;
                dataInSel = cacheIn[0];
                RAMreadEnable = 1'b0;
                RAMwriteEnable = 1'b0;
				outputReady = 1'b0;
            end

        endcase
		TEMPstateTEMP = currState;
    end
endmodule
