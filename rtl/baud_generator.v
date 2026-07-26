module baud_generator #(
    parameter CLK_FREQ = 50000000,
    parameter BAUD_RATE = 9600
)(
    input wire clk,
    input wire reset,

    output reg baud_tick
);

    parameter DIVIDER = CLK_FREQ / BAUD_RATE;

    reg [31:0] counter;

    always @(posedge clk or posedge reset) begin

        if(reset) begin
            counter <= 0;
            baud_tick <= 0;
        end

        else begin

            if(counter == DIVIDER-1) begin
                counter <= 0;
                baud_tick <= 1;
            end

            else begin
                counter <= counter + 1;
                baud_tick <= 0;
            end

        end

    end

endmodule
