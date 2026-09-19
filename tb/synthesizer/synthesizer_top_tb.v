`timescale 1ns/1ps
module synthesizer_top_tb();
reg clk_tb ;
reg rst_tb;
reg [31:0]phase_increment_tb;
reg [1:0]waveform_select_tb;
reg [3:0]gain_tb;
wire signed [15:0]pcm_sample_tb;
synthesizer_top DUT(
    .clk(clk_tb),
    .rst(rst_tb),
    .phase_increment(phase_increment_tb),
    .waveform_select(waveform_select_tb),
    .gain(gain_tb),
    .pcm_sample(pcm_sample_tb)
);
initial
begin
    $dumpfile("sim/synthesizer_top.vcd");
    $dumpvars(0,synthesizer_top_tb);
    clk_tb=0;
    forever begin 
        #5 clk_tb = ~clk_tb;
    end
end
initial 
begin
    rst_tb=1;
    phase_increment_tb=32'h4000_0000;
    waveform_select_tb=2'b11;
    gain_tb=5;#20
    rst_tb=0;#20
    $finish;
end
endmodule