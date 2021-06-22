// counter based
module clock_divider(
    input wire clk, // 100 MHz
    output reg dividedClk  = 0
    );
    
    localparam div_val = 4999; // 10KHz
    // div_val = [clk / (2*desired freq)] - 1
    
    integer counter = 0;
    
    always @(posedge clk)
    begin
        if (counter == div_val)
        begin
            counter <= 0;
            dividedClk <= ~dividedClk;
        end
        
        else
        begin
            counter <= counter + 1;
            dividedClk <= dividedClk;
        end
        
    end
    
endmodule
