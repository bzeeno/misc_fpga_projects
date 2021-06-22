`timescale 1ns / 1ps
module parking_lot_counter(
    input wire clk, a, b,
    output wire [7:0] anode, cathodes
    );
    
    wire inc=0, dec=0;
    wire [3:0] num_cars;
    
    parking_lot_fsm control_logic (
        .clk(clk), .a(a), .b(b),
        .dec(dec), .inc(inc)
    );
    
    counter car_counter (
        .clk(clk), .dec(dec), .inc(inc),
        .num_cars(num_cars)
    );
    
    sseg_base sseg (
        .clk(clk), // 100MHz
        .num_cars(num_cars),
        .anode(anode),
        .cathodes(cathodes)
    );
    
endmodule
