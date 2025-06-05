`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2025 11:44:45 PM
// Design Name: 
// Module Name: seven_segment
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


module seven_segment(input [3:0] digit, output  [6:0]segments);
reg a,b,c,d,e,f,g;
always@(digit)
begin
    case(digit)
    
        4'd0: // Logic to display 0
        begin
        
            a = 1'b1;
            b = 1'b1;
            c = 1'b1;
            d = 1'b1;
            e = 1'b1;
            f = 1'b1;
            g = 1'b0;
        
        end
        
        4'd1:// logic to display 1
        begin
        
            a = 1'b0;
            b = 1'b1;
            c = 1'b1;
            d = 1'b0;
            e = 1'b0;
            f = 1'b0;
            g = 1'b0;
        
        end
        
        4'd2:
        begin
            
            a = 1'b1;
            b = 1'b1;
            c = 1'b0;
            d = 1'b1;
            e = 1'b1;
            f = 1'b0;
            g = 1'b1;
            
        end
        
        4'd3:
        begin
        
            a = 1'b1;
            b = 1'b1;
            c = 1'b1;
            d = 1'b1;
            e = 1'b0;
            f = 1'b0;
            g = 1'b1;
        
        end
        
        4'd4:
        begin
        
            a = 1'b0;
            b = 1'b1;
            c = 1'b1;
            d = 1'b0;
            e = 1'b0;
            f = 1'b1;
            g = 1'b1;
        
        end
        
        4'd5:
        begin
        
            a = 1'b1;
            b = 1'b0;
            c = 1'b1;
            d = 1'b1;
            e = 1'b0;
            f = 1'b1;
            g = 1'b1;
        
        end
        
        4'd6:
        begin
        
            a = 1'b1;
            b = 1'b0;
            c = 1'b1;
            d = 1'b1;
            e = 1'b1;
            f = 1'b1;
            g = 1'b1;
        
        end
        
        4'd7:
        begin
            
            a = 1'b1;
            b = 1'b1;
            c = 1'b1;
            d = 1'b0;
            e = 1'b0;
            f = 1'b0;
            g = 1'b0;
            
        end
        
        4'd8:
        begin
        
            a = 1'b1;
            b = 1'b1;
            c = 1'b1;
            d = 1'b1;
            e = 1'b1;
            f = 1'b1;
            g = 1'b1;
        
        end
        
        4'd9:
        begin
        
            a = 1'b1;
            b = 1'b1;
            c = 1'b1;
            d = 1'b0;
            e = 1'b0;
            f = 1'b1;
            g = 1'b1;
        
        end
        
        default :
        begin
        
            a = 1'b0;
            b = 1'b0;
            c = 1'b0;
            d = 1'b0;
            e = 1'b0;
            f = 1'b0;
            g = 1'b0;
        
        end
       
    
    
    endcase
end

assign segments = {a,b,c,d,e,f,g};
endmodule
