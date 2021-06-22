`timescale 1ns / 1ps

module sseg_base(
    input wire clk, // 100MHz
    input wire [31:0] current_disp,
    output wire [7:0] anode,
    output wire [7:0] cathodes
    );
    
    wire refreshClk; // 10kHz clock
    wire [3:0] refreshCounter; // for toggling anodes
    wire [3:0] digit0, digit1, digit2, digit3, digit4, digit5, digit6, digit7;
    wire [3:0] digitOn;
    
    // Change these digits to whatever you want to display
    // If you want the digits to change based off of switches/buttons
    // then create a new module that takes care of that and outputs the digits.
    assign digit0 = current_disp[3:0];
    assign digit1 = current_disp[7:4];
    assign digit2 = current_disp[11:8];
    assign digit3 = current_disp[15:12];
    assign digit4 = current_disp[19:16];
    assign digit5 = current_disp[23:20];
    assign digit6 = current_disp[27:24];
    assign digit7 = current_disp[31:28];
    
    
    // slow clock to 10KHz for display
    clock_divider gen_clock_divider(
        .clk(clk), // 100 MHz
        .dividedClk(refreshClk)
    );
    
    // Refresh counter for looping through anodes
    refresh_counter gen_refresh_counter(
        .refreshClk(refreshClk),
        .refreshCounter(refreshCounter)
    );
    
    // sync cathode and anodes
    anode_control gen_anode_control(
        .refreshCounter(refreshCounter),
        .anode(anode)
    );
    cathode_control gen_cathode_control(
        .refreshCounter(refreshCounter),
        .digit0(digit0),
        .digit1(digit1),
        .digit2(digit2),
        .digit3(digit3),
        .digit4(digit4),
        .digit5(digit5),
        .digit6(digit6),
        .digit7(digit7),
        .digitOn(digitOn)// which input digit to display
    );
    
    // Cathode selector
    cathode_selector gen_cathode_selector(
        .digit(digitOn),
        .cathodes(cathodes)
    );
    
    
endmodule
