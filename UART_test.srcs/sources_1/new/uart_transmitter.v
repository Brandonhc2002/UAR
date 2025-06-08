
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2025 04:12:18 AM
// Design Name: 
// Module Name: uart_transmitter
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


module uart_transmitter(input clock, input [7:0] Data, input send,output TX, output busy, output led);
//Parameters
parameter frequency = 100_000_000; // Frequency of oscillator clock
parameter baud_rate = 9600; //frequency of UART comminication
parameter baud_cycles = frequency / baud_rate;
parameter reg_width = 10; //8 data bits + start bit + stop bit

//State defintions
parameter IDLE = 1'b0;
parameter SEND = 1'b1;
reg current_state = IDLE;
reg next_state = IDLE;
 reg led_reg = 0;
// Mischellanous

reg [26:0] counter = 0;
reg [9:0] TX_reg = 10'b1111111111;
reg start_bit = 0;
reg stop_bit = 1;
reg [4:0] bit_count = 0;


// Module Instantiations
 //Detect positive edge of send signal
wire posedge_send;
positive_edge_detector pos_edge_send(.clock(clock),.signal(send),.positive_edge(posedge_send));
assign state = current_state;
always@(posedge clock)
begin
     current_state <= next_state;
     
end

always@(posedge clock)
begin
   
    
    case(current_state)
   
        IDLE:
        begin
            
            if(posedge_send)
            begin
                counter <= 0;
                TX_reg <= {stop_bit, Data, start_bit};
                next_state <= SEND;
            end
            
            else
            begin
                
                counter <= 0;
                
            end
        
        
        
        end
        
        SEND:
        begin
            
            if(counter == baud_cycles && bit_count < reg_width)
            begin
                
                counter <= 0;
                bit_count <= bit_count + 1;
                TX_reg <= {1'b1, TX_reg[9:1]};
            end
            
            else if (counter == baud_cycles && bit_count == reg_width)
            begin
                
                
                counter <= 0;
                next_state <= IDLE;
                bit_count <= 0;
                led_reg <= ~led_reg;
            end
        
   
            else 
            begin
                
                
                counter <= counter + 1;
            end
            
            
        end
   
   
   
   endcase
end
assign TX = current_state == SEND ? TX_reg[0] : 1'b1;
assign busy = current_state == SEND ? 1'b1 : 1'b0;
assign led = led_reg;
endmodule
