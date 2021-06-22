`timescale 1ns / 1ps

module bcd_to_binary(
    input wire clk, reset,
    input wire start,
    input wire [3:0] bcd3, bcd2, bcd1, bcd0,
    output reg ready, done_tick,
    output wire [9:0] bin
    );
    
    // symbolic states
    localparam [1:0] 
        idle = 2'b00,
        op = 2'b01,
        done = 2'b10;
        
    // signal declarations
    reg [1:0] state_reg, state_next;
    reg [9:0] bin_reg, bin_next;
    reg [3:0] n_reg, n_next;
    reg [3:0] bcd3_reg, bcd2_reg, bcd1_reg, bcd0_reg;
    reg [3:0] bcd3_next, bcd2_next, bcd1_next, bcd0_next;
    
    always @(posedge clk, posedge reset)
    begin
        if(reset)
        begin
            state_reg <= idle;
            n_reg <= 0;
            bin_reg <= 0;
            bcd3_reg <= 0;
            bcd2_reg <= 0;
            bcd1_reg <= 0; 
            bcd0_reg <= 0;
        end
        
        else
        begin
            state_reg <= state_next;
            n_reg <= n_next;
            bin_reg <= bin_next;
            bcd3_reg <= bcd3_next;
            bcd2_reg <= bcd2_next;
            bcd1_reg <= bcd1_next; 
            bcd0_reg <= bcd0_next;
        end
    
    end
    
    
    always @*
    begin
        // defaults
        state_next = state_reg;
        n_next = n_reg;
        bin_next = bin_reg;
        bcd3_next = bcd3;
        bcd2_next = bcd2;
        bcd1_next = bcd1;
        bcd0_next = bcd0;
        ready = 1'b0;
        done_tick = 1'b0;
        case(state_reg)
            
            idle:
            begin
                ready = 1'b1;
                if(start)
                begin
                    state_next = op;
                    n_next = 4'b1010; // initial index=10 (how many bits in bin
                    bin_next = 10'b0000000000; // initialize bin to 0
                end
            end
            
            op:
            begin
                // shift everything right 1 bit
                bin_next = {bcd0_reg[0], bin_reg[9:1]}; // msb bcd0 to msb bin
                bcd3_next = {1'b0, bcd3_reg[3:1]}; // 0 to msb bcd 3
                // if shifted bcd > 4: shift and sub 3 ELSE: shift
                bcd2_next = ({bcd3_reg[0], bcd2_reg[3:1]} > 4) ? ({bcd3_reg[0], bcd2_reg[3:1]} - 4'b0011) : {bcd3_reg[0], bcd2_reg[3:1]};
                bcd1_next = ({bcd2_reg[0], bcd1_reg[3:1]} > 4) ? ({bcd2_reg[0], bcd1_reg[3:1]} - 4'b0011) : {bcd2_reg[0], bcd1_reg[3:1]};
                bcd0_next = ({bcd1_reg[0], bcd0_reg[3:1]} > 4) ? ({bcd1_reg[0], bcd0_reg[3:1]} - 4'b0011) : {bcd1_reg[0], bcd0_reg[3:1]};
                
                n_next = n_reg - 1; // decrement index
                if(n_next == 0)
                    state_next = done;
            end
            
            done:
            begin
                done_tick = 1'b1;
                state_next = idle;
            end
            
            default: state_next = idle;
            
        endcase
    end
    
    assign bin = bin_reg;
    
endmodule
