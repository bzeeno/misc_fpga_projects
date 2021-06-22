module banner_ctrl(
    input wire en,
    input wire dir,
    input wire slowClk,
    input wire [39:0] banner,
    output reg [31:0] current_disp
    );
    integer counter = 0;
    
    always @(posedge slowClk)
    begin
        if(!en)
            current_disp <= 32'b0;
        else
        begin
            case(counter)
                0:
                begin
                    current_disp <= banner[31:0];
                    if(dir)                       
                        counter <= counter + 1;
                    else
                        counter <= 9;
                end
                1:
                begin
                    current_disp <= {banner[27:0],banner[39:36]}; // put last num in banner in first position
                    if(dir)
                        counter <= counter + 1;
                    else
                        counter <= counter - 1;
                end
                2:
                begin
                    current_disp <= {banner[23:0],banner[39:32]};
                    if(dir)
                        counter <= counter + 1;
                    else
                        counter <= counter - 1;
                end
                3:
                begin
                    current_disp <= {banner[19:0],banner[39:28]};
                    if(dir)
                        counter <= counter + 1;
                    else
                        counter <= counter - 1;    
                end
                4:
                begin
                    current_disp <= {banner[15:0],banner[39:24]};
                    if(dir)
                        counter <= counter + 1;
                    else
                        counter <= counter - 1;
                end
                5:
                begin
                    current_disp <= {banner[11:0],banner[39:20]};
                    if(dir)
                        counter <= counter + 1;
                    else
                        counter <= counter - 1;
                end
                6:
                begin
                    current_disp <= {banner[7:0],banner[39:16]};
                    if(dir)
                        counter <= counter + 1;
                    else
                        counter <= counter - 1;
                end
                7:
                begin
                    current_disp <= {banner[3:0],banner[39:12]};
                    if(dir)
                        counter <= counter + 1;
                    else
                        counter <= counter - 1;
                end
                8:
                begin
                    current_disp <= banner[39:8];
                    if(dir)
                        counter <= counter + 1;
                    else
                        counter <= counter - 1;
                end
                9:
                begin
                    current_disp <= banner[35:4];
                    if(dir)
                        counter <= 0;
                    else
                        counter <= counter - 1;
                end
                default:
                    current_disp <= banner[31:0];
            endcase
        end
    end
endmodule
