module data_logger(
    input wire clk,
    input wire reset,

    input wire [7:0] received_data,
    input wire data_valid,

    output reg [7:0] stored_data,
    output reg [3:0] memory_address,
    output reg logger_ready
);


    // Memory buffer
    reg [7:0] memory [0:15];


    always @(posedge clk or posedge reset) begin


        if(reset) begin

            memory_address <= 0;
            stored_data <= 0;
            logger_ready <= 0;

        end


        else begin


            logger_ready <= 0;


            if(data_valid) begin


                // Store received byte
                memory[memory_address] <= received_data;


                // Output stored byte
                stored_data <= received_data;


                // Indicate successful logging
                logger_ready <= 1;


                // Increment address
                if(memory_address == 15)
                    memory_address <= 0;

                else
                    memory_address <= memory_address + 1;


            end


        end


    end


endmodule
