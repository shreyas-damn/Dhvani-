`timescale 1ns/1ps
module amplitude_control_tb();
reg signed [15:0]amp_in_tb;
reg [3:0]gain_tb;
wire signed [15:0]amp_out_tb;
amplitude_control DUT (
    .amp_in(amp_in_tb),
    .gain(gain_tb),
    .amp_out(amp_out_tb)
);
initial 
begin
    $dumpfile("sim/amplitude_control.vcd");
    $dumpvars(0,amplitude_control_tb);
    amp_in_tb=10000;
    gain_tb=0;#10
    amp_in_tb=10000;
    gain_tb=8;#10
    amp_in_tb=10000;
    gain_tb=15;#10
    amp_in_tb=-10000;
    gain_tb=8;#10
    amp_in_tb=-10000;
    gain_tb=15;#10
    $finish;
end
endmodule