module heartbeat_control(
    input wire [1:0] counter72hz,
    output reg [1:0] digit0,
    output reg [1:0] digit1,
    output reg [1:0] digit2,
    output reg [1:0] digit3
    );
    
    always @(counter72hz)
    begin 
        case(counter72hz)
            2'b00:
            begin
                digit0 = 2'b00;
                digit1 = 2'b10;
                digit2 = 2'b01;
                digit3 = 2'b00;
            end 
            2'b01:
            begin
                digit0 = 2'b00;
                digit1 = 2'b01;
                digit2 = 2'b10;
                digit3 = 2'b00;
            end 
            2'b10:
            begin
                digit0 = 2'b01;
                digit1 = 2'b00;
                digit2 = 2'b00;
                digit3 = 2'b10;
            end 
        endcase 
    end 
endmodule 
