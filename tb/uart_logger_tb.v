module uart_logger_tb;


reg clk;
reg reset;
reg uart_rx;


wire [7:0] stored_data;
wire [3:0] memory_address;
wire logger_ready;



// Clock generation
// 50 MHz clock = 20 ns period

always #10 clk = ~clk;



// DUT

smart_uart_logger dut(

    .clk(clk),
    .reset(reset),
    .uart_rx(uart_rx),

    .stored_data(stored_data),
    .memory_address(memory_address),
    .logger_ready(logger_ready)

);




// UART transmit task

task uart_send;

input [7:0] data;

integer i;

begin

    // Start bit
    uart_rx = 0;
    #104160;


    // Data bits
    for(i=0;i<8;i=i+1)
    begin

        uart_rx = data[i];
        #104160;

    end


    // Stop bit
    uart_rx = 1;
    #104160;


end

endtask



initial begin


    // Waveform generation

    $dumpfile("sim/uart_logger.vcd");
    $dumpvars(0,uart_logger_tb);



    clk = 0;
    reset = 1;
    uart_rx = 1;



    #100;

    reset = 0;



    // Send test byte
    #500000;
    uart_send(8'hAA);



    #200000;



    $display("Stored Data = %h", stored_data);

    $display("Memory Address = %d", memory_address);



    $finish;


end



endmodule
