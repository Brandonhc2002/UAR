module UART_test(
    input wire clock,
    input wire UART_RX,
    output wire UART_TX,
    output wire [6:0] segments_annode,
    output wire [7:0] digit_place_annode
);

    // Wires for UART and display
    wire [7:0] Data;
    wire byte_received;
    reg [7:0] number = 0;

    wire [7:0] digit_place;
    wire [6:0] segments;

    assign segments_annode = ~segments;
    assign digit_place_annode = ~digit_place;

    // UART TX path
    reg [7:0] TX = 0;
    reg send = 0;
    wire busy;

    // UART Receiver module
    uart_reciever uart_rx_inst (
        .clock(clock),
        .RX_async(UART_RX),
        .Data(Data),
        .byte_recieved(byte_received)
    );

    // UART Transmitter module
    uart_transmitter uart_tx_inst (
        .clock(clock),
        .Data(TX),
        .send(send),
        .TX(UART_TX),
        .busy(busy)
    );

    // 7-Segment display controller
    four_digit_7_segment display (
        .clock(clock),
        .number(number),
        .digit_place(digit_place),
        .segments(segments)
    );

    // Main behavior
    always @(posedge clock) begin
        send <= 0;  // Default to 0

        if (byte_received && !busy) begin
            number <= Data;   // Update display value
            TX <= Data;       // Echo the byte
            send <= 1;        // Trigger transmission
        end
    end

endmodule
