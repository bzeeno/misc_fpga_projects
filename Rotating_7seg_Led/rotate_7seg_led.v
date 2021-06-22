`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brandon-chan
// 
// Create Date: 05/01/2020 04:14:06 PM
// Design Name: 
// Module Name: rotate_7seg_led
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module rotate_7seg_led(
    input wire en, clk, cw,
    output reg [7:0] cathodes,
    output reg [3:0] always_off_an,
    output reg [3:0] anodes
    );
    
    integer counter = 0;
    wire div_clk;
    
    clock_divider slow_clk(
        .clk(clk), // 450 MHz
        .divided_clk(div_clk)
    );
    
    always @(posedge div_clk)
    begin
        // leave left four digits off
        always_off_an = 4'b1111;
        if(en)
        begin
            case(counter)
                0:
                begin
                    anodes = 4'b0111; // left most digit ON
                    cathodes = 8'b10100011; // top circle
                    if(cw)
                        counter = counter + 1;
                    else
                        counter = 7;
                end
                1:
                begin
                    anodes = 4'b1011; // mid-left digit ON
                    cathodes = 8'b10100011; // top circle
                    if(cw)
                        counter = counter + 1;
                    else
                        counter = 0;
                end
                2:
                begin
                    anodes = 4'b1101; // mid-right digit ON
                    cathodes = 8'b10100011; // top circle
                    if(cw)
                        counter = counter + 1;
                    else
                        counter = 1;
                end
                3:
                begin
                    anodes = 4'b1110; // right most digit ON
                    cathodes = 8'b10100011; // top circle
                    if(cw)
                        counter = counter + 1;
                    else
                        counter = 2;
                end
                4:
                begin
                    anodes = 4'b1110; // right most digit ON
                    cathodes = 8'b10011100; // bottom circle
                    if(cw)
                        counter = counter + 1;
                    else
                        counter = 3;
                end
                5:
                begin
                    anodes = 4'b1101; // mid-right digit ON
                    cathodes = 8'b10011100; // bottom circle
                    if(cw)
                        counter = counter + 1;
                    else
                        counter = 4;
                end
                6:
                begin
                    anodes = 4'b1011; // mid-left digit ON
                    cathodes = 8'b10011100; // bottom circle
                    if(cw)
                        counter = counter + 1;
                    else
                        counter = 5;
                end
                default:
                begin
                    anodes = 4'b0111; // left most digit ON
                    cathodes = 8'b10011100; // bottom circle
                    if(cw)
                        counter = 0;
                    else
                        counter = 6;
                end
            endcase
            
        end
        else
        begin
            counter = 0;
            anodes = 4'b1111;
            cathodes = 8'b11111111;
        end
    end
    
    
endmodule
