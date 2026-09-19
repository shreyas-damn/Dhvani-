`timescale 1ns/1ps
module waveform_LUT_test2_tb();
reg clk_tb;
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
    $dumpfile("waveform_LUT_test2.vcd");
    $dumpvars(0, waveform_LUT_test2_tb);
    clk_tb = 0;
    phase_in_tb=0;
end
always
begin
    #10;
    clk_tb=~clk_tb;
end
always @(posedge clk_tb)
begin
    phase_in_tb=phase_in_tb+1;
end
initial
begin
    #320 ;
    $finish;
end
endmodule