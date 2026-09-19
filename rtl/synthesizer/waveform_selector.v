`timescale 1ns/1ps
module waveform_selector #(
    parameter AMP_WIDTH = 16
)(
    input signed [AMP_WIDTH-1:0]sin_amplitude ,
    input signed [AMP_WIDTH-1:0]square_amplitude ,
    input signed [AMP_WIDTH-1:0]tri_amplitude ,
    input signed [AMP_WIDTH-1:0]saw_amplitude ,
    input [1:0]sel,
    output reg signed [AMP_WIDTH-1:0]amp
);
always @(*)
begin
    case(sel)
    2'b00 : amp = sin_amplitude;
    2'b01 : amp = square_amplitude;
    2'b10 : amp = tri_amplitude;
    2'b11 : amp = saw_amplitude;
    default : amp = 0;
    endcase
end
endmodule