`timescale 1ns/1ps
module generic_fifo_tb();
reg clk_tb;
reg rst_tb;
reg wr_en_tb;
reg rd_en_tb;
reg [15:0]din_tb;
wire [15:0]dout_tb;
wire full_tb;
wire empty_tb;
generic_fifo DUT(
    .clk(clk_tb),
    .rst(rst_tb),
    .wr_en(wr_en_tb),
    .rd_en(rd_en_tb),
    .din(din_tb),
    .dout(dout_tb),
    .full(full_tb),
    .empty(empty_tb)
);
initial
begin
$dumpfile("generic_fifo.vcd");
$dumpvars(0, generic_fifo_tb);
clk_tb=0;
end
always 
begin
    #5 clk_tb=~clk_tb;
end
initial 
begin
rst_tb=1;
wr_en_tb=0;
rd_en_tb=0;
din_tb=0;#20
rst_tb=0;
wr_en_tb=1;
din_tb=16'h0011;#10
din_tb=16'h0012;#10
din_tb=16'h0013;#10
wr_en_tb=0;
rd_en_tb=1;#40
rd_en_tb=0;#10
$finish;
end
endmodule