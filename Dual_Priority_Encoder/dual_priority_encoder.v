`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2020 02:55:32 AM
// Design Name: 
// Module Name: dual_priority_encoder
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

module priority_encoder
    (
     input wire[11:0] in,
     output reg[3:0] out  
    );
    
    always @*
    begin
            casez(in)
                
                12'b1???????????: out = 4'b1100;              
                12'b01??????????: out = 4'b1011;
                12'b001?????????: out = 4'b1010;
                12'b0001????????: out = 4'b1001;
                12'b00001???????: out = 4'b1000;
                12'b000001??????: out = 4'b0111;    
                12'b0000001?????: out = 4'b0110;
                12'b00000001????: out = 4'b0101;
                12'b000000001???: out = 4'b0100;
                12'b0000000001??: out = 4'b0011;
                12'b00000000001?: out = 4'b0010;
                12'b000000000001: out = 4'b0001;
                12'b000000000000: out = 4'b0000;
    
            endcase
    end
    
endmodule

module dual_priority_encoder(
    input wire[11:0] dual_in,
    output wire[3:0] prior_1, prior_2
    );
    
    reg[11:0] tmp_in;
    
    // Loop twice to get 2 top priority bits
    genvar itr;
    generate
        for (itr = 1 ; itr <= 12; itr = itr+1)
            begin          
                if(itr == 1)
                    begin
                        priority_encoder pe(.in(dual_in), .out(prior_1)); // first run, input is the normal dual_in
                    end
                else
                    begin
                        priority_encoder pe(.in(tmp_in), .out(prior_2)); // 2nd run, input is modified to exclude the previously found prior
                    end
            end
    endgenerate
    
    // when prior_1 or dual_in change, check what prior_1 is and make tmp_in a copy of dual_in, up to but not including that bit
    always @*
        begin
  
            case(prior_1)
                4'b1100: tmp_in = dual_in[10:0];
                4'b1011: tmp_in = dual_in[9:0];
                4'b1010: tmp_in = dual_in[8:0];
                4'b1001: tmp_in = dual_in[7:0];
                4'b1000: tmp_in = dual_in[6:0];
                4'b0111: tmp_in = dual_in[5:0];
                4'b0110: tmp_in = dual_in[4:0];
                4'b0101: tmp_in = dual_in[3:0];
                4'b0100: tmp_in = dual_in[2:0];
                4'b0011: tmp_in = dual_in[1:0];
                4'b0010: tmp_in = dual_in[0];
                default: tmp_in = 12'b000000000000; // if prior_1 is either 0 or 1
            endcase
        
        end

endmodule
