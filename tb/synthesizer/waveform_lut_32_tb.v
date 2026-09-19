`timescale 1ns/1ps
module waveform_lut_32_tb();
reg [31:0]phase_in_tb;
wire signed [15:0]amplitude_tb;
waveform_lut_32 DUT(
    .phase_in(phase_in_tb),
    .amplitude(amplitude_tb)
);
initial begin
    $dumpfile("waveform_lut_32.vcd");
    $dumpvars(0, waveform_lut_32_tb);
    phase_in_tb= 0;#10
    phase_in_tb=1073741824;#10
    phase_in_tb=2147483648;#10
    phase_in_tb=3221225472;#10
    phase_in_tb=0;
    $finish ; 
end
endmodule