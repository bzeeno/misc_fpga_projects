module anode_control(
    input wire [3:0]refreshCounter,
    output reg [7:0] anode = 0
    );
    
    always @(refreshCounter)
    begin 
        case(refreshCounter)
            4'd0: anode = 8'b11111110; // right-most digit ON
            4'd1: anode = 8'b11111101; // mid-right digit ON
            4'd2: anode = 8'b11111011; // mid-left digit ON
            4'd3: anode = 8'b11110111; // left-most digit ON
            4'd4: anode = 8'b11101111; // right-most digit ON
            4'd5: anode = 8'b11011111; // mid-right digit ON
            4'd6: anode = 8'b10111111; // mid-left digit ON
            4'd7: anode = 8'b01111111; // left-most digit ON
        endcase
    end
    
endmodule
