`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2017 06:59:41 PM
// Design Name: 
// Module Name: lev_puls
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


module lev_to_pulse(input clock, input reset, input lev,
                output reg pulse
    );
    
    
reg lev_prev;


    always@(posedge clock)begin
        lev_prev <= lev;
        
        if((!lev_prev) && lev)begin
            pulse <= 1;
        end
       
        else begin
            pulse <= 0;
        end
    
    end
endmodule
