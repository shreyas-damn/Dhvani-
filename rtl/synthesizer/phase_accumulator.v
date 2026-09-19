`timescale 1ns/1ps
module phase_accumulator#(
    parameter PHASE_WIDTH=32
)(
    input clk,
    input rst,
    input [PHASE_WIDTH-1:0]phase_inc,
    output reg [PHASE_WIDTH-1:0]phase_out
);
always @(posedge clk)
begin
    if(rst==1)
    begin
        phase_out<=0;
    end
    else
    begin
        phase_out<=phase_out+phase_inc;
    end

end
endmodule