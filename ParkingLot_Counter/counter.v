module counter (
    input wire clk, dec, inc,
    output reg [3:0] num_cars
    );

    always @*
    begin
        if(inc)
            num_cars = num_cars + 1;
        else if(dec && num_cars != 0)
            num_cars = num_cars - 1;
    end
 
endmodule