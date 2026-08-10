`timescale 1ns/1ps
module generic_fifo #(
    parameter DATA_WIDTH =16,
    parameter DEPTH = 256
)(
    input clk,
    input rst,
    input wr_en,
    input rd_en,
    input [DATA_WIDTH-1:0] din,
    output reg [DATA_WIDTH-1:0] dout,
    output full,
    output empty
);
reg [$clog2(DEPTH)-1:0] wr_ptr;
reg [$clog2(DEPTH)-1:0] rd_ptr;
reg [$clog2(DEPTH):0] count ;
reg [(DATA_WIDTH-1):0] fifo_memory[0:DEPTH-1];
always @(posedge clk)
begin
    if(rst==1)
    begin
        wr_ptr <= 0;
        rd_ptr <= 0;
        count <= 0;
        dout <= 0;
    end
    else 
    begin
        if(wr_en==1&&count<DEPTH)
        begin
            fifo_memory[wr_ptr]<=din;
            if(wr_ptr<DEPTH-1)
            begin
                wr_ptr<=wr_ptr+1;
            end
            else
            begin
                wr_ptr<=0;
            end
        end
        else
        begin
            // nothing
        end
        if(rd_en==1&&count!=0)
        begin
            dout<=fifo_memory[rd_ptr];
            if(rd_ptr<DEPTH-1)
            begin
                rd_ptr<=rd_ptr+1;
            end
            else
            begin
                rd_ptr<=0;
            end
        end
        else
        begin
            //nothing
        end
        if((wr_en==1&&count<DEPTH)&&(rd_en==1&&count!=0))
        begin
            //nochange
        end
        else if(wr_en==1&&count<DEPTH)
        begin
            count<=count+1;
        end
        else if(rd_en==1&&count!=0)
        begin
            count<=count-1;
        end
        else
        begin
            //no change
        end
    end
end
assign empty = (count==0);
assign full = (count==DEPTH);
endmodule