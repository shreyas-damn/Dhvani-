`timescale 1ns/1ps
module triangle_wave_tb();
reg [31:0]phase_in_tb;
wire signed [15:0]amplitude_tb;
triangle_wave DUT(
    .phase_in(phase_in_tb),
    .amplitude(amplitude_tb)
);
initial
begin
    $dumpfile("sim/triangle_wave.vcd");
    $dumpvars(0,triangle_wave_tb);
    phase_in_tb = 0 ; #10
    phase_in_tb=(1<<(29));#10
    phase_in_tb=(1<<(30));#10
    phase_in_tb=3*(1<<(29));#10
    phase_in_tb=(1<<(31));#10
    phase_in_tb=5*(1<<(29));#10
    phase_in_tb=3*(1<<(30));#10
    phase_in_tb=7*(1<<(29));#10
    phase_in_tb=0;
    $finish;
end 
endmodule