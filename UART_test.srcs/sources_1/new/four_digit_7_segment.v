`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2025 11:38:47 PM
// Design Name: 
// Module Name: four_digit_7_segment
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


module four_digit_7_segment(input clock, input [26:0] number, output reg [7:0]digit_place, output [6:0]segments);

parameter delay = 2; // delay in ms

parameter clock_frequency = 100_000_000; // Clock frequency in HZ

parameter clock_cycles_delay = clock_frequency * delay / 1000; // Delay represented in clock cycles

reg [26:0]counter = 0;

reg [2:0] current_state = 0;
reg [2:0] next_state = 0;
//reg D1,D2,D3,D4,D5,D6,D7,D8;
reg a,b,c,d,e,f,g;
reg [7:0]digit = 8'b11111111;

seven_segment S1(.digit(digit),.segments(segments));

always@(posedge clock)
begin
    
    if (counter == clock_cycles_delay)
    begin
        counter <= 0;
      
    end
    
    else
    begin
        
        counter <= counter + 1;
        
    end
    
    current_state <= next_state;
end

always@(*)

case(current_state)

    3'd0:
    begin
    
        digit_place <= 8'b00000001;
        digit = number % 10;
        
        if(counter == clock_cycles_delay)
        begin
        
            next_state <= 3'd1;
        
        end
        
        else
        
        begin
        
            next_state <= current_state;
            
        end
    
    end
    
    3'd1:
    begin
    
        digit_place <= number < 10 ? 8'b00000000 : 8'b00000010;
        digit = (number/10) % 10;
        
        if(counter == clock_cycles_delay)
        begin
        
            next_state <= 3'd2;
        
        end
        
        else
        
        begin
        
            next_state <= current_state;
            
        end
    
    end
    
    3'd2:
    begin
    
        digit_place <= number < 100 ? 8'b00000000 : 8'b00000100;
        digit = (number/100) % 10;
        
        if(counter == clock_cycles_delay)
        begin
        
            next_state <= 3'd3;
        
        end
        
        else
        
        begin
        
            next_state <= current_state;
            
        end
    
    
    end
    
    3'd3:
    begin
        digit_place <= number < 1_000 ? 8'b00000000 : 8'b00001000;
        digit = (number/1000) % 10;
        
        if(counter == clock_cycles_delay)
        begin
        
            next_state <= 3'd4;
        
        end
        
        else
        
        begin
        
            next_state <= current_state;
            
        end
    
    
    end
    
    3'd4:
    begin
        digit_place <= number < 10_000 ? 8'b00000000 :  8'b00010000;
        digit = (number/10_000) % 10;
        
        if(counter == clock_cycles_delay)
        begin
        
            next_state <= 3'd5;
        
        end
        
        else
        
        begin
        
            next_state <= current_state;
            
        end
    
    
    end
    
    3'd5:
    begin
        digit_place <= number < 100_000 ? 8'b00000000 : 8'b00100000;
        digit = (number/100_000) % 10;
        
        if(counter == clock_cycles_delay)
        begin
        
            next_state <= 3'd6;
        
        end
        
        else
        
        begin
        
            next_state <= current_state;
            
        end
    
    
    end
    
    3'd6:
    begin
        digit_place <= number < 1_000_000 ? 8'b00000000 : 8'b01000000;
        digit = (number/1_000_000) % 10;
        
        if(counter == clock_cycles_delay)
        begin
        
            next_state <= 3'd7;
        
        end
        
        else
        
        begin
        
            next_state <= current_state;
            
        end
    
    
    end
    
    3'd7:
    begin
        digit_place <= number < 10_000_000 ? 8'b00000000 : 8'b10000000;
        digit = (number/10_000_000) % 10;
        
        if(counter == clock_cycles_delay)
        begin
        
            next_state <= 3'd0;
        
        end
        
        else
        
        begin
        
            next_state <= current_state;
            
        end
    
    
    end
    
endcase


endmodule
