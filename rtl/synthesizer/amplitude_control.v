`timescale 1ns/1ps
module amplitude_control #(
    parameter AMP_WIDTH = 16
)(
    input signed [AMP_WIDTH-1:0]amp_in,
    input [3:0]gain,
    output reg signed [AMP_WIDTH-1:0]amp_out
);
reg signed [AMP_WIDTH+3:0]product;
reg signed [4:0]gain_signed;
always @(*)
begin
    gain_signed=gain;
    product = amp_in*gain_signed;
    amp_out=product/15;
end
endmodule