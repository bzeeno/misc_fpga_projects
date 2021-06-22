`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2020 07:58:30 PM
// Design Name: 
// Module Name: bcd_incrementor
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


module bcd_incrementor(
    input wire en,
    output reg[11:0] result
    );
    //localparam B0=0, B1=0, B2=0;
    reg[3:0] B0, B1, B2;

    always @* begin
        while(en) begin 
            if(B0==4'b1001) begin // if B0 is 9
                B1 = B1 + 1;
                B0 = 4'b0000;
            end else begin
                B0 = B0 + 1;      // increment B0 as long as it's not 9
            end
            if(B1==4'b1010) begin // if B1 is 10
                B2 = B2 + 1;
                B1 = 4'b0000;
            end
            if(B2==4'b1010) begin // if B2 is 10 then reset
                B0 = 4'b0000;
                B1 = 4'b0000;
                B2 = 4'b0000;
            end
            result = {B2,B1,B0};
            //# 100;
        end
    end
endmodule
