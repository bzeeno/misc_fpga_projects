`timescale 1ns / 1ps

module fifo #(parameter DATA_WIDTH=8, ADDR_WIDTH=2, R_ADDR_WIDTH=ADDR_WIDTH*2 ,R_DATA_WIDTH = DATA_WIDTH/2) ( // number of bits in word, number of address bits
     input wire clk, reset,
     input wire rd, wr,
     input wire [DATA_WIDTH-1:0] w_data,
     output wire empty, full,
     output wire [R_DATA_WIDTH-1:0] r_data
    );
    
    // signal dec
    wire [ADDR_WIDTH-1:0] w_addr;
    wire [R_ADDR_WIDTH-1:0] r_addr, r_addr_next;
    wire wr_en, full_tmp;
    
    // write enabled only when FIFO not full
    assign wr_en = wr & ~full_tmp;
    assign full = full_tmp;
    
    // instantiate fifo ctrl
    fifo_ctrl #(.ADDR_WIDTH(ADDR_WIDTH)) 
        c_unit 
            (.clk(clk), .reset(reset), .rd(rd), .wr(wr), .empty(empty), .full(full_tmp), 
             .w_addr(w_addr), .r_addr(r_addr), .r_addr_next(r_addr_next));
    
    // instantiate register file
    reg_file #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH), .R_DATA_WIDTH(R_DATA_WIDTH)) 
        r_unit(.clk(clk), .wr_en(wr_en), .w_addr(w_addr), .r_addr(r_addr), 
               .w_data(w_data), .r_data(r_data));
                        
endmodule
