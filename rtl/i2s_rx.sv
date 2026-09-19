/* I2S RECEIVER MODULE:- 
    sys_clk is the main clock of the chip running at 50mhz or 100mhz
    rst_n active low reset, when it drops to 0, all counters and shift registers turn empty
    sclk is the slower clock which watches over our input data
    lrclk indicates which channel the data goes, our module detects shift in this and creates a new starting point for the DF
    sd is the actual data bits 

*/
module i2s_rx #(
    parameter DATA_WIDTH = 24,
    parameter FRAME_WIDTH = 32
    )(
    input wire sys_clk,
    input wire sclk,

    input wire lrclk,
    input wire sd,
    input wire rst_n,

    output reg [DATA_WIDTH-1:0] left_data,
    output reg [DATA_WIDTH-1:0] right_data,
    output reg valid
);

//we have sclk coming from external world, hence we oversample it using in-house 50mhz clock to synchronize and avoid metastability

reg sff1, sff2, sff3;
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        sff1 <= 1'b0;
        sff2 <= 1'b0;
        sff3 <= 1'b0;
    end
    else begin
        sff1 <= sclk;   // raw wire input
        sff2 <= sff1;   // current state
        sff3 <= sff2;   // past state
    end
end
wire sclk_rise = (sff2 == 1'b1) && (sff3 == 1'b0); // checks if current state is 1, and previous state is 0


//we have lrclk coming from the external world aswell, hence oversampling must be done here aswell

reg lrff1, lrff2, lrff3;
always @(posedge sys_clk or negedge rst_n) begin
    if(!rst_n) begin
        lrff1 <= 1'b0;
        lrff2 <= 1'b0;
        lrff3 <= 1'b0;
    end
    else begin
        lrff1 <= lrclk;
        lrff2 <= lrff1;
        lrff3 <= lrff2;
    end
end
wire lrclk_toggle = (lrff2 != lrff3); // we get to know when lrclk is toggled when we compare the past and present states of them


// sd is also coming from external source hence we must synhronize (but no edge detection required)

reg sdff1, sdff2;
always @(posedge sys_clk or negedge rst_n) begin
    if(!rst_n) begin
        sdff1 <= 1'b0;
        sdff2 <= 1'b0;
    end
    else begin
        sdff1 <= sd;
        sdff2 <= sdff1;
    end
end

// Creating a 32 bit counter to keep in track the data bits going into the sipo

reg [5:0] counter;
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        counter <= 6'b0;
    end
    else if (lrclk_toggle) begin
        counter <= 6'b0;
    end
    else if (sclk_rise) begin
        counter <= counter + 1'b1;
    end
end
wire shift_enable;
assign shift_enable = sclk_rise && (counter >= 6'b1) && (counter <= DATA_WIDTH);



//shift register accepts the serial data bits and converts and stores it as 24 bit parallel data

reg [DATA_WIDTH-1:0] shift_reg;
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        shift_reg <= {(DATA_WIDTH){1'b0}};
    end
    else if (shift_enable) begin 
        shift_reg <= {shift_reg[DATA_WIDTH-2:0], sdff2};
    end
end

always @(posedge sys_clk or negedge rst_n) begin
    if(!rst_n) begin
        left_data <= {(DATA_WIDTH){1'b0}};
        right_data <= {(DATA_WIDTH){1'b0}};
        valid <= 1'b0;
    end
    else begin
        valid <= 1'b0;
        if (lrclk_toggle) begin
            if (lrff3 == 1'b0) begin
                left_data <= shift_reg;
            end 
            else begin
                right_data <= shift_reg;
                valid <= 1'b1;
            end
        end
    end
end

endmodule