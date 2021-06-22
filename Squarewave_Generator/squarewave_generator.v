`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2020 05:11:07 AM
// Design Name: 
// Module Name: squarewave_generator
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


module squarewave_generator(
    input wire clk,
    input wire [3:0] m, n,
    output wire w
    );
    
    // signal declaration
    wire [6:0] time_up, time_down; // wires that hold how long to stay high and low 
    reg [6:0] counter = 0; // counter to determine if we're at the point where the signal needs to be switched
    reg out = 1;
    //reg high, low; // registers to determine if w is high or low
    
    always @(posedge clk)
    begin
        
        
        case(out)
            1'b1: // if square wave is high
            begin
                if(counter == time_up) // if we've reached desired high time
                begin
                    out = 0; // set out as opposite (1 -> 0)
                    counter = 0; // reset counter
                end
                counter = counter + 1;
            end
            
            default: // if square wave is low
            begin
                if(counter == time_down) // if we've reached desired low time
                begin
                    out = 1; // set out as opposite (0 -> 1)
                    counter = 0; // reset counter
                end
                counter = counter + 1;
            end
        endcase      
        
    end
    
//    always @(m,n)
//    begin
//        out = 1;
//        #time_up;
//        out = 0;
//        #time_down;
//    end
    
    assign time_up = m*'d5; // with a clock period of 20ns, this comes out to be m*100 ns
    assign time_down = n*'d5;
    assign w = out;
endmodule
