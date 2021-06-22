module cathode_selector(
    input wire [3:0] digit,
    output reg [7:0] cathodes
    );
    
    always @(digit)
    begin
        case(digit)
            4'd0:
                cathodes = 8'b11000000; // zero
            4'd1:
                cathodes = 8'b11111001; // one
            4'd2:
                cathodes = 8'b10100100; // two 
            4'd3:
                cathodes = 8'b10110000; // three
            4'd4:
                cathodes = 8'b10011001; // four 
            4'd5:
                cathodes = 8'b10010010; // five 
            4'd6:
                cathodes = 8'b10000010; // six
            4'd7:
                cathodes = 8'b11111000; // seven
            4'd8:
                cathodes = 8'b10000000; // eight
            4'd9:
                cathodes = 8'b10010000; // nine
            4'd10:
                cathodes = 8'b10100000; // a
            4'd11:
                cathodes = 8'b10000011; // b
            4'd12:
                cathodes = 8'b11000110; // c
            4'd13:
                cathodes = 8'b10100001; // d
            4'd14:
                cathodes = 8'b10000110; // E
            4'd15:
                cathodes = 8'b10001110; // F
            default:
                cathodes = 8'b11000000; // default to 0
        endcase
    end
    
endmodule
