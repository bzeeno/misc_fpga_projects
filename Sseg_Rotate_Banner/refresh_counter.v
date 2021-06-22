module refresh_counter(
    input wire refreshClk,
    output reg [3:0] refreshCounter = 0
    );
    
    always @(posedge refreshClk)
    begin
        refreshCounter <= refreshCounter + 1;
        if(refreshCounter >= 7)
            refreshCounter <= 0;
    end
      
endmodule
