`timescale 1ns/1ps
module waveform_selector_tb();
reg signed[15:0]sin_amplitude_tb;
reg signed[15:0]square_amplitude_tb;
reg signed[15:0]tri_amplitude_tb;
reg signed[15:0]saw_amplitude_tb;
reg [1:0]sel_tb;
wire signed[15:0]amp_tb;
waveform_selector DUT(
    .sin_amplitude(sin_amplitude_tb),
    .square_amplitude(square_amplitude_tb),
    .tri_amplitude(tri_amplitude_tb),
    .saw_amplitude(saw_amplitude_tb),
    .sel(sel_tb),
    .amp(amp_tb)
);
initial
begin
    $dumpfile("sim/waveform_selector.vcd");
    $dumpvars(0,waveform_selector_tb);
    sin_amplitude_tb=1000;
    square_amplitude_tb=2000;
    tri_amplitude_tb=3000;
    saw_amplitude_tb=4000;
    sel_tb=00;#10
    sel_tb=01;#10
    sel_tb=10;#10
    sel_tb=11;#10
    $finish;
end
endmodule 