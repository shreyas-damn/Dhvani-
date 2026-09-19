`timescale 1ns/1ps
module square_wave #(
    parameter PHASE_WIDTH=32, 
    parameter AMP_WIDTH=16
)(
    input [PHASE_WIDTH-1:0]phase_in,
    output reg signed [AMP_WIDTH-1:0] amplitude
);
always @ (*)
begin
    if (phase_in < (1<<(PHASE_WIDTH-1)))
    begin
        amplitude= ((1<<(AMP_WIDTH-1))-1);
    end
    else
    begin
        amplitude=-((1<<(AMP_WIDTH-1))-1);
    end
end
endmodule