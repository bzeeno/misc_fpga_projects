module cathode_control(
    input wire [3:0] refreshCounter,
    input wire [3:0] digit0,
    input wire [3:0] digit1,
    input wire [3:0] digit2,
    input wire [3:0] digit3,
    input wire [3:0] digit4,
    input wire [3:0] digit5,
    input wire [3:0] digit6,
    input wire [3:0] digit7,
    output reg [3:0] digitOn // which input digit to display
    );
    
    always @(refreshCounter)
    begin 
        case(refreshCounter)
            4'd0: digitOn = digit0; // Determine which digit to display
            4'd1: digitOn = digit1; // depending on which anode is being displayed
            4'd2: digitOn = digit2; // 
            4'd3: digitOn = digit3; // 
            4'd4: digitOn = digit4; // 
            4'd5: digitOn = digit5; // 
            4'd6: digitOn = digit6; // 
            4'd7: digitOn = digit7; // 
        endcase
    end
    
    
endmodule
