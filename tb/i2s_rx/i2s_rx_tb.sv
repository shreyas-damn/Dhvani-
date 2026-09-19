`timescale 1ns / 1ps

module tb_i2s_rx();

    // Parameters
    localparam DATA_WIDTH = 24;
    localparam FRAME_WIDTH = 32;

    // DUT Signals
    reg sys_clk;
    reg sclk;
    reg lrclk;
    reg sd;
    reg rst_n;

    wire [DATA_WIDTH-1:0] left_data;
    wire [DATA_WIDTH-1:0] right_data;
    wire valid;

    // Instantiate the Device Under Test (DUT)
    i2s_rx #(
        .DATA_WIDTH(DATA_WIDTH),
        .FRAME_WIDTH(FRAME_WIDTH)
    ) dut (
        .sys_clk(sys_clk),
        .sclk(sclk),
        .lrclk(lrclk),
        .sd(sd),
        .rst_n(rst_n),
        .left_data(left_data),
        .right_data(right_data),
        .valid(valid)
    );

    // Clock Generation (50 MHz sys_clk)
    initial sys_clk = 0;
    always #10 sys_clk = ~sys_clk;

    // Clock Generation (~3 MHz sclk)
    initial sclk = 0;
    always #160 sclk = ~sclk;

    // Task to send a single I2S frame (Left or Right)
    task send_frame(input logic [DATA_WIDTH-1:0] payload, input logic channel);
        integer i;
        begin
            // 1. Wait for the falling edge before changing ANY signals!
            @(negedge sclk);
            
            // 2. Change lrclk and send the dummy bit at the exact same time
            lrclk = channel;
            sd = 1'b0; 

            // 3. Send the 24-bit payload, MSB first
            for (i = DATA_WIDTH-1; i >= 0; i = i - 1) begin
                @(negedge sclk); // Change data on the falling edge
                sd = payload[i]; // Receiver captures it on the rising edge
            end

            // 4. Send the remaining padding bits (FRAME_WIDTH - DATA_WIDTH - 1)
            for (i = 0; i < (FRAME_WIDTH - DATA_WIDTH - 1); i = i + 1) begin
                @(negedge sclk);
                sd = 1'b0;
            end
            
            // Wait for the final rising edge of the frame to complete
            @(posedge sclk);
        end
    endtask

    // Main Test Sequence
    initial begin
        // Initialize signals
        lrclk = 1'b1; // Start high so toggling to 0 starts the Left channel
        sd = 1'b0;
        rst_n = 1'b0;

        // Apply Reset
        #100;
        @(posedge sys_clk);
        rst_n = 1'b1;

        // Send Left Channel Data: 24'hAABBCC
        send_frame(24'hAABBCC, 1'b0);

        // Send Right Channel Data: 24'h112233
        send_frame(24'h112233, 1'b1);

        // Send a dummy Left frame to let the Right channel finish and fire the 'valid' pulse
        send_frame(24'h000000, 1'b0);

        send_frame(24'h123456, 1'b1);

        #1000000
        // Let the simulation run for a few more clocks to observe outputs
        #500;
        $finish;
    end

    // Waveform dumping for GTKWave or similar viewers
    initial begin
        $dumpfile("sim/i2s_rx/i2s_rx.vcd");
        $dumpvars(0, tb_i2s_rx);
    end

endmodule