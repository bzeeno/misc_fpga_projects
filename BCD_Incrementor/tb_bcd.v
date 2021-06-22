`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2020 08:48:34 PM
// Design Name: 
// Module Name: tb_bcd
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


module tb_bcd;

    reg enable;
    wire[11:0] test_out;
    
    bcd_incrementor uut(.en(enable), .result(test_out));

    initial
    begin
        enable = 0;
        # 200;
//        enable = 1;
//        # 200;
//        enable = 1;
//        # 200;
//        enable = 1;
//        # 200;
//        enable = 0;
//        # 200;
    end

endmodule
