`timescale 1ns / 1ps

module debunce_fsmd(
    input wire clk, reset,
    input wire sw,
    output reg db_level
    );
    
    // symbolic states
    localparam [1:0]
               checkIf1 = 2'b00,
               wait20ms    = 2'b01,
               checkIf0 = 2'b10;
    
    // number of counter bits (2^N *20ns = 40ms)
    localparam N=21;        
    
    reg [1:0] state_reg, state_next; // state registers
    reg [N-1:0] q_reg; // counter reg
    wire [N-1:0] q_next; // counter next wire
    reg q_load, q_dec; // load q, decrement q
    
    // update state and q
    always @(posedge clk, posedge reset)
    begin
        if(reset)
        begin
            state_reg <= checkIf1;
            q_reg <= 0;
        end
        else
        begin
            state_reg <= state_next;
            q_reg <= q_next;
        end
    end
    
    // FSMD data path
    assign q_next = (q_load) ? {N{1'b1}} :
                    (q_dec)  ? q_reg - 1  :
                               q_reg;
    
    // FSMD control path
    always @*
    begin
        // set defualt values
        state_next = state_reg;
        q_load = 1'b0; // don't load counter
        q_dec = 1'b0; // don't decrement counter
        case(state_reg)
            checkIf1:
            begin
                db_level=1'b0;
                if(sw) // if detect switch
                begin
                    db_level=1'b1; // set to high
                    q_load = 1'b1; // load counter
                    state_next = wait20ms; // wait 20ms
                end
            end
            
            wait20ms:
            begin
                q_dec = 1'b1;
                if(q_reg == 0)
                begin
                    if(db_level) // if high
                        state_next = checkIf0; // start checking for falling edge
                    else
                        state_next = checkIf1; // start checking for rising edge
                end
            end
            
            checkIf0:
            begin
                db_level=1'b1;
                if(~sw)
                begin
                    db_level = 1'b0; // set to low
                    q_load = 1'b1; // load counter
                    state_next = wait20ms; // wait 20ms
                end
            end
        endcase
    end
    
endmodule
