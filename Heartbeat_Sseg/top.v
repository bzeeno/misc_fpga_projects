`timescale 1ns / 1ps

module top(
    input wire clk,
    output wire [3:0] anodes_off,
    output wire [3:0] anode,
    output wire [7:0] cathodes
    );
    
    wire clk72Hz;
    wire [1:0] counter72hz;
    wire [1:0] digit0, digit1, digit2, digit3;

    assign anodes_off = 4'b1111;

    // Clock for heartbeat frequency
    clock_divider_72hz(
        .clk(clk), // 100 MHz
        .divided_clk(clk72Hz)
    );
    // counter for heartbeat frequency
    counter_72hz gen_counter_72hz(
        .clk72Hz(clk72Hz),
        .counter72hz(counter72hz)
    );
    
    // Heartbeat Control    
    heartbeat_control hb_ctl(
        .counter72hz(counter72hz),
        .digit0(digit0),
        .digit1(digit1),
        .digit2(digit2),
        .digit3(digit3)
    );

    // SSEG Control
    sseg_base gen_sseg(
        .clk(clk), // 100MHz
        .digit0(digit0),
        .digit1(digit1),
        .digit2(digit2),
        .digit3(digit3),
        .anode(anode),
        .cathodes(cathodes)
    );


endmodule
