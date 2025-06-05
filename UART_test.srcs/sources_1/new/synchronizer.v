`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2025 01:55:31 AM
// Design Name: 
// Module Name: synchronizer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module synchronizer (
    input wire clock,          // System clock
    input wire async_in,     // Asynchronous input signal
    output reg sync_out      // Synchronized output signal
);
    reg sync_ff1;

    always @(posedge clock) begin
        sync_ff1   <= async_in;    // First stage: may go metastable
        sync_out   <= sync_ff1;    // Second stage: now stable and safe
    end
endmodule