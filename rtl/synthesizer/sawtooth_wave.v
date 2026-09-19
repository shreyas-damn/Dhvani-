`timescale 1ns/1ps
module sawtooth_wave #(
    parameter AMP_WIDTH = 16,
    parameter PHASE_WIDTH = 32
)(
    input [PHASE_WIDTH-1:0]phase_in,
    output reg signed [AMP_WIDTH-1:0]amplitude
);
always @(*)
begin
    amplitude = (phase_in >> (PHASE_WIDTH - AMP_WIDTH))- (1 << (AMP_WIDTH - 1));
end
endmodule