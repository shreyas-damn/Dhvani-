`timescale 1ns/1ps
module waveform_lut_32 #(
    parameter PHASE_WIDTH= 32,
    parameter AMP_WIDTH = 16 
)(
    input [PHASE_WIDTH-1:0]phase_in,
    output reg signed [AMP_WIDTH-1:0]amplitude
);
reg signed  [AMP_WIDTH-1:0] LUT_memory[0:255];
initial begin
    $readmemh("scripts/sine_lut.mem",LUT_memory);
end
always @(*)
begin
    amplitude=LUT_memory[phase_in[PHASE_WIDTH-1 -:8]]; 
end
endmodule