`timescale 1ns / 1ps

module testbench_bcd_to_bin();

    localparam T=20;
    reg clk, reset, start;
    reg [3:0] bcd3, bcd2, bcd1, bcd0;
    wire ready, done_tick;
    wire [9:0] bin;
    
    always
        begin
            clk = 1'b1;
            #(T/2);
            clk = 1'b0;
            #(T/2);
        end
    
    bcd_to_binary uut (
        .clk(clk), .reset(reset),
        .start(start),
        .bcd3(bcd3), .bcd2(bcd2), .bcd1(bcd1), .bcd0(bcd0),
        .ready(ready), .done_tick(done_tick),
        .bin(bin)
    );
    
    
    initial
    begin
        reset=1'b1;
        #T;
        reset=1'b0;
        bcd3=4'd1;
        bcd2=4'd0;
        bcd1=4'd0;
        bcd0=4'd2;
        start=1'b1;
        #T;
        start=1'b0;    
    end
    
    
    

endmodule
