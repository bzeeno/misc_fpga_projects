module counter_72hz(
    input wire clk72Hz,
    output reg [1:0] counter72hz = 0
    );

    always @(posedge clk72Hz)
    begin
        counter72hz <= counter72hz + 1;
        if(counter72hz == 3)
            counter72hz = 0;
    end        

endmodule

