`timescale 1ns / 1ps

module fifo_testbench();

    localparam DATA_WIDTH=8, ADDR_WIDTH=2, R_DATA_WIDTH = DATA_WIDTH/2, T=20;// number of bits in word, number of address bits, clock period
     reg clk, reset;
     reg rd, wr;
     reg [DATA_WIDTH-1:0] w_data;
     wire empty, full;
     wire [R_DATA_WIDTH-1:0] r_data;
     
    fifo #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) uut( // number of bits in word, number of address bits
        .clk(clk), .reset(reset), .rd(rd), .wr(wr), .w_data(w_data), .empty(empty), .full(full), .r_data(r_data)
    );
    
    always
    begin
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end
        
    initial
    begin
        reset = 1'b1;
        #(T/2);
        reset = 1'b0;
    end
    
    initial
    begin
        #200;
        rd = 1'b0;
        wr = 1'b1;
        w_data = 8'b00000001;
        #200;
        rd = 1'b0;
        wr = 1'b1;
        w_data = 8'b00000011;
        #200;
        rd = 1'b0;
        wr = 1'b1;
        w_data = 8'b10000000;
        #200;
        rd = 1'b0;
        wr = 1'b1;
        w_data = 8'b00110000;
        #200;
        rd = 1'b0;
        wr = 1'b1;
        w_data = 8'b00000000;
        #200;
        rd = 1'b1;
        wr = 1'b0;
        #200;
        rd = 1'b0;
        wr = 1'b0;
        #200;
        rd = 1'b1;
        wr = 1'b0;
        #200;
        rd = 1'b0;
        wr = 1'b0;
        #200;
        rd = 1'b1;
        wr = 1'b0;
        #200;
    end

endmodule
