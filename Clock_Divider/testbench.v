`timescale 1ns / 1ps

module testbench;

    reg clk = 0;
    wire divided_clk;
    
    clock_divider uut(
        .clk(clk), 
        .divided_clk(divided_clk) 
        );

    always #1.11 clk = ~clk; // flip signal every 1.11 ns => 2.22ns period => 450MHz
    
endmodule
