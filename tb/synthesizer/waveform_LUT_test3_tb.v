`timescale 1ns/1ps
module waveform_LUT_test3_tb();
reg clk_tb;
reg rst_tb;
reg [3:0]phase_inc_tb;
wire [3:0]phase_in_tb;
wire signed [7:0]amplitude_tb;
phase_accumulator DUT_1 (
    .clk(clk_tb),
    .rst(rst_tb),
    .phase_inc(phase_inc_tb),
    .phase_out(phase_in_tb)
);
waveform_LUT #(
    .PHASE_WIDTH(4),
    .AMP_WIDTH(8)
)DUT_2 (
    .phase_in(phase_in_tb),
    .amplitude(amplitude_tb)
    );
initial
begin
    $dumpfile("waveform_LUT_test3.vcd");
    $dumpvars(0, waveform_LUT_test3_tb);
    clk_tb = 0;
    phase_inc_tb=1;
    rst_tb=1;#20
    rst_tb=0;
end
always
begin
    #10;
    clk_tb=~clk_tb;
end

initial
begin
    phase_inc_tb = 2;#320
    phase_inc_tb = 4;#160
    phase_inc_tb = 8;#80
    $finish;
end
endmodule