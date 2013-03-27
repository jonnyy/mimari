`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:53:26 03/20/2013 
// Design Name: 
// Module Name:    HPVISys 
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
module HPVISys (
    parameter pcWidth = 16,
    parameter addrLen = 2)(
    input otherInt,                 // Whether there is a pending interrupt
    input pendClr                   // Clear the DFF storing the above info
    input intDisable,               // Disable any interrupts
    input clk,
    input [3:0] ints,               // Interrupt flags
    input [3:0] intMask,            // Interrupt masks
    input ldMask, clrMask           // Control Mask reg
    input ldIntReg, clrIntReg,      // Control Interrupt reg
    output [pcWidth-1:0] intAddr,   // Output ISR address
    output intPending);             // Tells if there's a pending interrupt
endmodule
