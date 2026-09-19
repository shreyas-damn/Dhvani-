`timescale 1ns/1ps
module phase_accu_wrap_tb();
reg clk_tb;
reg rst_tb;
reg [3:0]phase_inc_tb;
wire [3:0]phase_out_tb;
phase_accumulator #(
    .PHASE_WIDTH(4)
) DUT (
    .clk(clk_tb),
    .rst(rst_tb),
    .phase_inc(phase_inc_tb),
    .phase_out(phase_out_tb)
    );
initial
begin
    $dumpfile("phase_accu_wrap.vcd");
    $dumpvars(0, phase_accu_wrap_tb);
    clk_tb=0;
end
always
begin
    #10;
    clk_tb=~clk_tb;
end
initial
begin
    rst_tb=1;
    phase_inc_tb=3;#20
    rst_tb=0;#150
    $finish;
end
endmodule 