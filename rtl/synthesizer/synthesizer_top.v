`timescale 1ns/1ps
module synthesizer_top #(
    parameter PHASE_WIDTH = 32,
    parameter AMP_WIDTH = 16
)(
    input clk,
    input rst,
    input [PHASE_WIDTH-1:0]phase_increment,
    input [1:0]waveform_select,
    input [3:0]gain,
    output signed [AMP_WIDTH-1:0]pcm_sample
);
wire [PHASE_WIDTH-1:0]phase;
wire signed [AMP_WIDTH-1:0]sin_amplitude , square_amplitude , tri_amplitude, saw_amplitude , selected_amplitude;
phase_accumulator #(
    .PHASE_WIDTH(PHASE_WIDTH)
)U_phase(
    .clk(clk),
    .rst(rst),
    .phase_inc(phase_increment),
    .phase_out(phase)
);
waveform_lut_32 #(
    .PHASE_WIDTH(PHASE_WIDTH),
    .AMP_WIDTH(AMP_WIDTH)
)U_sine(
    .phase_in(phase),
    .amplitude(sin_amplitude)
);
square_wave #(
    .PHASE_WIDTH(PHASE_WIDTH),
    .AMP_WIDTH(AMP_WIDTH)
)U_square(
    .phase_in(phase),
    .amplitude(square_amplitude)
);
triangle_wave #(
    .PHASE_WIDTH(PHASE_WIDTH),
    .AMP_WIDTH(AMP_WIDTH)
) U_tri(
    .phase_in(phase),
    .amplitude(tri_amplitude)
);
sawtooth_wave #(
    .PHASE_WIDTH(PHASE_WIDTH),
    .AMP_WIDTH(AMP_WIDTH)
) U_saw(
    .phase_in(phase),
    .amplitude(saw_amplitude)
);
waveform_selector #(
    .AMP_WIDTH(AMP_WIDTH)
)U_sel(
    .sin_amplitude(sin_amplitude), 
    .square_amplitude(square_amplitude),
    .tri_amplitude(tri_amplitude),
    .saw_amplitude(saw_amplitude),
    .sel(waveform_select),
    .amp(selected_amplitude)
);
amplitude_control #(
    .AMP_WIDTH(AMP_WIDTH)
) U_amp(
    .amp_in(selected_amplitude),
    .gain(gain),
    .amp_out(pcm_sample)
);
endmodule