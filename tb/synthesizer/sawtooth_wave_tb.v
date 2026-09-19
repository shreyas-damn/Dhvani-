`timescale 1ns/1ps
module sawtooth_wave_tb();
reg [31:0]phase_in_tb;
wire signed [15:0]amplitude_tb;
sawtooth_wave DUT(
    .phase_in(phase_in_tb),
    .amplitude(amplitude_tb)
);
initial
begin
    $dumpfile("sim/sawtooth_wave.vcd");
    $dumpvars(0,sawtooth_wave_tb);
     phase_in_tb = 0;#10
    phase_in_tb = (1 << 30);#10
    phase_in_tb = (1 << 31);#10
    phase_in_tb = 3*(1 << 30);#10
    phase_in_tb = 32'hFFFFFFFF;#10
    phase_in_tb = 0;#10
    $finish;
end 
endmodule