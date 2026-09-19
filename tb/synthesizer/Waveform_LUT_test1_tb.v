`timescale 1ns/1ps
module waveform_LUT_test1_tb();
reg [3:0]phase_in_tb;
wire signed [7:0]amplitude_tb;
waveform_LUT #(
    .PHASE_WIDTH(4),
    .AMP_WIDTH(8)
)DUT (
    .phase_in(phase_in_tb),
    .amplitude(amplitude_tb)
    );
initial
begin
    $dumpfile("waveform_LUT_test1.vcd");
    $dumpvars(0, waveform_LUT_test1_tb);
    phase_in_tb=0;#10
    phase_in_tb=1;#10
    phase_in_tb=2;#10
    phase_in_tb=3;#10
    phase_in_tb=4;#10
    phase_in_tb=5;#10
    phase_in_tb=6;#10
    phase_in_tb=7;#10
    phase_in_tb=8;#10
    phase_in_tb=9;#10
    phase_in_tb=10;#10
    phase_in_tb=11;#10
    phase_in_tb=12;#10
    phase_in_tb=13;#10
    phase_in_tb=14;#10
    phase_in_tb=15;#10
    $finish;
end
endmodule