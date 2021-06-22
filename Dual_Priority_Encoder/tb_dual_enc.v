`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2020 05:08:41 AM
// Design Name: 
// Module Name: tb_dual_enc
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


module tb_dual_enc;

    // signal dec
    reg [11:0] test_in;
    wire [3:0] test_out1, test_out2;
    
    // instantiate circuit under test
    
    dual_priority_encoder uut (.dual_in(test_in), .prior_1(test_out1), .prior_2(test_out2));
    
    initial
    begin
        test_in = 12'b110000000000;
        #100;
        test_in = 12'b010000000001;
        #100;
        test_in = 12'b000000000011;
        #100;
        test_in = 12'b000000000000;
        #100;
        test_in = 12'b000010000000;
        #100;
        test_in = 12'b000010000100;
        #100;
        test_in = 12'b111111111111;
        #100;
    end

endmodule
