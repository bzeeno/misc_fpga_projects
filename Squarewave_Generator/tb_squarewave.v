`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2020 06:23:45 PM
// Design Name: 
// Module Name: tb_squarewave
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


module tb_squarewave;
    localparam T = 20;
    reg clk;
    reg [3:0] up_time, down_time;
    wire out;
    
    
    always
    begin
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end
    
    squarewave_generator uut(.clk(clk), .m(up_time), .n(down_time), .w(out));
    
    initial
    begin
        // test_1
        up_time = 4'b0001;
        down_time = 4'b0001;
        # 200;
        // test_2
        up_time = 4'b0101;
        down_time = 4'b0001;
        # 600;
        // test_3
//        up_time = 4'b0001;
//        down_time = 4'b0101;
//        # 200;
        // test_4
//        up_time = 4'b1111;
//        down_time = 4'b1111;
//        # 200;
        $stop;
    end

endmodule
