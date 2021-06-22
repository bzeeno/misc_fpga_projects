`timescale 1ns / 1ps
// counter based
module clock_divider_72hz(
    input wire clk, // 100 MHz
    output reg divided_clk  = 0
    );
    
    localparam div_val = 4166666;//694443; // 72Hz
    // div_val = [clk / (2*desired freq)] - 1
    
    integer counter = 0;
    
    always @(posedge clk)
    begin
        if (counter == div_val)
        begin
            counter <= 0;
            divided_clk <= ~divided_clk;
        end
        
        else
        begin
            counter <= counter + 1;
            divided_clk <= divided_clk;
        end
        
    end
    
endmodule
