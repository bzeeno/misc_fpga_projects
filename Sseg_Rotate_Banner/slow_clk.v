module slow_clk(
    input wire clk, // 100 MHz
    output reg divided_clk  = 0
    );
  
      localparam div_val = 49999999;//694443; // 1Hz
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
