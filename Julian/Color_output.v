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
    input [9:0] hcount,
    input [9:0] vcount,
    input  [2:0] data,
    input [83:0] FFT_color,
    output reg [18:0] address,
    output reg [11:0] rgb
    );
    
//reg [2:0] data_reg;

    always@(posedge clock) begin
    
        /*register data value */ 
        //data_reg <= data; 
        
        /*calculate address to index into BRAM */
        
        if(vcount == 479 & hcount == 486) begin     //Look into this! 
            address <= 19'd0;                       //check if were at the end of a frame and need to wrap around 
        end 
        
        else begin 
        address <= vcount*640 + hcount + 3;          //include offset to account for registered values
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
