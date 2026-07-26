module smart_uart_logger(

    input wire clk,
    input wire reset,
    input wire uart_rx,

    output wire [7:0] stored_data,
    output wire [3:0] memory_address,
    output wire logger_ready

);


    wire baud_tick;

    wire [7:0] received_data;
    wire data_valid;



    // Baud Generator

    baud_generator baud_gen(

        .clk(clk),
        .reset(reset),
        .baud_tick(baud_tick)

    );



    // UART Receiver

    uart_rx uart_receiver(

        .clk(clk),
        .reset(reset),
        .baud_tick(baud_tick),
        .rx(uart_rx),

        .data_out(received_data),
        .data_valid(data_valid)

    );



    // Data Logger

    data_logger logger(

        .clk(clk),
        .reset(reset),

        .received_data(received_data),
        .data_valid(data_valid),

        .stored_data(stored_data),
        .memory_address(memory_address),
        .logger_ready(logger_ready)

    );


endmodule
