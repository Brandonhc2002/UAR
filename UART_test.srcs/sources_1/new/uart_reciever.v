`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2025 12:08:40 AM
// Design Name: 
// Module Name: uart_reciever
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


module uart_reciever(input clock, input RX_async, output [7:0] Data, output byte_recieved);
parameter data_length = 8;

parameter frequency = 100_000_000;
parameter baud = 9_600;

parameter baud_cycles = (frequency / baud)- 1;

parameter IDLE = 2'd0;
parameter READ = 2'd1;
parameter PARITY = 2'd2;
parameter STOP = 2'd3;

reg [1:0] current_state = IDLE;
reg [1:0] next_state = IDLE;

reg [26:0] counter = 0;
reg [7:0] Rx_in;
reg [4:0] count_bits = 0;

wire RX_sync;
wire RX_neg_edge;

reg start_bit_detected = 0;
reg first_bit_read = 0;

reg framing_error = 0;
reg done = 0;

// module instantiations
synchronizer rx_synchronizer(
    .clock(clock),          // System clock
    .async_in(RX_async),     // Asynchronous input signal
    .sync_out(RX_sync)      // Synchronized output signal
);
negative_edge_detector neg_edge_RX (.clock(clock),.signal(RX_sync),.negative_edge(RX_neg_edge));
positive_edge_detector pos_edge_done (.clock(clock),.signal(done),.positive_edge(byte_recieved)); // recived pulse one finished


//Synchronous logic for state states
always@(posedge clock)
begin
    current_state <= next_state;
    case(current_state)
        //Idle waits for UART RX line to be pulled low
        IDLE :
        begin
            done <= 0;
            first_bit_read <= 0;
            count_bits <= 0;
            framing_error <= 0;
        
            if(RX_neg_edge)
            begin
                start_bit_detected <= 1;
            end
            
            //start counting to middle of first data bit
            if(start_bit_detected)
            begin
            
                if(counter == baud_cycles + (baud_cycles/2))
                begin
                    counter <= 0;
                    next_state <= READ;
                    start_bit_detected <= 0;
                end
                
                else
                begin
                    counter <= counter + 1;
                end
            end
        
        
        end

        READ:
        begin
            
            if(~first_bit_read)
            begin
                first_bit_read <= ~first_bit_read;
                Rx_in[7] <= RX_sync;
                count_bits <= count_bits + 1;
            end
        
            else
            begin
                
                if(counter == baud_cycles && count_bits != data_length)
                begin
                    counter <= 0;
                    Rx_in <= {RX_sync, Rx_in[7:1]};
                    count_bits <= count_bits + 1;
                end
                
                else if(counter != baud_cycles && count_bits < data_length)
                begin
                    counter <= counter + 1;
                end
                
                 else
                begin
                    counter <= 0;
                    first_bit_read <= 0;
                    next_state <= STOP;
                    count_bits <= 0;
                end
            
            
            end       
        
        end
        
        STOP:
        begin
        
            if(counter ==  baud_cycles) // Get to the middle of the stop bit.
            begin
                framing_error <= ~RX_sync ? 1'b1 : 1'b0;
                counter <=0;
                done <= 1;
                next_state <= IDLE;
            end
        
            else
            begin
                counter <= counter + 1;
            end
        
        end
        
        default:
        begin
            next_state <= IDLE;
            counter <= 0;
        end 
        
    endcase
end

assign Data = Rx_in;


endmodule
