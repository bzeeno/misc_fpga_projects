module fifo_ctrl
#(
    parameter ADDR_WIDTH = 2, R_ADDR_WIDTH=ADDR_WIDTH*2
)
(
    input wire clk, reset,
    input wire rd, wr,
    output wire empty, full,
    output wire [ADDR_WIDTH-1:0] w_addr, 
    output wire [R_ADDR_WIDTH-1:0] r_addr, r_addr_next // needs to be 2x as many read addresses
);

    // signal dec
    reg [ADDR_WIDTH-1:0] w_ptr_reg, w_ptr_next, w_ptr_succ;
    reg [R_ADDR_WIDTH-1:0] r_ptr_reg, r_ptr_next, r_ptr_succ;
    reg full_reg, empty_reg, full_next, empty_next;
    
    // fifo control logic
    always @(posedge clk, posedge reset)
    begin
        if(reset)
            begin
                w_ptr_reg <= 0;
                r_ptr_reg <= 0;
                full_reg <= 1'b0;
                empty_reg <= 1'b1;            
            end
        else
            begin
                w_ptr_reg <= w_ptr_next;
                r_ptr_reg <= r_ptr_next;
                full_reg <= full_next;
                empty_reg <= empty_next; 
            end
    end
    
    // next state logic for pointers
    always @*
    begin
        // successive pointer values
        w_ptr_succ = w_ptr_reg + 1;
        r_ptr_succ = r_ptr_reg + 1;
        // default: keep previous values
        w_ptr_next = w_ptr_reg;
        r_ptr_next = r_ptr_reg;
        full_next = full_reg;
        empty_next = empty_reg;
        case({wr, rd})
            // 2'b00: Do nothing
            2'b01: // read
                if(~empty_reg)
                    begin
                        r_ptr_next = r_ptr_succ;
                        full_next = 1'b0;
                        // buffer empty if:
                        // next r_ptr points to first half and w_ptr is on same addr
                        // OR if next r_ptr is at 0 and w_ptr is as well
                        if( (r_ptr_succ/w_ptr_reg==2) || (r_ptr_succ==0 && w_ptr_reg==0) )  
                            empty_next = 1'b1;                            
                    end
            2'b10: // write
                if(~full_reg)
                    begin
                        w_ptr_next = w_ptr_succ;
                        empty_next = 1'b0;
                        // buffer full if:
                        // next w_ptr points to same as r_ptr and r_ptr is on first half
                        // OR if r_ptr is at 0 and next w_ptr is as well
                        if( (r_ptr_reg/w_ptr_succ==2) || (w_ptr_succ==0 && r_ptr_reg==0) )
                            full_next = 1'b1; // if w_ptr_succ is on second half and is same addr as r_ptr_reg 
                                              // two OR statements handle if r_ptr_addr is 0 or 1 since those are special cases
                    end
            2'b11: // read and write
                begin
                    w_ptr_next = w_ptr_succ;
                    r_ptr_next = r_ptr_succ;
                end
                    
        endcase
    end
    
    // output 
    assign w_addr = w_ptr_reg;
    assign r_addr = r_ptr_reg;
    assign r_addr_next = r_ptr_next;
    assign full = full_reg;
    assign empty = empty_reg;
    

endmodule