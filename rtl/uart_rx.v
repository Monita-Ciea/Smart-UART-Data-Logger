module uart_rx(

    input wire clk,
    input wire reset,
    input wire baud_tick,
    input wire rx,

    output reg [7:0] data_out,
    output reg data_valid

);


parameter IDLE  = 3'b000;
parameter START = 3'b001;
parameter DATA  = 3'b010;
parameter STOP  = 3'b011;
parameter DONE  = 3'b100;


reg [2:0] state;

reg [7:0] shift_reg;

reg [3:0] bit_count;

reg [15:0] sample_counter;

reg sample_enable;



always @(posedge clk or posedge reset)
begin

    if(reset)
    begin

        state <= IDLE;
        shift_reg <= 0;
        bit_count <= 0;
        sample_counter <= 0;
        data_out <= 0;
        data_valid <= 0;

    end


    else
    begin

        data_valid <= 0;


        case(state)


        IDLE:
        begin

            if(rx == 0)
            begin

                state <= START;
                sample_counter <= 0;

            end

        end



        START:
        begin

            if(baud_tick)
            begin

                if(rx == 0)
                begin

                    bit_count <= 0;
                    state <= DATA;

                end

                else
                begin

                    state <= IDLE;

                end

            end

        end



        DATA:
        begin

            if(baud_tick)
            begin

                shift_reg[bit_count] <= rx;


                if(bit_count == 7)
                begin

                    state <= STOP;

                end

                else
                begin

                    bit_count <= bit_count + 1;

                end

            end

        end



        STOP:
        begin

            if(baud_tick)
            begin

                if(rx == 1)
                    state <= DONE;

                else
                    state <= IDLE;

            end

        end



        DONE:
        begin

            data_out <= shift_reg;
            data_valid <= 1;

            $display("UART Received Data = %h",shift_reg);

            state <= IDLE;

        end


        default:
            state <= IDLE;


        endcase

    end

end


endmodule
