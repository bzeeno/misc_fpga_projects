module parking_lot_fsm(
    input wire clk, a, b,
    output reg dec, inc
    );
    
    reg [1:0] state_reg, state_next;
    
    always @(posedge clk)
        state_reg <= state_next;
    
    always @*
    begin
        state_next = state_reg; // default to keep same state
        // default dec and inc signals to 0
        dec = 0;
        inc = 0;
        case(state_reg)
            2'b00:
            begin                
                if(a==1 && b==1)
                    state_next = 2'b01;
                else
                    state_next = 2'b00;
           end
           2'b01:
            if(a==0 && b==1)
                state_next = 2'b10;
            else if(a==1 && b==0)
                state_next = 2'b11;
          2'b10:
          begin
            dec = 0;
            inc = 1;
            state_next = 2'b00;
          end
          2'b11:
          begin
            dec = 1;
            inc = 0;
            state_next = 2'b00;
          end
        endcase
    end
    
endmodule
