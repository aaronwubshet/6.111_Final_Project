`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2017 04:06:15 PM
// Design Name: 
// Module Name: Color_output
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Color_output(
    input clock,
    input ready,
    input [9:0] hcount,
    input [9:0] vcount,
    input  [2:0] data,
    input [83:0] FFT_color,
    output reg [18:0] address,
    output reg [11:0] rgb
    );
    
/*important register flags*/
reg start_out;
reg start;

    always@(posedge clock) begin
    /*check that we can start reading from BRAM*/
        if(ready) begin 
            start <= 1'b1;             
        end
        
        else if (start) begin
        
            /*wait for end of current frame to start changing address*/
            if(vcount == 523 && hcount > 795) begin
                address <= 3 - (799 - hcount);
                start_out <= 1'b1;                  //now can start!   
            end
        end
        
        /*start forecasting addresses for incoming hcount,vcount*/
        if(start_out) begin
        
            /*check if we need to wrap around */
            if(vcount == 523 && hcount > 795) begin
                address <= 3 - (799 - hcount);
        
            end
            
            /*normal outputting */
            else if(vcount <= 479 && hcount <636) begin
                address <= address + 1;
            end
            
            /*forecasting outside of display screen*/ 
            else if((vcount <= 479 && hcount > 795)) begin 
                address <= address + 1;
            end
        end
        
           
                                 
      /*set color value according to data value*/
                                
        case(data) 
                                    
            3'b001: rgb <= FFT_color[11:0];
            3'b010: rgb <= FFT_color[23:12];
            3'b011: rgb <= FFT_color[35:24];
            3'b100: rgb <= FFT_color[47:36];
            3'b101: rgb <= FFT_color[59:48];
            3'b110: rgb <= FFT_color[71:60];
            3'b111: rgb <= FFT_color[83:72];
            3'b000: rgb <= 12'd0;    
                            
                            
        endcase
               
    end

endmodule
