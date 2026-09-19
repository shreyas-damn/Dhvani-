`timescale 1ns/1ps
module triangle_wave #(
    parameter AMP_WIDTH=16,
    parameter PHASE_WIDTH= 32
)(
    input [PHASE_WIDTH-1:0]phase_in,
    output reg signed [AMP_WIDTH-1:0]amplitude
);
always @(*)
begin
    if(phase_in < (1<<(PHASE_WIDTH-2)) )
    begin
        amplitude = (((1<<(AMP_WIDTH-1))-1)*phase_in)/(1<<(PHASE_WIDTH-2));
    end
    else if(phase_in<(1<<(PHASE_WIDTH-1)))
    begin
        amplitude = ((1<<(AMP_WIDTH-1))-1)-(((1<<(AMP_WIDTH-1))-1)*(phase_in - (1<<(PHASE_WIDTH-2)))/(1<<(PHASE_WIDTH-2)));
    end
    else if(phase_in < 3*(1<<(PHASE_WIDTH-2)))
    begin
        amplitude = -((((1<<(AMP_WIDTH-1))-1)*(phase_in - (1<<(PHASE_WIDTH-1))))/(1<<(PHASE_WIDTH-2)));
    end
    else
    begin
        amplitude = -((1<<(AMP_WIDTH-1))-1) + (((1<<(AMP_WIDTH-1))-1)*(phase_in-(3*(1<<(PHASE_WIDTH-2))))/(1<<(PHASE_WIDTH-2)));
    end
end
endmodule