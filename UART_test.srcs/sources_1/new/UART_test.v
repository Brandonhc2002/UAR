`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2025 12:07:24 AM
// Design Name: 
// Module Name: UART_test
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


module UART_test(input clock, input UART_RX, output [6:0] segments_annode, output [7:0] digit_place_annode);

parameter frequency = 100_000_000;

wire [7:0] Data;
wire byte_recieved;

reg [26:0] number = 0;
wire [7:0]digit_place;
wire [6:0]segments;

assign digit_place_annode = ~digit_place;
assign segments_annode = ~segments;

uart_reciever S1 (.clock(clock),.RX_async(UART_RX),.Data(Data),.byte_recieved(byte_recieved));
four_digit_7_segment my_segment(.clock(clock), .number(number), .digit_place(digit_place), .segments(segments));

always@(posedge clock)
begin

    if(byte_recieved)
    begin
        number <= Data;
    end

end



endmodule
