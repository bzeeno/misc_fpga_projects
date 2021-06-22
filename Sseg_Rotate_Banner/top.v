`timescale 1ns / 1ps

module top(
    input wire clk,
    input wire dir,
    input wire en,
    output wire [7:0] anode,
    output wire [7:0] cathodes
    );
    
    wire [39:0] banner = {4'd9,4'd8,4'd7,4'd6,4'd5,4'd4,4'd3,4'd2,4'd1}; // What numbers to display
    wire [31:0] current_disp;
    wire slowClk;
    
    // Slow clock for speed of banner rotation
    slow_clk gen_banner_clk(
        .clk(clk), // 100 MHz
        .divided_clk(slowClk)
    );
    
    // Banner controller. Determines which 8-digits to display
    banner_ctrl gen_banner_controller(
        .en(en),
        .dir(dir),
        .slowClk(slowClk),
        .banner(banner),
        .current_disp(current_disp)
    );
    
    // Display
    sseg_base(
        .clk(clk), // 100MHz
        .current_disp(current_disp),
        .anode(anode),
        .cathodes(cathodes)
    );
    
endmodule
